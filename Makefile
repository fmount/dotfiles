SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c

PKG_MGR := yay
PKG_FLAGS := -Sy --noconfirm --needed
ROOT := sudo -E

CURDIR := $(HOME)/dotfiles
CONFIG := ~/.config
BACKUP_DIR := $(HOME)/devnull

# Set this flag if configuring rPI
RPI := 0

define backup_old_config
    mv $(1) $(BACKUP_DIR)
endef


.PHONY: all
all: check pkgs fonts dotfiles gpg ssh


.PHONY: check
check:  ## Check if the package manager is available
	@which $(PKG_MGR) > /dev/null
	@echo "[C----o-] I can eat packages";


.PHONY: pkgs
pkgs:  ## Install the provided packages (pkglist)
	@if [ -e $(CURDIR)/files/pkglist ]; then \
		$(PKG_MGR) $(PKG_FLAGS) $(< $(CURDIR)/files/pkglist); \
	fi; \


.PHONY: dotfiles
dotfiles: dot config update ## Install the dotfiles

.PHONY: dot
dot:  ## Install the $(HOME) dotfiles (excluding config)
	
	# (STAGE 1) add aliases for dotfiles that are expected to be found in $(HOME) dir
	@for file in $(shell find $(CURDIR) -name ".*" ! -name ".gitignore" \
		! -name ".travis.yml" ! -name ".git*" ! -name ".*.swp" \
		! -name ".config" ! -name "*.i3*" ! -path "*.vim/plugged/*" \
		! -path "*.config/nvim/plugged/*"); do \
		f=$$(basename $$file); \
		echo "Processing element: $$file"; \
		ln -sfn $$file $(HOME)/$$f; \
	done; \


.PHONY: config
config: ## Install the .config dir
	# Create .config dir if it doesn't exist
	$(shell [ ! -d $(HOME)/.config ] && mkdir $(HOME)/.config)

	# (STAGE 3) Configure .config
	@for item in $(shell find $(CURDIR)/.config -maxdepth 1 ! -name ".config"); do \
		if [ -d $(HOME)/.config/$$(basename $$item) ]; then \
			echo "[$$(basename $$item)] ...BACKUP"; \
			$(call backup_old_config, $(HOME)/.config/$$(basename $$item)); \
		fi; \
		echo "[$$(basename $$item)] Linking $$item $(CONFIG)/$$(basename $$item)"; \
		ln -sfn $$item $(CONFIG)/$$(basename $$item); \
	done
	
	# NVIM
	$(shell [ ! -d $(CONFIG)/nvim ] && mkdir -p $(CONFIG)/nvim)
	@echo "[NVIM] Linking $(CURDIR)/nvim $(CONFIG)/"
	ln -sfn $(CURDIR)/nvim $(CONFIG)/
	
ifeq ($(RPI), 0)
	$(shell [ ! -d $(CONFIG)/i3 ] && mkdir -p $(CONFIG)/i3)

	@echo "[i3] Linking $(CURDIR)/i3 $(CONFIG)/"
	ln -sfn $(CURDIR)/i3 $(CONFIG)/
endif

.PHONY: fonts
fonts: ## Copy fonts on /usr/share/fonts
	$(ROOT) cp $(CURDIR)/files/*.ttf /usr/share/fonts/TTF
	$(ROOT) fc-cache -fv

.PHONY: git
git: ## Copy git config in $HOME dir
	@echo "copy git files"
	$(shell [ ! -d $(CONFIG)/gitconfig ] && mkdir -p $(CONFIG)/gitconfig)

	@for file in $(shell find $(CURDIR)/git -name ".*"); do \
		f=$$(basename $$file); \
		echo "Applying git config: $$file"; \
		if [[ "$$f" =~ ".gitconfig-" ]]; then \
			cp $(CURDIR)/git/$$f $(CONFIG)/gitconfig; \
		else \
			cp $(CURDIR)/git/$$f $(HOME); \
		fi; \
	done

.PHONY: gpg
gpg: ## Download the public gpg keys from github
	gpg --fetch-keys https://github.com/fmount.gpg

.PHONY: ssh
ssh: ## Download public ssh keys from github
	$(shell [ -d $(HOME)/.ssh ] && mkdir -p $(HOME)/.ssh)
	curl https://github.com/fmount.keys >> ~/.ssh/authorized_keys

.PHONY: test
test: shellcheck ## Runs all the tests on the files in the repository.
	# if this session isn't interactive, then we don't want to allocate a
	# TTY, which would fail, but if it is interactive, we do want to attach
	# so that the user can send e.g. ^C through.
	INTERACTIVE := $(shell [ -t 0 ] && echo 1 || echo 0)
	ifeq ($(INTERACTIVE), 1)
		DOCKER_FLAGS += -t
	endif

.PHONY: shellcheck
shellcheck: ## Runs the shellcheck tests on the scripts.
	$(ROOT) docker run --rm -i $(DOCKER_FLAGS) \
		--name df-shellcheck \
		-v $(CURDIR):/usr/src:ro \
		--workdir /usr/src \
		r.j3ss.co/shellcheck ./test.sh

.PHONY: systemd
systemd: ## Update $(HOME) user systemd units
	@echo "Applying user systemd unit"
	@if [ ! -d $(HOME)/.config/systemd/user ]; then \
		mkdir -p $(HOME)/.config/systemd/user; \
	fi; \
	for file in $(shell find $(CURDIR)/systemd/user -name "*.service"); do \
		f=$$(basename $$file); \
		echo "Applying systemd service: $$file"; \
		cp $$file $(HOME)/.config/systemd/user; \
		systemctl --user enable $$f; \
	done

.PHONY: neomutt
neomutt: ## Update $(HOME) user mail config
	@if [ -z "$(shell ls -A $(CURDIR)/neomutt)" ]; then \
		echo "Please import neomutt submodule"; \
		exit 1; \
	fi;
ifeq ($(RPI), 0)
	@echo "[neomutt] Linking $(CURDIR)/neomutt $(CONFIG)/"
	ln -sfn $(CURDIR)/neomutt $(CONFIG)/
	@echo "[neomutt] Applying systemd unit files";
	@for file in $(shell find $(CURDIR)/neomutt/systemd/user -name "*.service" 2>/dev/null); do \
		f=$$(basename $$file); \
		echo "Applying systemd service: $$file"; \
		cp $$file $(HOME)/.config/systemd/user; \
		systemctl --user enable $$f; \
	done
	@for dir in $(shell find $(CURDIR)/neomutt/systemd/user -name "*.d" 2>/dev/null); do \
		echo "Applying systemd override: $$(basename $$dir)"; \
		cp -R $$dir $(HOME)/.config/systemd/user/; \
	done
endif


.PHONY: update
update: ## Just update dotfiles
	bash -c $(CURDIR)/scripts/dotupdate.sh

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile  | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
