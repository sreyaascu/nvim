-- =========================================
-- LSP + Mason Setup (Neovim 0.11+)
-- =========================================

-- cmp capabilities
local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

-- LSP keymaps
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

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "pyright",
    "clangd",
    "eslint",
    "jdtls",
    "ts_ls",
  },
  automatic_installation = true,
})

-- =========================================
-- Define LSP configs
-- =========================================

vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

vim.lsp.config("pyright", {
  capabilities = capabilities,
})

vim.lsp.config("clangd", {
  capabilities = capabilities,
})

vim.lsp.config("eslint", {
  capabilities = capabilities,
})

vim.lsp.config("jdtls", {
  capabilities = capabilities,
})

vim.lsp.config("ts_ls", {
  capabilities = capabilities,
})

vim.lsp.config("dartls", {
  capabilities = capabilities,
  cmd = { "/home/sreyaas/flutter/bin/dart", "language-server", "--protocol=lsp" },
  filetypes = { "dart" },
  init_options = {
    closingLabels = true,
    outline = true,
    flutterOutline = true,
  },
})

-- =========================================
-- Enable LSPs
-- =========================================

vim.lsp.enable("lua_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("clangd")
vim.lsp.enable("eslint")
vim.lsp.enable("jdtls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("dartls")

-- =========================================
-- Diagnostics UI
-- =========================================
local signs = {
  Error = " ",
  Warn  = " ",
  Hint  = "󰠠 ",
  Info  = " ",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {
    text = icon,
    texthl = hl,
    numhl = "",
  })
end
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
