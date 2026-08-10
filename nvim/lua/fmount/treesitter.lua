require('nvim-treesitter').setup({
    ensure_installed = { "c", "go", "gomod", "gosum", "python", "lua", "bash", "yaml", "markdown" },
    highlight = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
})
