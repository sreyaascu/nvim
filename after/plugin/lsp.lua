-- =========================================
-- LSP + Mason Setup (Neovim 0.11+)
-- =========================================

-- Add cmp_nvim_lsp capabilities
local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

-- Keymaps for LSP actions
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP keymaps",
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "x" }, "<F3>", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  end,
})

-- Mason setup
require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  ensure_installed = {
    "lua_ls",
    "eslint",
    "pyright",
    "clangd",
    "jdtls",
  },
  automatic_installation = true,
})

-- Alias for new Neovim LSP config API
local lspconfig_new = vim.lsp.config

-- Lua LSP
lspconfig_new("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})

-- Setup all other Mason-installed servers except lua_ls
for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
  if server_name ~= "lua_ls" then
    lspconfig_new(server_name, { capabilities = capabilities })
  end
end

-- Manual Dart setup
lspconfig_new("dartls", {
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
  virtual_text = { spacing = 2 }, -- adds gap between code and error message
  signs = false,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

