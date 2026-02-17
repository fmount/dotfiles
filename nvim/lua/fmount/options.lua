-- Basic Vim settings
vim.g.startify_custom_header = ''

-- Basic settings
vim.opt.compatible = false
vim.opt.path:append("**")
vim.opt.wrap = true
vim.opt.number = true
vim.opt.colorcolumn = "80"
vim.opt.selectmode = "mouse"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = true
vim.opt.spelllang = "en_gb"

-- Indentation
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.showtabline = 2
vim.opt.shiftwidth = 4
vim.opt.textwidth = 0

-- UI settings
vim.opt.mousehide = true
vim.opt.history = 1000
vim.opt.list = true
vim.opt.listchars = {
  tab = "›\\ ",
  trail = "•",
  extends = "#",
  nbsp = ".",
}
vim.opt.hlsearch = true
vim.opt.showcmd = true
vim.opt.backspace = "2"
vim.opt.diffopt:append("iwhite")
vim.opt.clipboard = "unnamed"

-- Folding
vim.opt.foldmethod = "indent"
vim.opt.foldnestmax = 10
vim.opt.foldenable = false
vim.opt.foldlevel = 1

-- Completion
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.shortmess:append("c")

-- Persistent undo
if vim.fn.has("persistent_undo") == 1 then
  vim.opt.undodir = vim.fn.expand("$HOME/.undodir/")
  vim.opt.undofile = true
end

-- Markdown
vim.g.markdown_fenced_languages = { "c", "bash=sh" }
vim.g.markdown_syntax_conceal = 0

-- GUI settings
vim.opt.guioptions:remove("m") -- remove menu bar
vim.opt.guioptions:remove("T") -- remove toolbar
vim.opt.guioptions:remove("r") -- remove scrollbar

-- Mouse settings
vim.opt.mouse = ""

-- Buffer settings
vim.opt.hidden = true
