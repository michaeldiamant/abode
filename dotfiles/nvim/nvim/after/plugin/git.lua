require('gitsigns').setup {
  signs = {
    add          = { text = '+' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map('n', '<leader>hs', gs.stage_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end)
    map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end)
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    vim.keymap.set('n', 'gco', ':Git checkout ')
    vim.keymap.set('n', 'gpl', ':Git pull origin<CR>')

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

local function open_url(url)
  -- Platform-specific command to open URL in default browser
  local opener = "xdg-open" -- Linux, for macOS use 'open'
  if vim.fn.has("macunix") == 1 then
    opener = "open"
  elseif vim.fn.has("win32") == 1 then
    opener = "start"
  end
  os.execute(opener .. " " .. url)
end

local function get_git_blame_commit()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local file = vim.fn.expand("%")
  local blame = vim.fn.systemlist("git blame -L " .. line .. "," .. line .. " --porcelain " .. file .. "| sed -n 's/^\\([0-9a-f]\\{40\\}\\).*/\\1/p' | uniq")
  for _, l in ipairs(blame) do
    local sha = string.match(l, "(%x+)")
    if sha == "0000000000000000000000000000000000000000" then
      return nil
    elseif sha then
      return sha
    end
  end
  return nil
end

local function resolve_repo_name()
  -- Get repo info: remote url -> parse to 'user/repo'
  local remote_url = vim.fn.system("git config --get remote.origin.url"):gsub("\n", "")
  local repo = nil
  -- Convert git@github.com:user/repo.git or https://github.com/user/repo.git to user/repo
  repo = remote_url:match("github.com[:/](.+)%.git")
  return repo
end

local function open_github_commit()
  local commit = get_git_blame_commit()
  if not commit then
    print("No commit found for current line")
    return
  end
  local repo = resolve_repo_name()
  if not repo then
    print("Not a github.com repo")
    return
  end
  local url = "https://github.com/" .. repo .. "/commit/" .. commit
  open_url(url)
end

local function open_github_pr()
  local commit = get_git_blame_commit()
  if not commit then
    print("No commit found for current line")
    return
  end

  local repo = resolve_repo_name()
  if not repo then
    print("Not a github.com repo")
    return
  end

  -- Using GitHub CLI (gh), get PR URL related to commit sha
  local pr_url = vim.fn.system("gh api /repos/" .. repo .. "/commits/" .. commit .. "/pulls | jq -r 'if length > 0 then .[0].html_url else \"\" end'")
  if pr_url == "" then
    print("No PR found for commit")
    return
  end
  open_url(pr_url)
end

vim.keymap.set('n', '<leader>gc',function()
  open_github_commit()
end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gp',function()
  open_github_pr()
end, { noremap = true, silent = true })
