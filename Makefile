SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c

PKG_MGR := pacman
PKG_FLAGS := -Sy --noconfirm
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
pkgs: ## Install the provided packages (pkglist)
	@if [ -e pkglist ]; then \
		while read -r pkg; do $(ROOT) $(PKG_MGR) $(PKG_FLAGS) "$$pkg"; done < pkglist; \
	fi;


.PHONY: dotfiles
dotfiles: dot config ## Install the dotfiles

.PHONY: dot
dot:  ## Install the $(HOME) dotfiles (excluding config)
	# (STAGE 1) add aliases for dotfiles that are expected to be found in $(HOME) dir
	@for file in $(shell find $(CURDIR) -name ".*" ! -name ".gitignore" \
		! -name ".travis.yml" ! -name ".git*" ! -name ".*.swp" \
		! -name ".config" ! -name "*.i3*"); do \
		f=$$(basename $$file); \
		echo "Processing element: $$file"; \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
	
	ifeq ($(RPI),1)
		# (STAGE 2) Configure i3
		@echo "[i3] Linking $(CURDIR)/i3 $(CONFIG)/i3"
		ln -sfn $(CURDIR)/i3 $(CONFIG)/i3
	endif


.PHONY: config
config: ## Install the .config dir
	# Create .config dir if it doesn't exist
	CONFIG_DIR_EXIST=$(shell [ ! -d $(HOME)/.config ] && mkdir $(HOME)/.config)

	# (STAGE 3) Configure all .config dotfiles
	@echo "[dunst] Linking $(CURDIR)/.config/dunstrc $(CONFIG)/dunstrc"
	ln -sfn $(CURDIR)/.config/dunstrc $(CONFIG)/dunstrc
	@echo "[redshift] Linking $(CURDIR)/.config/redshift.conf $(CONFIG)/redshift.conf"
	ln -sfn $(CURDIR)/.config/redshift.conf $(CONFIG)/redshift.conf

	# (STAGE 4) Configure .config
	@for dir in $(shell find $(CURDIR)/.config -maxdepth 1 -type d ! -name ".config"); do \
		if [ -d $(HOME)/.config/$$(basename $$dir) ]; then \
			echo "[$$(basename $$dir)] ...BACKUP"; \
			$(call backup_old_config, $(HOME)/.config/$$(basename $$dir)); \
		fi; \
		ln -sfn $$dir $(CONFIG)/$$(basename $$dir); \
	done


.PHONY: fonts
fonts: ## Copy fonts on /usr/share/fonts
	$(ROOT) cp $(CURDIR)/archlinux/*.ttf /usr/share/fonts/TTF
	$(ROOT) fc-cache -fv


.PHONY: gpg
gpg: ## Download the public gpg keys from github
	gpg --fetch-keys https://github.com/fmount.gpg


.PHONY: ssh
ssh: ## Download public ssh keys from github
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

.PHONY: update
update: ## Just update dotfiles
	bash -c $(CURDIR)/scripts/dotupdate.sh

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile  | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
