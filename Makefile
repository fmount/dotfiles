SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c

PKG_MGR := pacman
PKG_FLAGS := -Sy --noconfirm
STOW := stow
ROOT := sudo

CURDIR := /home/fmount/dotfiles

.PHONY: all
all: dotfiles

.PHONY: check
check:  ## Check if the package manager is available
		@which $(PKG_MGR) > /dev/null

.PHONY: pkgs
pkgs: ## Install the packages provided
	@if [ -e pkglist ]; then \
		while read -r pkg; do $(ROOT) $(PKG_MGR) $(PKG_FLAGS) "$$pkg"; done < pkglist; \
	fi;

.PHONY: dotfiles
dotfiles: ## Installs the dotfiles.
	# add aliases for dotfiles that are expected to be found in the $(HOME) dir
	@for file in $(shell find $(CURDIR) -name ".*" ! -name ".gitignore" \
		! -name ".travis.yml" ! -name ".git" ! -name ".*.swp" ! -name ".gnupg" \
		! -name ".config" ! -name ".zsh" ! -name ".vim"); do \
		f=$$(basename $$file); \
		echo "Processing file: $$file"; \
		ln -sfn $$file /tmp/$$f; \
	done; \

	@for dir in $(shell find $(CURDIR) -links 2 -type d -name ".*" ! -name ".git"); do \
		echo "LINKING: $$dir in $(HOME)/$$(basename $$dir)"; \
	done; \

.PHONY: gpg
gpg: ## Download the public gpg keys from keyserver
	@echo "TODO: Download gpg keys from keyserver"

.PHONY: ssh
ssh: ## Download public ssh keys
	@echo "TODO: Download ssh keys"


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
	docker run --rm -i $(DOCKER_FLAGS) \
		--name df-shellcheck \
		-v $(CURDIR):/usr/src:ro \
		--workdir /usr/src \
		r.j3ss.co/shellcheck ./test.sh

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile  | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'