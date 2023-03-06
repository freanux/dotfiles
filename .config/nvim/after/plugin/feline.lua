require('feline').setup()

local feline = require('feline')
local vi_mode = require('feline.providers.vi_mode')

-- 1. define some constants
--

-- left and right constants (first and second items of the components array)
local LEFT = 1
local RIGHT = 2

-- vi mode color configuration
local MODE_COLORS = {
  ['NORMAL'] = 'green',
  ['COMMAND'] = 'skyblue',
  ['INSERT'] = 'orange',
  ['REPLACE'] = 'fire',
  ['LINES'] = 'violet',
  ['VISUAL'] = 'violet',
  ['OP'] = 'yellow',
  ['BLOCK'] = 'yellow',
  ['V-REPLACE'] = 'yellow',
  ['ENTER'] = 'yellow',
  ['MORE'] = 'yellow',
  ['SELECT'] = 'yellow',
  ['SHELL'] = 'yellow',
  ['TERM'] = 'yellow',
  ['NONE'] = 'yellow',
}

local MODE_COLORS_FG = {
  ['REPLACE'] = 'bright',
}

-- gruvbox theme
local GRUVBOX = {
  fg = '#ebdbb2',
  bg = '#3c3836',
  black = '#3c3836',
  skyblue = '#83a598',
  cyan = '#8e07c',
  green = '#8ec431',
  oceanblue = '#076678',
  blue = '#458588',
  magenta = '#d3869b',
  orange = '#ff9801',
  red = '#fb4934',
  violet = '#b16286',
  white = '#ebdbb2',
  yellow = '#fadc2f',
  encoding = '#9b85c7',
  fire = '#bf0000',
  modified = '#5f005f',
  bright = '#ffffff',
}

--
-- 2. setup some helpers
--

local function is_in_paste_mode()
  return vim.api.nvim_get_option("paste")
end

local function is_buffer_modified()
  return vim.bo[vim.api.nvim_win_get_buf(0)].modified
end

local function is_buffer_readonly()
  return vim.bo[vim.api.nvim_win_get_buf(0)].readonly
end

local function is_root()
  return (vim.loop.getuid() == 0)
end

local function get_mode_fg()
  local mode_color = MODE_COLORS_FG[vi_mode.get_vim_mode()]
  return (mode_color == nil and 'black' or mode_color)
end

local function show_paste()
  if is_in_paste_mode() then
    local cur_mode = vi_mode.get_vim_mode()
    if cur_mode == 'INSERT' or cur_mode == 'REPLACE' then
      return true
    end
  end
  return false
end

local function get_filename()
  local filename = vim.api.nvim_buf_get_name(0)
  if filename == '' then
    filename = '[no name]'
  end
  -- this is some vim magic to remove the current working directory path
  -- from the absilute path of the filename in order to make the filename
  -- relative to the current working directory
  return vim.fn.fnamemodify(filename, ':~:.')
end

local function get_modified_appendix()
  return (is_buffer_modified() and '[+]' or '')
end

local function get_filename_bg()
  return (is_buffer_modified() and 'modified' or 'white')
end

local function get_filename_fg()
  return (is_buffer_modified() and 'white' or 'black')
end

local function get_readonly_fg()
  return (is_buffer_modified() and 'red' or 'fire')
end

local function get_root_indicator_opener()
  if is_root() then
    return ''
  end
end

local function get_root_indicator()
  if is_root() then
    return ' ROOT '
  end
end

local function wrap(string)
  return ' ' .. string .. ' '
end

--- decorate a provider with a wrapper function
-- the provider must conform to signature: (component, opts) -> string
-- the wrapper must conform to the signature: (string) -> string
local function wrapped_provider(provider, wrapper)
  return function(component, opts)
    return wrapper(provider(component, opts))
  end
end

--
-- 3. setup custom providers
--

local function provide_filename(_, _)
  return ' ' .. get_filename() .. get_modified_appendix()
end

local function provide_short_filename(_, _)
  return ' ' .. vim.fn.pathshorten(get_filename()) .. get_modified_appendix()
end

local function provide_linenumber(_, _)
  local line_count = vim.api.nvim_buf_line_count(0)
  local cur_y = vim.api.nvim_win_get_cursor(0)[1]
  local cur_x = vim.api.nvim_win_get_cursor(0)[2] + 1
  local percent = 100 * cur_y / line_count
  local perc_pos = string.format('%3i', percent) .. '%%'
  if cur_y == 1 then
    perc_pos = ' Top'
  elseif cur_y == line_count then
    perc_pos = ' Bot'
  end

  return cur_y .. '/' .. line_count .. ':' .. string.format('%3i', cur_x) .. '  ' .. perc_pos;
end

local function provide_short_linenumber(_, _)
  local line_count = vim.api.nvim_buf_line_count(0)
  local cur_y = vim.api.nvim_win_get_cursor(0)[1]
  local cur_x = vim.api.nvim_win_get_cursor(0)[2] + 1
  return cur_y .. '/' .. line_count .. ':' .. cur_x
end

--
-- 4. build the components
--

local components = {
  -- components when buffer is active
  active = {
    {}, -- left section
    {}, -- right section
  },
  -- components when buffer is inactive
  inactive = {
    {}, -- left section
    {}, -- right section
  },
}

