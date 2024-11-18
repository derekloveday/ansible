return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  event = {"BufReadPre", "BufNewFile"},
  -- keymaps = {
  --   { "n", "<leader>it", ":InspectTree<CR>" },
  -- },
  dependencies = {
    "HiPhish/rainbow-delimiters.nvim"
    -- "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      -- A list of parser names, or "all"
      ensure_installed = {
        "awk",
        "bash", 
        "c",
        "cpp",
        "css",
        "dockerfile",
        "gitignore",
        "html",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "kotlin",
        "latex",
        "lua",
        "markdown",
        "markdown_inline",
        "ninja",
        "python",
        "query",
        "regex",
        "tmux",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = true,
      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,
      highlight = {
        -- `false` will disable the whole extension
        enable = true,
        additional_vim_regex_highlighting = true,
      },
      autotag = { enable = true },
      indent = { enable = true },
      rainbow = {
        enable = true,
        -- Which query to use for finding delimiters
        query = 'rainbow-parens',
        -- Highlight the entire buffer all at once
        strategy = require('rainbow-delimiters').strategy.global,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-n>",
          node_incremental = "<C-n>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      }
    })

    local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    treesitter_parser_config.templ = {
        install_info = {
            url = "https://github.com/vrischmann/tree-sitter-templ.git",
            files = {"src/parser.c", "src/scanner.c"},
            branch = "master",
        },
    }

    vim.treesitter.language.register("templ", "templ")
  end
}
