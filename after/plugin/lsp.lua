-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

-- MASON SETUP
require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "ts_ls",
    "eslint",
    "pyright",
    "clangd",
    "jdtls",
    -- NOTE: dartls is not supported by mason, so we set it up manually below
  },
  automatic_installation = true,
})

-- LSPCONFIG SETUP
local lspconfig = require("lspconfig")

-- Custom config for Lua
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

-- Setup remaining servers with error-check
local servers = { "tsserver", "eslint", "pyright", "clangd", "jdtls" }

for _, server in ipairs(servers) do
  local config = lspconfig[server]
  if config then
    config.setup({})
  else
    vim.notify("⚠️ LSP config for '" .. server .. "' not found!", vim.log.levels.WARN)
  end
end

-- ✅ MANUAL SETUP FOR DART LSP
lspconfig.dartls.setup({
  cmd = { "/home/sreyaas/flutter/bin/dart", "language-server", "--protocol=lsp" },
  filetypes = { "dart" },
  init_options = {
    closingLabels = true,
    outline = true,
    flutterOutline = true,
  },
})

-- Optional: Customize diagnostic signs (icons)
local signs = { Error = " ", Warn = " ", Hint = "󰌵", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Configure diagnostics display
vim.diagnostic.config({
  virtual_text = false,  -- disable inline errors
  signs = false,         -- keep signs in the gutter (left of numbers)
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

