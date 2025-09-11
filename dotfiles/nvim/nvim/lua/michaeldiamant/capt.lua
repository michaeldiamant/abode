function RunScriptAndCaptureNewFiles(cmd)
  -- Generate a unique temp directory
  local tmpdir = "/tmp/capt-" .. os.tmpname():match("([^/]+)$")
  os.execute("mkdir -p " .. tmpdir)

  -- Set CAPTURE_OUTPUT_DIR in the environment and run command synchronously
  local full_cmd = "CAPTURE_OUTPUT_DIR=" .. tmpdir .. " bash -c " .. vim.fn.shellescape(cmd) .. " 1>/tmp/capt-stdout 2>/tmp/capt-stderr"
  os.execute(full_cmd)

  -- Save current window to restore focus later
  local cur_win = vim.api.nvim_get_current_win()
  local timestamp = os.date("%Y%m%d%H%M%S")

  -- Collect non-empty outputs
  local outputs = {}

  -- Stdout
  local stdout_file = io.open("/tmp/capt-stdout", "r")
  local stdout = ""
  if stdout_file then
    stdout = stdout_file:read("*a")
    stdout_file:close()
  end
  if stdout and stdout:match("%S") then
    table.insert(outputs, {
      lines = vim.split(stdout, "\n"),
      name = "[Shell Stdout] " .. timestamp
    })
  end

  -- Stderr
  local stderr_file = io.open("/tmp/capt-stderr", "r")
  local stderr = ""
  if stderr_file then
    stderr = stderr_file:read("*a")
    stderr_file:close()
  end
  if stderr and stderr:match("%S") then
    table.insert(outputs, {
      lines = vim.split(stderr, "\n"),
      name = "[Shell Stderr] " .. timestamp
    })
  end

  -- Files in tmpdir
  local p = io.popen("ls -1 " .. tmpdir)
  local files = {}
  for file in p:lines() do
    table.insert(files, file)
  end
  p:close()

  for _, file in ipairs(files) do
    local filepath = tmpdir .. "/" .. file
    local f = io.open(filepath, "r")
    if f then
      local contents = f:read("*a")
      f:close()
      if contents and contents:match("%S") then -- Only show non-empty files
        table.insert(outputs, {
          lines = vim.split(contents, "\n"),
          name = filepath
        })
      end
    end
  end

  -- Show splits: first as vsplit, rest as horizontal splits
  local first_shown = false
  for _, out in ipairs(outputs) do
    if not first_shown then
      vim.cmd("vsplit")
      first_shown = true
    else
      vim.cmd("split")
    end
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, out.lines)
    vim.api.nvim_buf_set_name(buf, out.name)
    vim.api.nvim_win_set_buf(0, buf)
  end

  -- Restore focus to the original window
  vim.api.nvim_set_current_win(cur_win)
end

vim.api.nvim_create_user_command(
  'RunScriptAndCaptureNewFiles',
  function(opts)
    RunScriptAndCaptureNewFiles(opts.args)
  end,
  { nargs = "+" }
)

vim.keymap.set('n', '<leader>m', function()
  RunScriptAndCaptureNewFiles(vim.fn.expand('%:p'))
end, { noremap = true, silent = true, desc = "Run current buffer as shell script" })

