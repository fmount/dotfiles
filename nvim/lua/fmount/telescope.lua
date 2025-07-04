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
        { path ='/home/fmount/projects'},
        { path = '/home/fmount/devnull'},
        {'/home/fmount/private', max_depth = 4},
      },
      hidden_files = false
    }
  },
})

local M = {}
M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "< VimRC >",
        cwd = vim.env.DOTFILES,
        hidden = true,
    })
end
return M
