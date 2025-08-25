require("mason").setup()

require("mason-lspconfig").setup {
  -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
  -- This setting has no relation with the `automatic_installation` setting.
  ---@type string[]
  ensure_installed = {
    "jdtls",
    "jsonls",
    "lemminx", -- XML
    "lua_ls",
    "pyright",
  },

  -- See `:h mason-lspconfig.setup_handlers()`
  ---@type table<string, fun(server_name: string)>?
  handlers = nil,
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- vim.keymap.set('n', '<leader>se', vim.diagnostic.open_float)
vim.keymap.set('n', "<leader>E", vim.diagnostic.goto_prev)
vim.keymap.set('n', "<leader>e", vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local desc_opts = function(desc)
      return { buffer = ev.buf, desc = desc }
    end

    -- Go to definition in split from https://neovim.discourse.group/t/jump-to-definition-in-vertical-horizontal-split/2605/12
    vim.keymap.set('n', 'gvd', ":vsp | lua vim.lsp.buf.definition()<CR>", desc_opts("Jump to symbol definition in vsp"))
    vim.keymap.set('n', 'gsd', ":sp | lua vim.lsp.buf.definition()<CR>", desc_opts("Jump to symbol definition in sp"))

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, desc_opts("Show symbol hover info"))
    -- vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, desc_opts("Show symbol signature info"))
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, desc_opts("Add LSP workspace folder"))
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, desc_opts("Remove LSP workspace folder"))
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, desc_opts("List LSP workspace list_workspace_folders"))
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, desc_opts("Jump to symbol's type definition"))
    vim.keymap.set('n', '<leader>n', vim.lsp.buf.rename, desc_opts("Rename all symbol references"))
    vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, desc_opts("Toggle code action menu"))
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, desc_opts("List all symbol references in quickfix"))
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, desc_opts("Format attached buffer via LSP"))
    vim.keymap.set('n', '<leader>lr', ":LspRestart<CR>", desc_opts("Restart LSP client"))
    -- Prefer Telescope for these actions
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, desc_opts("List symbol implementations in quickfix"))
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, desc_opts("Jump to symbol declaration"))
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, desc_opts("Jump to symbol definition"))
    -- vim.keymap.set('n', 'cu', vim.lsp.buf.incoming_calls, desc_opts("List symbol call sites in quickfix"))
    -- vim.keymap.set('n', 'co', vim.lsp.buf.outgoing_calls, desc_opts("List items called by symbol in quickfix"))
    -- vim.keymap.set('n', 'ws', vim.lsp.buf.workspace_symbol, desc_opts("List workspace symbols in quickfix"))
  end,
})

local function get_lsp_clients_for_current_buffer()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  if next(clients) == nil then
    return ''  -- no attached clients
  end

  local client_names = {}
  for _, client in pairs(clients) do
    table.insert(client_names, client.name)
  end

  return 'LSP: ' .. table.concat(client_names, ', ')
end

vim.keymap.set("n", "<leader>BL", function()
  print(get_lsp_clients_for_current_buffer())
end)

