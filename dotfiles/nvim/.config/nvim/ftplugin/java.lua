local jdtls = require('jdtls')
local jdtls_bin = vim.fn.stdpath("data") .. "/mason/bin/jdtls"
local lsp_attach = function(client, bufnr)
  jdtls.setup.add_commands()
  local opts = { silent = true, buffer = bufnr }
  vim.keymap.set('n', "<leader>oi", jdtls.organize_imports, opts)
  vim.keymap.set('n', "<leader>df", jdtls.test_class, opts)
  vim.keymap.set('n', "<leader>dn", jdtls.test_nearest_method, opts)
  vim.keymap.set('n', "crv", jdtls.extract_variable, opts)
  vim.keymap.set('v', 'crm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], opts)
  vim.keymap.set('n', "crc", jdtls.extract_constant, opts)
end

local config = {
    cmd = { jdtls_bin },
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    on_attach = lsp_attach,
}
jdtls.start_or_attach(config)
