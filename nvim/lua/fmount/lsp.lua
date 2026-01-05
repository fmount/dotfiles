-- Setup nvim-cmp and lsp server

-- Completion requires:
-- 'hrsh7th/nvim-cmp'
-- 'hrsh7th/cmp-nvim-lsp'
-- 'hrsh7th/cmp-buffer'
-- 'hrsh7th/cmp-path'

local cmp = require('cmp')

cmp.setup({
  completion = {
    autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged },
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  }),
  window = {
    documentation = cmp.config.window.bordered(),
  },
})

-- Get capabilities for LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSP server configurations
vim.lsp.config.bashls = { capabilities = capabilities }
vim.lsp.config.pylsp = { capabilities = capabilities }
vim.lsp.config.gopls = { 
  cmd = { "/usr/bin/gopls" },
  capabilities = capabilities,
}
vim.lsp.config.ccls = {
  capabilities = capabilities,
  init_options = {
    compilationDatabaseDirectory = "build",
    index = {
      threads = 0,
    },
    clang = {
      excludeArgs = { "-frounding-math" },
    },
  },
}

-- Enable the LSP servers
vim.lsp.enable({ 'bashls', 'pylsp', 'gopls', 'ccls' })
