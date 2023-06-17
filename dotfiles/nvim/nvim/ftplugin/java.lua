local jdtls = require('jdtls')
local jdtls_bin = vim.fn.stdpath("data") .. "/mason/bin/jdtls"

-- Installation location of jdtls by nvim-lsp-installer
local jdtls_location = vim.fn.stdpath "data" .. "/mason/packages/jdtls"

-- Only for Linux and Mac
local system = "linux"
if vim.fn.has "mac" == 1 then
  system = "mac"
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = os.getenv("HOME") .. "/workspace/java/" .. project_name

-- Does not work to set root_dir and I'm not sure why. Fails to reference JDK classes.
-- local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
-- local root_dir = require("jdtls.setup").find_root(root_markers)
local root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw', 'pom.xml'}, { upward = true })[1])
if root_dir == "" or root_dir == nil then
  return
end

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
    cmd = {
      os.getenv("HOME") .. "/.asdf/installs/java/openjdk-20/bin/java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xms1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",
      "-jar",
      vim.fn.glob(jdtls_location .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
      "-configuration",
      jdtls_location .. "/config_" .. system,
      "-data",
      workspace_dir,
    },
    root_dir = root_dir,
    on_attach = lsp_attach,
    settings = {
      java = {
        configuration = {
          -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
          -- And search for `interface RuntimeOption`
          -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
          runtimes = {
            {
              name = "JavaSE-20",
              path = os.getenv("HOME") .. "/.asdf/installs/java/openjdk-20",
            },
            {
              name = "JavaSE-19",
              path = os.getenv("HOME") .. "/.asdf/installs/java/openjdk-19",
            },
          }
        }
      },
    },
}
jdtls.start_or_attach(config)
