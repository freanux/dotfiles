require('feline').setup()

local feline = require('feline')
local vi_mode = require('feline.providers.vi_mode')

--
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

local MODE_COLOR_FG_INVERT = {
  ['NORMAL'] = false,
  ['COMMAND'] = false,
  ['INSERT'] = false,
  ['REPLACE'] = true,
  ['LINES'] = false,
  ['VISUAL'] = false,
  ['OP'] = false,
  ['BLOCK'] = false,
  ['V-REPLACE'] = false,
  ['ENTER'] = false,
  ['MORE'] = false,
  ['SELECT'] = false,
  ['SHELL'] = false,
  ['TERM'] = false,
  ['NONE'] = false,
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
  orange = '#d65d0e',
  red = '#fb4934',
  violet = '#b16286',
  white = '#ebdbb2',
  yellow = '#fabd2f',
  encoding = '#9b85c7',
  fire = '#bf0000',
  modified = '#5f005f',
}

--
-- 2. setup some helpers
--

--- get the current buffer's file name, defaults to '[no name]'
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

local function is_buffer_modified()
  return vim.bo[vim.api.nvim_win_get_buf(0)].modified
end

local function is_buffer_readonly()
    return vim.bo[vim.api.nvim_win_get_buf(0)].readonly
end

local function is_in_paste_mode()
    return vim.fn['IsInPasteMode']() == 1
end

local function get_filename_bg()
  return (is_buffer_modified() and 'magenta' or 'white')
end

local function get_mode_fg()
  local cur_mode = vi_mode.get_vim_mode()
  if MODE_COLOR_FG_INVERT[cur_mode] then
      return 'white'
  end
  return 'black'
end

--- get the current buffer's file type, defaults to '[not type]'
local function get_filetype()
  local filetype = vim.bo.filetype
  if filetype == '' then
    filetype = '[no type]'
  end
  return filetype:lower()
end

local function get_encoding()
  local enc = ((vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc):lower()
  local ff = vim.o.fileformat
  return enc .. '  ' .. ff
end

--- wrap a string with whitespaces
local function wrap(string)
  return ' ' .. string .. ' '
end

--- wrap a string with whitespaces and add a '' on the left,
-- use on left section components for a nice  transition
local function wrap_left(string)
  return ' ' .. string .. ' '
end

--- wrap a string with whitespaces and add a '' on the right,
-- use on left section components for a nice  transition
local function wrap_right(string)
  return ' ' .. string .. ' '
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

--- provide the vim mode (NORMAL, INSERT, etc.)
local function provide_mode(_, _)
  local cur_mode = vi_mode.get_vim_mode()
  if is_in_paste_mode() then
      if cur_mode == 'INSERT' or cur_mode == 'REPLACE' then
          cur_mode = cur_mode .. '  ' .. 'PASTE'
      end
  end

  return cur_mode
end

--- provide the buffer's file name
local function provide_filename(_, _)
  return get_filename() .. (is_buffer_modified() and ' ●' or '') .. (is_buffer_readonly() and ' ' or '')
end

--- provide the line's information (curosor position and file's total lines)
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

-- provide the buffer's file type
local function provide_filetype(_, _)
  return get_filetype()
end

-- provide the buffer's encoding
local function provide_encoding(_, _)
  return get_encoding()
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

-- insert the mode component at the beginning of the left section
table.insert(components.active[LEFT], {
  name = 'mode',
  provider = wrapped_provider(provide_mode, wrap),
  right_sep = 'right_filled',
  -- hl needs to be a function to avoid calling get_mode_color
  -- before feline initiation
  hl = function()
    return {
      fg = get_mode_fg(),
      bg = vi_mode.get_mode_color(),
    }
  end,
})

-- insert the filename component after the mode component
table.insert(components.active[LEFT], {
  name = 'filename',
  provider = wrapped_provider(provide_filename, wrap_left),
  right_sep = 'right_filled',
  hl = function()
    return {
      bg = get_filename_bg(),
      fg = 'black',
    }
  end,
})

table.insert(components.active[LEFT], {
  provider = 'diagnostic_errors',
  hl = { fg = 'red' },
})

table.insert(components.active[LEFT], {
  provider = 'diagnostic_warnings',
  hl = { fg = 'yellow' },
})

table.insert(components.active[LEFT], {
  provider = 'diagnostic_hints',
  hl = { fg = 'cyan' },
})
table.insert(components.active[LEFT], {
  provider = 'diagnostic_info',
  hl = { fg = 'skyblue' },
})

-- insert the filetype component before the linenumber component
table.insert(components.active[RIGHT], {
  name = 'filetype',
  provider = wrapped_provider(provide_filetype, wrap),
  hl = {
    bg = 'black',
    fg = 'white',
  },
})

-- insert the file encoding component before the linenumber component
table.insert(components.active[RIGHT], {
  name = 'file_encoding',
  provider = wrapped_provider(provide_encoding, wrap_right),
  left_sep = 'left_filled',
  hl = {
    bg = 'encoding',
    fg = 'black',
  },
})

-- insert the linenumber component at the end of the left right section
table.insert(components.active[RIGHT], {
  name = 'linenumber',
  provider = wrapped_provider(provide_linenumber, wrap),
  left_sep = 'slant_left',
  hl = {
    bg = 'skyblue',
    fg = 'black',
  },
})

-- insert the inactive filename component at the beginning of the left section
table.insert(components.inactive[LEFT], {
  name = 'filename_inactive',
  provider = wrapped_provider(provide_filename, wrap),
  right_sep = 'slant_right',
  hl = {
    fg = 'white',
    bg = 'bg',
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

