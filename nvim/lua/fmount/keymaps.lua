local telescope = require('telescope.builtin')
local keymap = vim.keymap.set

-- Telescope builtins
keymap('n', '<leader>ff', telescope.find_files, { desc = 'Find files' })
keymap('n', '<leader>fg', telescope.live_grep, { desc = 'Live grep' })
keymap('n', '<leader>b', telescope.buffers, { desc = 'Buffers' })
keymap('n', '<leader>fh', telescope.help_tags, { desc = 'Help tags' })
keymap('n', '<leader>fr', telescope.lsp_references, { desc = 'LSP references' })

-- Custom extensions
keymap('n', '<leader>vf', function()
  require('fmount.telescope').search_dotfiles({ hidden = true })
end, { desc = 'Search dotfiles' })

keymap('n', '<leader>vn', function()
  require('fmount.notes').search_notes({ hidden = false })
end, { desc = 'Search notes' })

keymap('n', '<leader>vd', function()
  require('fmount.notes').delete_note({ hidden = false })
end, { desc = 'Delete note' })

keymap('n', '<leader>vp', function()
  require('telescope').extensions.project.project({ display_type = 'full' })
end, { desc = 'Projects' })

-- Diagnostics
keymap('n', '<leader>do', vim.diagnostic.open_float, { desc = 'Open diagnostic' })
keymap('n', '<leader>dn', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
keymap('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
keymap('n', '<leader>cc', '<cmd>ClaudeCode<CR>', { desc = 'Toggle Claude Code' })
