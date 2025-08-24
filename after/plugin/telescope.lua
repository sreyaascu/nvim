local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup({
    defaults = {
        file_ignore_patterns = { "node_modules", ".git/" },
    },
    pickers = {
        find_files = {
            hidden = true, -- show hidden files
        }
    }
})

-- Load fzf extension for speed
telescope.load_extension('fzf')

-- Keymaps
vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

