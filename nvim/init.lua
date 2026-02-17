-- Check if we're running Vim (not Neovim)
if not vim.fn.has('nvim') then
  -- For regular Vim, source the legacy vimrc
  vim.cmd('source ~/.config/nvim/vimrc/init.vim')
  return
end

-- Neovim-specific configuration below

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set mapleader before loading plugins
vim.g.mapleader = ","

-- Load basic Vim settings
require('fmount.options')

-- Setup lazy.nvim
require("lazy").setup("fmount.plugins", {
  checker = { enabled = true },
  change_detection = { notify = false },
})

-- Load configuration modules
require('fmount.lsp')
require('fmount.keymaps')
require('fmount.treesitter')
require('fmount.telescope')
require('fmount.diagnostics')
require("fmount.term")
require('fmount.claude')
require('fmount.autocmds')
