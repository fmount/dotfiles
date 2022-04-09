local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local conf = require("telescope.config").values
-- our picker function: colors
local colors = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "colors",
    finder = finders.new_table {
        results = { "red", "green", "$HOME/.notes/test_note_to_delete" }
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()
            print(vim.inspect(selection[1]))
            -- vim.fn['notes#delete'](selection[1])
            vim.fn.delete(selection[1])
            -- vim.api.nvim_put({ selection[1] }, "", false, true)
            actions.close(prompt_bufnr)
        end)
        return true
    end,
  }):find()
end

-- to execute the function
-- colors(require("telescope.themes").get_dropdown{})
colors(require("telescope.themes").get_dropdown{})
