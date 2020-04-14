Configure neomutt
===

The neomutt related config which can be pushed via Makefile
belongs to another private repo (cause sensitive info are
contained).
After the repo is added as a submodule into the main
dotfiles tree, the following will be found under "neomutt"
dir:

.
├── autistici
├── dracula.muttrc
├── gpg.rc
├── mailboxes
├── neomuttrc
├── neomuttrc.alias
├── systemd
│   └── user
│       ├── default.target.wants
│       │   ├── gpg-agent.service
│       │   └── offlineimap-oneshot@autistici.service
│       ├── gpg-agent-browser.socket
│       ├── gpg-agent-extra.socket
│       ├── gpg-agent.service
│       ├── gpg-agent.socket
│       ├── gpg-agent-ssh.socket
│       ├── offlineimap-oneshot@autistici.service.d
│       │   └── override.conf
│       └── offlineimap-oneshot@autistici.timer.d
│           └── override.conf
└── warsaw.muttrc

Then, running:

    $ make neomutt

will generate the whole config into the right .config tree.
