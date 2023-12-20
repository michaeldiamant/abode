-- Highlight yanked text.
vim.cmd[[au TextYankPost * silent! lua vim.highlight.on_yank({timeout=500})]]

-- Save all buffers on focus lost.
-- * Source: https://vim.fandom.com/wiki/Auto_save_files_when_focus_is_lost
-- * For tmux integration: `set -g focus-events on`
vim.cmd[[:au FocusLost * :wa]]

-- Refresh stale buffers when file system changed outside of nvim.
vim.cmd[[:set autoread]]
