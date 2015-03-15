# arch-config

Some configuration files for my system.

This structure is intented to be managed with tools like [*Gnu Stow*](http://www.gnu.org/software/stow/).
Generally, you have to install gnu stow and then you run:

**stow ${PKGNAME}-${PKGVERSION}**

This command generates symbolic links to all the programs' files into the appropriate folders.
For example, let's say you want to manage the configuration for _ZSH_, _VIM_ and _i3wm_:  zsh has a couple files in the top-level directory; VIM typically has your .vimrc file on the top-level and a .vim directory; and i3 has files in ${HOME}/.i3 and other configs in the ${HOME}.
So, your home directory looks like this:

```
	home/
		<user>/
			.config/
				terminator/
				... (some files and folders)
				... (some files and folders)
			.vim/
				... (some files and folders)
			.i3/
				... (some files and folders)
			.zshrc
			.vimrc
```

You would then create a config  subdirectory and move all the files there:

```
	home/
		<user>/
			arch-config/
				zsh/
					.zshrc
					... (some files and folders)
				terminator/
					.config/
						... (some files and folders)
				vim/
					.vim/
						... (some files and folders)
					.vimrc
				i3/
					.i3/
						... (some files and folders)
					.i3status.conf
```

Then, perform the following commands:

```
$ cd ~/arch-config
$ stow zsh
$ stow i3
$ stow vim
...
...

```

Now all your config files (well, symbolic links to them) are all in the correct place; all of your configuration files  are always available in your arch-config directory, but if you don't need the configuration for one program, you simply don't Stow it and thus it does not clutter your home directory.

