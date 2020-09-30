.PHONY: all
all: check pkgs fonts dotfiles gpg ssh

.PHONY: check
check:  ## Check if the package manager is available
	@which $(PKG_MGR) > /dev/null
	@echo "[C----o-] I can eat packages";

.PHONY: pkgs
pkgs:  ## Install the provided packages (pkglist)
	@if [ -e $(CURDIR)/files/pkglist.openbsd ]; then \
		$(ROOT) $(PKG_MGR) $(PKG_FLAGS) $(CURDIR)/files/pkglist.openbsd; \
	fi; \

.PHONY: dotfiles
dotfiles: dot config update ## Install the dotfiles

.PHONY: dot
dot:  ## Install the $(HOME) dotfiles (excluding config)
	
	@for file in `find ${CURDIR} -name ".*" ! -name ".gitignore" \
		! -name ".travis.yml" ! -name ".git*" ! -name ".*.swp" \
		! -name ".config" ! -name "*.i3*" ! -path "*.vim/plugged/*" \
		! -path "*.config/nvim/plugged/*"`; do \
		f=$$(basename $$file); \
		echo "Processing element: $$file"; \
		ln -sfn $$file ${HOME}/$$f; \
	done; \

.PHONY: config
config: ## Install the ${CONFIG} dir
	
	@if [ ! -d ${CONFIG} ]; then \
		mkdir -p ${CONFIG}; \
	fi

	@for item in `find ${CURDIR}/.config -maxdepth 1 ! -name ".config"`; do \
		if [ -d ${CONFIG}/`basename $item` ]; then \
			echo "[$$(basename $$item)] ...BACKUP"; \
		fi; \
		echo "[$$(basename $$item)] Linking $$item $(CONFIG)/$$(basename $$item)"; \
		ln -sfn $$item $(CONFIG)/$$(basename $$item); \
	done
	
	@if [ ! -d ${CONFIG}/nvim ]; then \
		mkdir -p ${CONFIG}/nvim; \
	fi
	@echo "[NVIM] Linking $(CURDIR)/nvim $(CONFIG)/"
	ln -sfn $(CURDIR)/nvim $(CONFIG)/
	
.PHONY: fonts
fonts: ## Copy fonts on $(HOME)/.local/share/fonts
	mkdir -p $(HOME)/.local/share/fonts
	cp $(CURDIR)/files/*.ttf $(HOME)/.local/share/fonts/
	fc-cache -fv

.PHONY: git
git: ## Copy git config in $HOME dir
	@echo "copy git files"

	@if [ ! -d ${CONFIG}/gitconfig ]; then \
		mkdir -p ${CONFIG}/gitconfig; \
	fi

	@for file in `find ${CURDIR}/git -name ".*"`; do \
		f=$$(basename $$file); \
		echo "Applying git config: $$file"; \
		if [[ "$$f" == *".gitconfig-"* ]]; then \
			cp ${CURDIR}/git/$$f ${CONFIG}/gitconfig; \
		else \
			cp ${CURDIR}/git/$$f $(HOME); \
		fi \
	done

.PHONY: gpg
gpg: ## Download the public gpg keys from github
	$(GPG) --fetch-keys https://github.com/fmount.gpg

.PHONY: ssh
ssh: ## Download public ssh keys from github
	mkdir -p $(HOME)/.ssh
	curl https://github.com/fmount.keys >> ~/.ssh/authorized_keys

.PHONY: shellcheck
shellcheck: ## Runs the shellcheck tests on the scripts.
	$(SHELL) $(CURDIR)/test.sh

.PHONY: update
update: ## Just update dotfiles
	$(SHELL) -c $(CURDIR)/scripts/dotupdate.sh

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*[[:space:]]+## .*$$' bsd.mk | sort | awk 'BEGIN {FS = ":.*[[:space:]]+## "}; {printf "\033[1;36m%-30s \033[0m%s\n",$$1,$$2}'
