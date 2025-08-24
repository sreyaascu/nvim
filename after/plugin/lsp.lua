-- =========================================
-- LSP + Mason Setup (No Duplication)
-- =========================================

-- Add cmp_nvim_lsp capabilities to default config
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- Keymaps for LSP actions
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP keymaps',
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'x' }, '<F3>', function()
      vim.lsp.buf.format({ async = true })
    end, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
})

-- Mason setup
require("mason").setup()

-- Mason-LSPConfig setup
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
  ensure_installed = {
    "lua_ls",
    "eslint",
    "pyright",
    "clangd",
    "jdtls",
    -- dartls is not supported here, so we set it up manually
  },
  automatic_installation = true,
})

-- LSPConfig setup
local lspconfig = require("lspconfig")

-- Special config for Lua
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

-- Auto-setup all Mason-installed servers except lua_ls
--for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
--  if server_name ~= "lua_ls" then
--    lspconfig[server_name].setup({})
--  end
--end

-- Manual Dart setup
lspconfig.dartls.setup({
  cmd = { "/home/sreyaas/flutter/bin/dart", "language-server", "--protocol=lsp" },
  filetypes = { "dart" },
  init_options = {
    closingLabels = true,
    outline = true,
    flutterOutline = true,
  },
})

-- Diagnostics display settings
vim.diagnostic.config({
  virtual_text ={
      spacing = 6,
  } ,
  signs = false,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

