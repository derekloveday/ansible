local default_color = "tokyonight-night"
local color_used = ""

function SetBackgroundTransparency()
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
end

function SetColorScheme(color)
  color = color or default_color
  color_used = color
  vim.cmd.colorscheme(color)

  SetBackgroundTransparency()
end

function ColorScheme(color)
  local status_ok, _ = pcall(SetColorScheme, color)
  if not status_ok then
    vim.notify("Color scheme " .. color_used .. " not found! Using default colorscheme")
    local status2_ok, _ = pcall(SetColorScheme, "default")
    return
  end
end

local persist_colorscheme = require("config._persist_colorscheme")

-- Setup
persist_colorscheme.setup({
  -- Absolute path to file where colorscheme should be saved
  enable_preview = true
})

-- Get stored colorscheme
local colorscheme = persist_colorscheme.get_colorscheme()
if (not colorscheme)
then
  colorscheme = default_color
end

ColorScheme(colorscheme)

SetBackgroundTransparency()

-- Keymap for telescope selection
vim.keymap.set(
  "n",
  "<leader>uu",
  persist_colorscheme.picker,
  { noremap = true, silent = true, desc = "colorscheme-persist" }
)