table.insert(components.active[LEFT], {
  name = 'mode',
  provider = function()
    return ' ' .. vi_mode.get_vim_mode() .. ' '
  end,
  right_sep = function()
    return (show_paste() and '' or 'right_filled')
  end,
  hl = function()
    return {
      fg = get_mode_fg(),
      bg = vi_mode.get_mode_color(),
      style = 'bold',
    }
  end,
})

table.insert(components.active[LEFT], {
  name = 'paste_opener',
  provider = function()
    return (show_paste() and '' or '')
  end,
  hl = function()
    return {
      bg = vi_mode.get_mode_color(),
      fg = 'black',
    }
  end,
})

table.insert(components.active[LEFT], {
  name = 'paste',
  provider = function()
    return (show_paste() and ' PASTE ' or '')
  end,
  right_sep = 'right_filled',
  hl = function()
    return {
      fg = get_mode_fg(),
      bg = vi_mode.get_mode_color(),
      style = 'bold',
    }
  end,
})

table.insert(components.active[LEFT], {
  name = 'filename_opener',
  provider = '',
  hl = function()
    return {
      bg = get_filename_bg(),
      fg = 'black',
    }
  end,
})

table.insert(components.active[LEFT], {
  name = 'filename',
  provider = provide_filename,
  short_provider = provide_short_filename,
  hl = function()
    return {
      bg = get_filename_bg(),
      fg = get_filename_fg(),
    }
  end,
  priority = 9,
  truncate_hide = true,
})

table.insert(components.active[LEFT], {
  name = 'readonly',
  provider = function()
    return (is_buffer_readonly() and ' ' or '')
  end,
  hl = function()
    return {
      bg = get_filename_bg(),
      fg = get_readonly_fg(),
      style = 'bold',
    }
  end,
})

table.insert(components.active[LEFT], {
  name = 'filename_closer',
  provider = ' ',
  right_sep = 'right_filled',
  hl = function()
    return {
      bg = get_filename_bg(),
      fg = get_filename_fg(),
    }
  end,
})

table.insert(components.active[LEFT], {
  provider = 'diagnostic_errors',
  hl = { fg = 'red' },
  truncate_hide = true,
})

table.insert(components.active[LEFT], {
  provider = 'diagnostic_warnings',
  hl = { fg = 'yellow' },
  truncate_hide = true,
})

table.insert(components.active[LEFT], {
  provider = 'diagnostic_hints',
  hl = { fg = 'cyan' },
  truncate_hide = true,
})

table.insert(components.active[LEFT], {
  provider = 'diagnostic_info',
  hl = { fg = 'skyblue' },
  truncate_hide = true,
})

table.insert(components.active[RIGHT], {
  name = 'filetype',
  provider = function()
	  local filetype = vim.bo.filetype
	  if filetype == '' then
		filetype = '[no type]'
	  end
   	  return ' ' .. filetype:lower() .. ' '
  end,
  hl = {
    bg = 'black',
    fg = 'white',
  },
  priority = -9,
  truncate_hide = true
})

table.insert(components.active[RIGHT], {
  name = 'file_encoding',
  provider = function()
	  local enc = ((vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc):lower()
	  local ff = vim.o.fileformat
      return ' ' .. enc .. '  ' .. ff .. ' '
  end,
  left_sep = 'left_filled',
  hl = {
    bg = 'encoding',
    fg = 'black',
  },
  priority = -8,
  truncate_hide = true,
})

table.insert(components.active[RIGHT], {
  name = 'linenumber',
  provider = wrapped_provider(provide_linenumber, wrap),
  short_provider = wrapped_provider(provide_short_linenumber, wrap),
  left_sep = 'left_filled',
  hl = {
    bg = 'skyblue',
    fg = 'black',
  },
})

table.insert(components.active[RIGHT], {
  name = 'root_indicator_opener',
  provider = get_root_indicator_opener(),
  hl = {
    bg = 'skyblue',
    fg = 'fire',
  }
})

table.insert(components.active[RIGHT], {
  name = 'root_indicator',
  provider = get_root_indicator(),
  hl = {
    bg = 'fire',
    fg = 'bright',
    style = 'bold',
  },
})

table.insert(components.inactive[LEFT], {
  name = 'filename_inactive',
  provider = provide_filename,
  hl = {
    fg = 'white',
    bg = 'bg',
  },
})

table.insert(components.inactive[LEFT], {
  name = 'readonly',
  provider = function()
    return (is_buffer_readonly() and ' ' or '')
  end,
  hl = function()
    return {
      bg = 'black',
      fg = 'red',
      style = 'bold',
    }
  end,
})

table.insert(components.inactive[RIGHT], {
  name = 'root_indicator_opener',
  provider = get_root_indicator_opener(),
  hl = {
    bg = 'black',
    fg = 'fire',
  }
})

table.insert(components.inactive[RIGHT], {
  name = 'root_indicator',
  provider = get_root_indicator(),
  hl = {
    bg = 'fire',
    fg = 'bright',
    style = 'bold',
  },
})

--
-- 5. run the feline setup
--

feline.setup({
  theme = GRUVBOX,
  components = components,
  vi_mode_colors = MODE_COLORS,
})
