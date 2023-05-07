nnoremap <silent><leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <silent><leader>e :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <silent><leader>tc :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>
nnoremap <silent><C-j> :lua require("harpoon.ui").nav_next()<CR>
nnoremap <silent><C-k> :lua require("harpoon.ui").nav_prev()<CR>
