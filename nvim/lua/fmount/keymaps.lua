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

-- Legacy keymaps from init.vim

-- Windows navigation
keymap('n', '<C-Down>', ':wincmd j<CR>', { desc = 'Move to window below' })
keymap('n', '<C-Left>', ':wincmd h<CR>', { desc = 'Move to window left' })
keymap('n', '<C-Right>', ':wincmd l<CR>', { desc = 'Move to window right' })
keymap('n', '<C-Up>', ':wincmd k<CR>', { desc = 'Move to window above' })

-- Copy/Paste/Cut
keymap('v', '<C-C>', '"+y', { desc = 'Copy to clipboard' })
keymap('v', '<C-V>', '"+gP', { desc = 'Paste from clipboard' })
keymap('v', '<C-X>', '"+x', { desc = 'Cut to clipboard' })

-- Disable arrow keys
keymap('n', '<Up>', '<nop>', { desc = 'Disabled' })
keymap('n', '<Down>', '<nop>', { desc = 'Disabled' })
keymap('n', '<Left>', '<nop>', { desc = 'Disabled' })
keymap('n', '<Right>', '<nop>', { desc = 'Disabled' })
keymap('i', '<Up>', '<nop>', { desc = 'Disabled' })
keymap('i', '<Down>', '<nop>', { desc = 'Disabled' })
keymap('i', '<Left>', '<nop>', { desc = 'Disabled' })
keymap('i', '<Right>', '<nop>', { desc = 'Disabled' })
keymap('n', '<F1>', '<Nop>', { desc = 'Disabled' })
keymap('n', '<C-F1>', '<Nop>', { desc = 'Disabled' })

-- ESC with jj
keymap('i', 'jj', '<Esc>', { desc = 'Exit insert mode' })

-- Buffer navigation
keymap('n', '<C-N>', ':bnext!<CR>', { desc = 'Next buffer' })
keymap('n', '<C-P>', ':bprevious!<CR>', { desc = 'Previous buffer' })

-- Function key mappings (F2, F3, F6 are handled by lazy.nvim plugin keys)
keymap('n', '<F4>', '<Esc>:set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>', { desc = 'Toggle spell check' })
keymap('i', '<F4>', '<Esc>:set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>i', { desc = 'Toggle spell check' })
keymap('n', '<F5>', '<Esc>:redraw!<CR>', { desc = 'Redraw screen' })
keymap('i', '<F5>', '<Esc>:redraw!<CR>', { desc = 'Redraw screen' })

-- Windows Resizing
keymap('n', '<', ':vertical resize +5<CR>', { desc = 'Increase window width' })
keymap('n', '>', ':vertical resize -5<CR>', { desc = 'Decrease window width' })

-- Movement tricks
keymap('n', '<C-k>', '<PageUp>', { desc = 'Page up' })
keymap('n', '<C-j>', '<PageDown>', { desc = 'Page down' })
keymap('n', 'K', '10k', { desc = 'Move 10 lines up' })
keymap('n', 'H', '^', { desc = 'Go to beginning of line' })
keymap('n', 'L', '$', { desc = 'Go to end of line' })

-- Font resize (for GUI)
local fontsize = 12
local function adjust_font_size(amount)
  fontsize = fontsize + amount
  vim.cmd("GuiFont! NeoSpleen:h" .. fontsize)
end

keymap('n', '<C-ScrollWheelUp>', function() adjust_font_size(1) end, { desc = 'Increase font size' })
keymap('n', '<C-ScrollWheelDown>', function() adjust_font_size(-1) end, { desc = 'Decrease font size' })
keymap('i', '<C-ScrollWheelUp>', function() adjust_font_size(1) end, { desc = 'Increase font size' })
keymap('i', '<C-ScrollWheelDown>', function() adjust_font_size(-1) end, { desc = 'Decrease font size' })

-- VIM-NOTES mappings
keymap('n', '<Leader>ni', '(note-new-cbox-inline)', { desc = 'New inline checkbox' })
keymap('i', '<Leader>ni', '(note-new-cbox-inline)', { desc = 'New inline checkbox' })
keymap('n', '<Leader>no', '(note-new-cbox-below)', { desc = 'New checkbox below' })
keymap('i', '<Leader>no', '(note-new-cbox-below)', { desc = 'New checkbox below' })
keymap('n', '<Leader>nO', '(note-new-cbox-above)', { desc = 'New checkbox above' })
keymap('i', '<Leader>nO', '(note-new-cbox-above)', { desc = 'New checkbox above' })
keymap('n', '<Leader>nx', ':call notes#toggle_checkbox(line("."))<cr>', { desc = 'Toggle checkbox' })
keymap('n', '<leader>ne', ':call notes#export()<cr>', { desc = 'Export notes' })
