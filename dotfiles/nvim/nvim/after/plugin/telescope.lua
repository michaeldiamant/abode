local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files in Telescope" })
-- vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = "Live grep in Telescope" })
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

vim.keymap.set('n', 'cu', builtin.lsp_references, { desc = "List symbol references in Telescope" })
vim.keymap.set('n', 'gd', builtin.lsp_definitions, { desc = "Jump to symbol definition"})
vim.keymap.set('n', 'gD', builtin.lsp_type_definitions, { desc = "Jump to symbol type definition"})
vim.keymap.set('n', '<leader>fs', builtin.lsp_dynamic_workspace_symbols, { desc = "List workspace symbols"})
vim.keymap.set('n', '<leader>fS', builtin.lsp_document_symbols, { desc = "List document symbols"})
vim.keymap.set('n', 'gi', builtin.lsp_implementations, { desc = "Jump to symbol implementation"})

vim.keymap.set('n', '\\t', builtin.diagnostics, { desc = "List document diagnostics"})

-- vim.keymap.set('n', 'cu', builtin.lsp_incoming_calls, { desc = "List symbol incoming calls in Telescope" })
-- vim.keymap.set('n', 'co', builtin.lsp_outgoing_calls, { desc = "List symbol outgoing calls in Telescope" })

local actions = require("telescope.actions")
local lga_actions = require("telescope-live-grep-args.actions")

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
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown{}
    },
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = { -- extend mappings
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
      vimgrep_arguments = {
        "rg",
        "--hidden",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case"}
      }
  }
}

local ts = require("telescope")
ts.load_extension("ui-select")
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
ts.load_extension('fzf')
ts.load_extension("live_grep_args")

ts.load_extension("recent_files")
vim.keymap.set("n", "<Leader><Leader>",
  [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
  {noremap = true, silent = true, desc = "Search recently opened files in Telescope" })

local workspace_query = function(default_text, symbols)
  local q = vim.fn.input("Query: ")
  builtin.lsp_workspace_symbols({ query = q, default_text = default_text .. q, symbols = symbols })
end

vim.keymap.set("n", "<leader>ws",
  function() workspace_query("", nil) end,
  { desc = "Query for LSP workspace for all symbols" })

vim.keymap.set("n", "<leader>cjp",
  function() workspace_query("!jdt ", "class") end,
  { desc = "Query for LSP project classes" })
vim.keymap.set("n", "<leader>cjl",
  function() workspace_query("jdt ", "class") end,
  { desc = "Query for LSP library classes" })
