-- Standalone plugins with less than 10 lines of config go here
return {
  {
    "windwp/nvim-ts-autotag",
    dependencies = {
     "nvim-treesitter/nvim-treesitter", 
    },
    event = "VeryLazy"
  },
  {
    -- Tmux & split window navigation
    'christoomey/vim-tmux-navigator',
  },
  {
    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
  },
  {
    -- Powerful Git integration for Vim
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    end
  },
  {
    -- GitHub integration for vim-fugitive
    'tpope/vim-rhubarb',
  },
  {
    -- Hints keybinds
    'folke/which-key.nvim',
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
  },
  {
    -- High-performance color highlighter
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  {
    "nvim-lua/plenary.nvim"
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  { 
    'nvim-tree/nvim-web-devicons',
    lazy = true
  },
}