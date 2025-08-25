vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- vim.keymap.set("n", "<leader>sv", ":source $MYVIMRC<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<C-y>", [["+y]])
vim.keymap.set("n", "<C-Y>", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- vim.keymap.set("n", "<C-j>", "<C-w>j")
-- vim.keymap.set("n", "<C-k>", "<C-w>k")
-- vim.keymap.set("n", "<C-h>", "<C-w>h")
-- vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<C-s>k", ":resize -3<CR>")
vim.keymap.set("n", "<C-s>j", ":resize +3<CR>")
vim.keymap.set("n", "<C-s>h", ":vertical resize -3<CR>")
vim.keymap.set("n", "<C-s>l", ":vertical resize +3<CR>")

-- In termnal buffers, make it easier to enter normal mode
vim.keymap.set('t', "n", "<C-\\><C-N>")

vim.keymap.set("n", "gt", ":NERDTreeFind<CR><C-w>|")
vim.keymap.set("n", "gT", ":NERDTree<CR><C-w>|")

vim.keymap.set("n", "\\j", ":%! python -m json.tool<CR>")
vim.keymap.set('n', '<leader>vl', function()
  local current = vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = not current })
end, { desc = 'Toggle diagnostic virtual_lines' })

vim.keymap.set('n', '\\t', function()
  -- vim.diagnostic.setqflist({bufnr = 0, open = true})
  local diagnostics = vim.diagnostic.get(0)  -- get diagnostics in current buffer
  if #diagnostics == 0 then
    -- Clear quickfix list if no diagnostics
    vim.fn.setqflist({})
    vim.cmd('cclose')  -- optional: close quickfix window if empty
  else
    -- Otherwise set quickfix list with current diagnostics and open quickfix window
    vim.diagnostic.setqflist({ bufnr = 0, open = true })
  end
end)
vim.api.nvim_create_user_command('RunScriptSplit', function(opts)
  local count = opts.count > 0 and opts.count or 1
  local use_popup = true  -- default show popup

  if opts.args ~= '' then
    local arg = opts.args:lower()
    if arg == 'nopopup' then
      use_popup = false
    elseif arg == 'popup' then
      use_popup = true
    else
      print("Usage: :RunScriptSplit [popup|nopopup] (default is popup)")
      return
    end
  end

  local original_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(current_buf, 0, -1, false)
  local text = table.concat(lines, "\n")

  local total_start = vim.loop.hrtime()
  local runtimes = {}
  for _ = 1, count do
    local start = vim.loop.hrtime()
    local output = vim.fn.system("bash", text)
    local endt = vim.loop.hrtime()
    table.insert(runtimes, (endt - start) / 1e6) -- ms

    -- Check if buffer contains a curl command line (basic heuristic)
    local is_curl = false
    for _, line in ipairs(lines) do
      if string.find(line, 'curl -i', 1, true) then
        is_curl = true
        break
      end
    end

    print ("is it curl???? " .. tostring(is_curl))
    if is_curl then
      -- Split output into headers and body by two newlines (\r\n\r\n or \n\n)
      -- curl headers are typically at the start if you use -i or --include
      local header_body_split = output:find("\r\n\r\n")
      if not header_body_split then
        header_body_split = output:find("\n\n")
      end

      local headers = ""
      local body = output
      if header_body_split then
        headers = output:sub(1, header_body_split)
        body = output:sub(header_body_split + 2)
      end

      -- Open vertical split with headers
      vim.cmd('vnew')
      local header_buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_lines(header_buf, 0, -1, false, vim.split(headers, "\n", {trimempty=true}))
      vim.bo.modified = false
      vim.bo.buftype = 'nofile'
      vim.bo.bufhidden = 'hide'
      vim.bo.swapfile = false

      -- Open horizontal split with body below original window
      vim.cmd('split')
      -- local body_buf = vim.api.nvim_get_current_buf()
      -- local body_buf = vim.api.nvim_create_buf(false, true) -- create new empty scratch buffer
      local horizontal_win = vim.api.nvim_get_current_win()
      -- Create new empty scratch buffer for response body
      local body_buf = vim.api.nvim_create_buf(false, true)
      -- Set the new scratch buffer to the horizontal split window
      vim.api.nvim_win_set_buf(horizontal_win, body_buf)
      vim.api.nvim_buf_set_lines(body_buf, 0, -1, false, vim.split(body, "\n", {trimempty=true}))
      vim.bo.modified = false
      vim.bo.buftype = 'nofile'
      vim.bo.bufhidden = 'hide'
      vim.bo.swapfile = false

      vim.api.nvim_set_current_win(original_win)  -- ensure focus is original window for horizontal split
    else
      -- Default: all output in vertical split
      vim.cmd('vnew')
      local output_buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_lines(output_buf, 0, -1, false, vim.split(output, "\n", {trimempty=true}))
      vim.bo.modified = false
      vim.bo.buftype = 'nofile'
      vim.bo.bufhidden = 'hide'
      vim.bo.swapfile = false
    end
  end

  local total_end = vim.loop.hrtime()
  local total_ms = (total_end - total_start) / 1e6

  if use_popup then
    local msgs = {}
    if count == 1 then
      table.insert(msgs, string.format("RunScriptSplit completed in %.2f ms", total_ms))
    else
      for i, rt in ipairs(runtimes) do
        table.insert(msgs, string.format("Run %d duration: %.2f ms", i, rt))
      end
      table.insert(msgs, string.format("Total runtime: %.2f ms", total_ms))
    end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, msgs)

    local width = 0
    for _, line in ipairs(msgs) do
      width = math.max(width, #line)
    end
    width = width + 4
    local height = #msgs + 2
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local opts = {
      style = "minimal",
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col,
      border = "rounded"
    }
    local win = vim.api.nvim_open_win(buf, true, opts)

    local close_keys = { "<ESC>", "q", "<CR>" }
    for _, key in ipairs(close_keys) do
      vim.api.nvim_buf_set_keymap(buf, 'n', key, '<cmd>close<CR>', { nowait = true, noremap = true, silent = true })
    end

    vim.api.nvim_create_autocmd("WinClosed", {
      pattern = tostring(win),
      once = true,
      callback = function()
        if vim.api.nvim_win_is_valid(original_win) then
          vim.api.nvim_set_current_win(original_win)
        end
      end,
    })
  else
    vim.api.nvim_set_current_win(original_win)
  end
end, {count = true, nargs = '?'})


vim.keymap.set('n', '<Leader>s', function()
  local count = vim.v.count
  if count == 0 then count = 1 end
  vim.cmd(count .. 'RunScriptSplit')
end, { noremap = true, silent = true })

