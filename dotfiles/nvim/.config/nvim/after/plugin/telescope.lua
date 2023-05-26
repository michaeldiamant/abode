local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files in Telescope" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep in Telescope" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Search buffers in Telescope" })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = "Search keymaps in Telescope" })
vim.keymap.set('n', '<leader>ft', builtin.help_tags, { desc = "Find help tags in Telescope" })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Search `git ls-files` in Telescope" })
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Run grep and send results to Telescope" })
vim.keymap.set('n', '<leader>fh', builtin.command_history, { desc = "Search command history in Telescope" })
vim.keymap.set('n', '<leader>fc', builtin.command_history, { desc = "Search commands in Telescope" })

vim.keymap.set('n', '<leader>gd', builtin.lsp_references, { desc = "List symbol references in Telescope" })
vim.keymap.set('n', '<leader>ci', builtin.lsp_incoming_calls, { desc = "List symbol incoming calls in Telescope" })
vim.keymap.set('n', '<leader>co', builtin.lsp_outgoing_calls, { desc = "List symbol outgoing calls in Telescope" })

local actions = require("telescope.actions")

require('telescope').setup {
  defaults = {
    -- Truncate path when too long for picker.
    path_display={ "smart" },
  },
  pickers = {
    find_files = {
      -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
    buffers = {
      mappings = {
        i = {
          ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
        }
      }
    },
    live_grep = {
      additional_args = function (_)
        return {
          "--hidden",
          "--glob",
          "!**/.git/*",
        }
      end
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    recent_files = {
      only_cwd = true,
    }
  }
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

require("telescope").load_extension("recent_files")
vim.api.nvim_set_keymap("n", "<Leader><Leader>",
  [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
  {noremap = true, silent = true, desc = "Search recently opened files in Telescope" })
