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
vim.lsp.config.clangd = {
  capabilities = capabilities,
}

-- LSP keymaps (buffer-local, only active when a server attaches)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>fs', vim.lsp.buf.signature_help, opts)
  end,
})

-- Enable the LSP servers
vim.lsp.enable({ 'bashls', 'pylsp', 'gopls', 'clangd' })
