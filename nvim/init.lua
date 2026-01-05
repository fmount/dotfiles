-- init.lua

-- source a vimscript file
vim.cmd('source ~/.config/nvim/vimrc/init.vim')

vim.g.startify_custom_header = ''
vim.keymap.set('n', '<leader>cc', '<cmd>ClaudeCode<CR>', { desc = 'Toggle Claude Code' })
