dotfiles


## Gentoo

Make sure PKG_MGR is set to 'emerge' and flags are reset:

```console
make PKG_MGR=emerge PKG_FLAGS="" check
```

Then, we can install the packages from the provided pkglist:

```console
make PKG_MGR=emerge PKG_FLAGS="" pkgs
```

