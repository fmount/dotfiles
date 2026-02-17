-- Autocmds

-- GO indentation
vim.api.nvim_create_augroup("GO", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "GO",
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.tabstop = 4
  end,
})

-- Default file type settings
vim.api.nvim_create_augroup("DEFAULT", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = "DEFAULT",
  pattern = "markdown",
  callback = function()
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = "DEFAULT",
  pattern = { "yaml", "yml" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = "DEFAULT",
  pattern = { "c", "cpp", "h", "hpp" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.cindent = true
    vim.opt_local.cinoptions = ":0,l1,t0,g0,(0"
    vim.opt_local.textwidth = 80
    vim.opt_local.colorcolumn = "80"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = "DEFAULT",
  pattern = "python",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    -- Retab the file
    vim.cmd("%retab!")
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = "DEFAULT",
  pattern = "*",
  callback = function()
    -- Change to file directory
    vim.cmd("silent! lcd %:p:h")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = "DEFAULT",
  pattern = "vim",
  callback = function()
    vim.opt_local.fileformat = "unix"
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "TabEnter" }, {
  group = "DEFAULT",
  pattern = "*.rs",
  callback = function()
    vim.cmd("compiler cargo")
  end,
})

-- Cursor highlighting
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("highlight Cursor guifg=white guibg=#BC6A00")
  end,
})

-- Colorscheme and transparency
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("hi EndOfBuffer ctermbg=NONE ctermfg=200 cterm=NONE")
    vim.cmd("hi Normal ctermbg=NONE ctermfg=200 cterm=NONE")
    vim.cmd("colorscheme jellybeans")
  end,
})
