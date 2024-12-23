local lua_terminal_window = nil
local lua_terminal_buffer = nil
local lua_terminal_job_id = nil
local REDUCT = 3
local TITLE = "Terminal"

local function lua_terminal_window_size()
    return tonumber(vim.api.nvim_exec("echo &lines", true)) / REDUCT
end

-- Open a Terminal and set some basic options
local function LuaTerminalOpen()
    -- only one buffer: let's build a terminal
    if vim.fn.bufexists(lua_terminal_buffer) == 0 then
        vim.api.nvim_command("new lua_terminal")
        vim.api.nvim_command("wincmd J")
        vim.api.nvim_command("resize " .. lua_terminal_window_size())
        lua_terminal_job_id = vim.fn.termopen(os.getenv("SHELL"), {
            detach = 1
        })
        vim.api.nvim_command("silent file Terminal 1")
        lua_terminal_window = vim.fn.win_getid()
        lua_terminal_buffer = vim.fn.bufnr('%')
        vim.opt.buflisted = false
    else
        -- multiple buffers exist
        if vim.fn.win_gotoid(lua_terminal_window) == 0 then
            vim.api.nvim_command("sp")
            vim.api.nvim_command("wincmd J")
            vim.api.nvim_command("resize " .. lua_terminal_window_size())
            vim.api.nvim_command("buffer Terminal 1")
            lua_terminal_window = vim.fn.win_getid()
        end
    end
end

-- Hide a terminal window if present
local function LuaTerminalClose()
    if vim.fn.win_gotoid(lua_terminal_window) == 1 then
        vim.api.nvim_command("hide")
    end
end

-- Main function: toggle terminal
local function LuaTerminalToggle()
    if vim.fn.win_gotoid(lua_terminal_window) == 1 then
        LuaTerminalClose()
    else
        LuaTerminalOpen()
    end
end

vim.keymap.set("n", "<leader>t", function() LuaTerminalToggle() end)
-- detach from terminal when press ESC
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], {noremap = true})

vim.api.nvim_create_autocmd('TermOpen', {
 pattern = '*',
 callback = function()
   vim.opt_local.number = false
   vim.opt_local.relativenumber = false
   vim.cmd("startinsert")
 end
})
