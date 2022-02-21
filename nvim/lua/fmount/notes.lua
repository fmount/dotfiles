local actions_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local utils = require("telescope.utils")

local M = {}
local del_note_opts = {
    prompt_title = "< Delete Note >",
    cwd = vim.env.NOTES,
    hidden = false,
    attach_mappings =function(prompt_bufnr,map)
    -- selected entry (entry.value will give its value)
    -- override default select action
    actions.select_default:replace(function()
        -- local selection = actions_state.get_selected_entry()
        confirmation_question = "Do you really wanna delete the note %s? [Y/n] "
        success_message = "Deleted note: %s"
        error_message = 'Error when deleting note: %s. Returned code: "%s"'
        local selection = require("telescope.actions.state").get_selected_entry(
            prompt_bufnr
        )
        -- print(vim.inspect(selection))
        local confirmation = vim.fn.input(string.format(confirmation_question, selection.value))
        if confirmation ~= "" and string.lower(confirmation) ~= "y" then
            return
        end
        vim.fn.delete(selection.cwd .. "/" .. selection.value)
        local _, ret, stderr = utils.get_os_command_output({ "ls", "-l", selection.cwd .. "/" .. selection.value}, cwd)
        if ret == 0 then
            print(string.format(error_message, selection.value, ret))
        else
            print(string.format(success_message, selection.value))
        end
        actions.close(prompt_bufnr)
    end)
    return true
end
}

M.delete_note = function()
    require("telescope.builtin").find_files(del_note_opts)
end

M.search_notes = function()
    require('telescope.builtin').find_files({
        prompt_title = "< Open Note >",
        cwd = vim.env.NOTES,
        hidden = false
    })
end

return M
