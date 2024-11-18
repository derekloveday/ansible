return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    config = function() 
      require("catppuccin").setup({
        transparent_background = true,
      })
      
    end
  },
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("tokyonight").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        transparent = true, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = false },
          keywords = { italic = false },
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark", -- style for floating windows
        },
      })
    end
  },
  { 
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    config = function()
      require('rose-pine').setup({
        disable_background = true,
        styles = {
            italic = false,
        },
      })
    end
  },
  {
    "shaunsingh/nord.nvim",
    name = "nord",
    lazy = false,

    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      vim.g.nord_disable_background = true
      vim.g.nord_italic = false
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_bold = false

      require("nord").set()

      local toggle_transparency = function()
        -- bg_transparent = not bg_transparent
        -- vim.g.nord_disable_background = bg_transparent
        vim.g.nord_disable_background = not vim.g.nord_disable_background
        vim.cmd.colorscheme("nord")
      end

      vim.keymap.set("n", "<leader>bg", toggle_transparency, { noremap = true, silent = true })
    end
  }
}
