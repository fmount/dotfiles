SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c

PKG_MGR := pkg_add
PKG_FLAGS := -l
ROOT := doas

CURDIR := $(HOME)/dotfiles
CONFIG := $(HOME)/.local
BACKUP_DIR := $(HOME)/devnull
GPG := gpg2

.include <bsd.mk>
