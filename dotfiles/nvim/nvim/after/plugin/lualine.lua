
local gruvbox_dark_soft = {
  normal = {
    a = { fg = '#282828', bg = '#ebdbb2', gui = 'bold' },
    b = { fg = '#ebdbb2', bg = '#32302f' },
    c = { fg = '#ebdbb2', bg = '#32302f' },
  },
  insert = {
    a = { fg = '#282828', bg = '#83a598', gui = 'bold' },
    b = { fg = '#ebdbb2', bg = '#32302f' },
    c = { fg = '#ebdbb2', bg = '#32302f' },
  },
  visual = {
    a = { fg = '#282828', bg = '#d3869b', gui = 'bold' },
    b = { fg = '#ebdbb2', bg = '#32302f' },
    c = { fg = '#ebdbb2', bg = '#32302f' },
  },
  replace = {
    a = { fg = '#282828', bg = '#fb4934', gui = 'bold' },
    b = { fg = '#ebdbb2', bg = '#32302f' },
    c = { fg = '#ebdbb2', bg = '#32302f' },
  },
  inactive = {
    a = { fg = '#a89984', bg = '#32302f', gui = 'bold' },
    b = { fg = '#a89984', bg = '#32302f' },
    c = { fg = '#a89984', bg = '#32302f' },
  },
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    -- theme = gruvbox_dark_soft,
    theme = "gruvbox_light",
    -- theme = 'gruvbox',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'branch', 'encoding'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
