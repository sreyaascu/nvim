local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

local builtin = require("telescope.builtin")

telescope.setup({
  defaults = {
    file_ignore_patterns = { "node_modules", ".git/" },
    preview = {
      treesitter = false,
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
})

telescope.load_extension("fzf")

vim.keymap.set("n", "<leader>pg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)


