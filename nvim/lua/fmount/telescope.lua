local home = vim.env.HOME or vim.fn.expand('~')

local function home_path(path)
  return vim.fs.joinpath(home, path)
end

require('telescope').setup({
  defaults = {
    layout_config = {
      vertical = { width = 0.5 }
      -- other layout configuration here
    },
    -- other defaults configuration here
  },
  extensions = {
    project = {
      base_dirs = {
        { path = home_path('projects') },
        { path = home_path('devnull') },
        { home_path('private'), max_depth = 4 },
      },
      hidden_files = false
    }
  },
})

local M = {}
M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "< VimRC >",
        cwd = vim.env.DOTFILES or home_path('dotfiles'),
        hidden = true,
    })
end
return M
