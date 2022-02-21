" telescope builtings
nnoremap <leader>ff :lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg :lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb :lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh :lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fr :lua require('telescope.builtin').lsp_references()<cr>

"lua require("fmount") / extensions

nnoremap <leader>vb :lua require('fmount.telescope').background_selector()<CR>
nnoremap <leader>vf :lua require('fmount.telescope').search_dotfiles({ hidden = true })<CR>
nnoremap <leader>vn :lua require('fmount.notes').search_notes({ hidden = false })<CR>
nnoremap <leader>vd :lua require('fmount.notes').delete_note({ hidden = false })<CR>
