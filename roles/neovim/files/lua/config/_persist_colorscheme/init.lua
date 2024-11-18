local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local themes = require("telescope.themes")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local utils = require("telescope.utils")
local conf = require("telescope.config").values

local function getHomePath()
  local uname = vim.loop.os_uname()
  local os_name = uname.sysname
  local is_mac = os_name == 'Darwin'
  local is_linux = os_name == 'Linux'
  local is_windows = os_name:find 'Windows' and true or false
  local home = ""

  if is_linux or is_mac then
    home = os.getenv("HOME") or ""
  elseif is_windows then
    home = os.getenv("USERPROFILE") or ""
  end

  return home
end

-- main table with default options
local M = {
  -- Absolute path to file where colorscheme should be saved
  file_path = getHomePath() .. "/.nvim.colorscheme-persist.lua",
  -- In case there's no saved colorscheme yet
  fallback = "default",
  -- List of ugly colorschemes to avoid in the selection window
  disable = {
    "darkblue",
    "default",
    "delek",
    "desert",
    "elflord",
    "evening",
    "industry",
    "koehler",
    "morning",
    "murphy",
    "pablo",
    "peachpuff",
    "ron",
    "shine",
    "slate",
    "torte",
    "zellner"
  },
  -- Options for the telescope picker
  picker_opts = themes.get_dropdown(),

  enable_preview = false,
}

-- Get list with all colorschemes without disabled ones
local _get_colors = function(disable)
  disable = disable or {}
  local colors = {}
  local all_colors = vim.fn.getcompletion("", "color")
  for _, color in ipairs(all_colors) do
    local ignored = false
    for _, disabled_color in ipairs(disable) do
      if color == disabled_color then
        ignored = true
        break
      end
    end
    if not ignored then
      table.insert(colors, color)
    end
  end
  return colors
end

-- Save colorscheme to file
local _save_colorscheme = function(colorscheme)
  -- write lua code with colorscheme as a string
  -- so it can be be retrieved later by executing the file (dofile)
  vim.loop.fs_open(M.file_path, "w", 432, function(_, fd)
    local string_to_write = "return " .. "'" .. colorscheme .. "'"
    vim.loop.fs_write(fd, string_to_write, nil, function()
      vim.loop.fs_close(fd)
    end)
  end)
end

-- Set options
function M.setup(opts)
  -- override defaults with input options
  opts = opts or {}
  for k, v in pairs(opts) do
    M[k] = v
  end

  -- Set available colors for picker
  M.colorschemes = _get_colors(M.disable)
end

-- Get stored colorscheme
function M.get_colorscheme()
  local ok, colorscheme = pcall(dofile, M.file_path)
  if ok then
    return colorscheme
  else
    return M.fallback
  end
end

-- Open telescope picker to change and save colorscheme
function M.picker()
  local before_color = M.get_colorscheme()
  local loadedColorSchemes = _get_colors(M.disable)
  local colors = loadedColorSchemes or { before_color }

  if not vim.tbl_contains(colors, before_color) then
    table.insert(colors, 1, before_color)
  end

  colors = vim.list_extend(
    { before_color },
    vim.tbl_filter(function(color)
      return color ~= before_color
    end, colors)
  )

  local builtin = require("telescope.builtin")

  local picker = builtin.colorscheme({
    enable_preview = true,
    finder = finders.new_table({ results = colors }),
    sorter = conf.generic_sorter(M.picker_opts),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        -- set selected colorscheme
        local selection = action_state.get_selected_entry()
        local colorscheme = ""
        if selection == nil then
          vim.notify("colorscheme-persist: Selection not valid")
          return
        else
          colorscheme = selection[1]
        end
        -- reset settings before setting new colorscheme
        vim.cmd("hi clear")
        vim.cmd("syntax reset")
        vim.cmd("colorscheme " .. colorscheme) -- change colorscheme
        -- save
        _save_colorscheme(colorscheme)
      end)
      return true
    end,
  })
  
  
  
  --[[
  local picker = pickers.new(M.picker_opts, {
    prompt_title = "colorschemes",
    finder = finders.new_table({ results = colors }),
    sorter = conf.generic_sorter(M.picker_opts),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        -- set selected colorscheme
        local selection = action_state.get_selected_entry()
        local colorscheme = ""
        if selection == nil then
          vim.notify("colorscheme-persist: Selection not valid")
          return
        else
          colorscheme = selection[1]
        end
        -- reset settings before setting new colorscheme
        vim.cmd("hi clear")
        vim.cmd("syntax reset")
        vim.cmd("colorscheme " .. colorscheme) -- change colorscheme
        -- save
        _save_colorscheme(colorscheme)
      end)
      return true
    end,
  })

  if M.enable_preview then
    -- rewrite picker.close_windows. restore color if needed
    local close_windows = picker.close_windows
    picker.close_windows = function(status)
      close_windows(status)
      if need_restore then
        vim.o.background = before_background
        vim.cmd.colorscheme(before_color)
      end
    end

    -- rewrite picker.set_selection so that color schemes can be previewed when the current
    -- selection is shifted using the keyboard or if an item is clicked with the mouse
    local set_selection = picker.set_selection
    picker.set_selection = function(self, row)
      set_selection(self, row)
      local selection = action_state.get_selected_entry()
      if selection == nil then
        utils.__warn_no_selection "builtin.colorscheme"
        return
      end
      if M.enable_preview then
        vim.cmd.colorscheme(selection.value)
      end
    end
  end
  --]]

  -- picker:find()
end

return M