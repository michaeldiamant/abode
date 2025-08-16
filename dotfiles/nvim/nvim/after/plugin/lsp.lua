--require("mason").setup()

--require("mason-lspconfig").setup {
--  -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
--  -- This setting has no relation with the `automatic_installation` setting.
--  ---@type string[]
--  ensure_installed = {
--    "jdtls",
--    "jsonls",
--    "lemminx", -- XML
--    "lua_ls",
--    "pyright",
--  },

--  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
--  -- This setting has no relation with the `ensure_installed` setting.
--  -- Can either be:
--  --   - false: Servers are not automatically installed.
--  --   - true: All servers set up via lspconfig are automatically installed.
--  --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
--  --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
--  ---@type boolean
--  automatic_installation = false,

--  -- See `:h mason-lspconfig.setup_handlers()`
--  ---@type table<string, fun(server_name: string)>?
--  handlers = nil,
--}

---- IMPORTANT: make sure to setup neodev BEFORE lspconfig
--require("neodev").setup()

--local lspconfig = require('lspconfig')
--lspconfig.lua_ls.setup {
--  settings = {
--    Lua = {
--      runtime = {
--        -- Tell the language server which version of Lua you're using
--        -- (most likely LuaJIT in the case of Neovim)
--        version = 'LuaJIT',
--      },
--      workspace = {
--        -- How `library` is configured to get API docs for nvim API:
--        -- * Using neodev in place of commented out config below.
--        -- * Kludge - Versioning EmmyLua.spoon source in this repo because attempts (like string.format below) failed to work.
--        --   library = {
--        --     vim.api.nvim_get_runtime_file("", true),
--        --     string.format("%s/.hammerspoon/Spoons/EmmyLua.spoon/annotations", os.getenv 'HOME')) 
--        --   }

--        -- Workaround described in https://github.com/LunarVim/LunarVim/issues/4049
--        checkThirdParty = false,
--        --  
--      },
--      -- Do not send telemetry data containing a randomized but unique identifier
--      telemetry = {
--        enable = false,
--      },
--    },
--  },
--}

--require('mason-lspconfig').setup_handlers({
--  function(server_name)
--    lspconfig[server_name].setup({
--      on_attach = lsp_attach,
--      capabilities = lsp_capabilities,
--    })
--  end,
--  -- https://www.reddit.com/r/neovim/comments/12gaetp/how_to_use_nvimjdtls_for_java_and_nvimlspconfig/
--  ["jdtls"] = function()
--  end,                        -- Effectively disable jdtls in favor of nvim-jdtls
--})

---- Go to definition in a split from https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#go-to-definition-in-a-split-window
--local function goto_definition(split_cmd)
--  local util = vim.lsp.util
--  local log = require("vim.lsp.log")
--  local api = vim.api

--  -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
--  local handler = function(_, result, ctx)
--    if result == nil or vim.tbl_isempty(result) then
--      local _ = log.info() and log.info(ctx.method, "No location found")
--      return nil
--    end

--    if split_cmd then
--      vim.cmd(split_cmd)
--    end

--    if vim.tbl_islist(result) then
--      util.jump_to_location(result[1])

--      if #result > 1 then
--        util.set_qflist(util.locations_to_items(result))
--        api.nvim_command("copen")
--        api.nvim_command("wincmd p")
--      end
--    else
--      util.jump_to_location(result)
--    end
--  end

--  return handler
--end

---- Global mappings.
---- See `:help vim.diagnostic.*` for documentation on any of the below functions
--vim.keymap.set('n', '<leader>se', vim.diagnostic.open_float)
--vim.keymap.set('n', "<leader>E", vim.diagnostic.goto_prev)
--vim.keymap.set('n', "<leader>e", vim.diagnostic.goto_next)
--vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

---- Use LspAttach autocommand to only map the following keys
---- after the language server attaches to the current buffer
--vim.api.nvim_create_autocmd('LspAttach', {
--  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
--  callback = function(ev)
--    -- Enable completion triggered by <c-x><c-o>
--    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

--    -- Buffer local mappings.
--    -- See `:help vim.lsp.*` for documentation on any of the below functions
--    local desc_opts = function(desc)
--      return { buffer = ev.buf, desc = desc }
--    end

--    -- Go to definition in split from https://neovim.discourse.group/t/jump-to-definition-in-vertical-horizontal-split/2605/12
--    vim.keymap.set('n', 'gvd', ":vsp | lua vim.lsp.buf.definition()<CR>", desc_opts("Jump to symbol definition in vsp"))
--    vim.keymap.set('n', 'gsd', ":sp | lua vim.lsp.buf.definition()<CR>", desc_opts("Jump to symbol definition in sp"))

--    vim.keymap.set('n', 'K', vim.lsp.buf.hover, desc_opts("Show symbol hover info"))
--    vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, desc_opts("Show symbol signature info"))
--    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, desc_opts("Add LSP workspace folder"))
--    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, desc_opts("Remove LSP workspace folder"))
--    vim.keymap.set('n', '<leader>wl', function()
--      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--    end, desc_opts("List LSP workspace list_workspace_folders"))
--    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, desc_opts("Jump to symbol's type definition"))
--    vim.keymap.set('n', '<leader>n', vim.lsp.buf.rename, desc_opts("Rename all symbol references"))
--    -- Prefer nvim-code-action-menu over default code action menu
--    -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
--    vim.keymap.set({ 'n', 'v' }, '<leader>a', ":CodeActionMenu <CR>", desc_opts("Toggle code action menu"))
--    vim.keymap.set('n', 'gr', vim.lsp.buf.references, desc_opts("List all symbol references in quickfix"))
--    vim.keymap.set('n', '<leader>f', function()
--      vim.lsp.buf.format { async = true }
--    end, desc_opts("Format attached buffer via LSP"))
--    vim.keymap.set('n', '<leader>lr', ":LspRestart<CR>", desc_opts("Restart LSP client"))
--    -- Prefer Telescope for these actions
--    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, desc_opts("List symbol implementations in quickfix"))
--    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, desc_opts("Jump to symbol declaration"))
--    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, desc_opts("Jump to symbol definition"))
--    -- vim.keymap.set('n', 'cu', vim.lsp.buf.incoming_calls, desc_opts("List symbol call sites in quickfix"))
--    -- vim.keymap.set('n', 'co', vim.lsp.buf.outgoing_calls, desc_opts("List items called by symbol in quickfix"))
--    -- vim.keymap.set('n', 'ws', vim.lsp.buf.workspace_symbol, desc_opts("List workspace symbols in quickfix"))
--  end,
--})

--require("symbols-outline").setup()
--vim.keymap.set('n', '<leader>o', ':SymbolsOutline<CR>', { desc = "Toggle LSP symbol outline" })
