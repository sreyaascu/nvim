vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv",vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Arrow key replacements in insert mode
vim.keymap.set('i', '<C-h>', '<Left>', { noremap = true })
vim.keymap.set('i', '<C-l>', '<Right>', { noremap = true })
vim.keymap.set('i', '<C-j>', '<Down>', { noremap = true })
vim.keymap.set('i', '<C-k>', '<Up>', { noremap = true })
vim.keymap.set("n", "<leader>li", function()
  print(vim.inspect(vim.lsp.get_active_clients()))
end, { desc = "List active LSPs" })


-- Line appending at the end
vim.keymap.set("n", "J", "mzJ`z")

-- Half page jumpimg cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")


--search terms in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+y")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Wrap selected lines in double quotes
vim.api.nvim_create_user_command("WrapQuotes", function(opts)
  local start_line = opts.line1
  local end_line = opts.line2
  vim.cmd(start_line .. "," .. end_line .. [[s/^/"/]])
  vim.cmd(start_line .. "," .. end_line .. [[s/$/"/]])
end, { range = true })

-- Unwrap quotes from selected lines
vim.api.nvim_create_user_command("UnwrapQuotes", function(opts)
  local start_line = opts.line1
  local end_line = opts.line2
  vim.cmd(start_line .. "," .. end_line .. [[s/^"//]])
  vim.cmd(start_line .. "," .. end_line .. [[s/"$//]])
end, { range = true })

-- Optional keybindings in visual mode
vim.keymap.set("v", "<leader>qw", ":WrapQuotes<CR>", { desc = "Wrap in quotes" })
vim.keymap.set("v", "<leader>uq", ":UnwrapQuotes<CR>", { desc = "Unwrap quotes" })
