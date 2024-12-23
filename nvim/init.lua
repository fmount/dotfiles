-- init.lua

-- source a vimscript file
vim.cmd('source ~/.config/nvim/vimrc/init.vim')

-- colours and fonts
vim.opt.background = 'dark'
vim.cmd('colorscheme jellybeans')
vim.cmd('syntax enable')
vim.o.colorcolumn = '80'
