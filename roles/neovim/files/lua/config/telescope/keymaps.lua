
local keymap = vim.keymap
local builtin = require('telescope.builtin')
local pickers = require("config.telescope.pickers")


  -- See `:help telescope.builtin`
  keymap.set('n', '<leader>sh', pickers.help_tags, { desc = '[S]earch [H]elp' })
  keymap.set('n', '<leader>sk', pickers.keymaps, { desc = '[S]earch [K]eymaps' })
  keymap.set('n', '<leader>sf', pickers.find_files, { desc = '[S]earch [F]iles' })
  keymap.set('n', '<leader>ss', pickers.builtin, { desc = '[S]earch [S]elect Telescope' })
  keymap.set('n', '<leader>sg', pickers.live_grep, { desc = '[S]earch by [G]rep' })
  keymap.set('n', '<leader>sd', pickers.diagnostics, { desc = '[S]earch [D]iagnostics' })
  keymap.set('n', '<leader>sr', pickers.resume, { desc = '[S]earch [R]esume' })
  keymap.set('n', '<leader>so', pickers.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  keymap.set('n', '<leader>sb', pickers.buffers, { desc = '[ ] Find existing buffers' })

  keymap.set("n", "<leader>sc", function()
    local word = vim.fn.expand("<cword>")
    pickers.grep_string(word)
  end, { desc = '[S]earch current [W]ord'})
  keymap.set("n", "<leader>sw", function()
    local word = vim.fn.expand("<cWORD>")
    pickers.grep_string(word)
  end, { desc = '[S]earch current [W]ord'})

  -- Slightly advanced example of overriding default behavior and theme
  keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
      winblend = 10,
      previewer = false,
    }))
  end, { desc = '[/] Fuzzily search in current buffer' })

  -- It's also possible to pass additional configuration options.
  --  See `:help telescope.builtin.live_grep()` for information about particular keys
  keymap.set('n', '<leader>s/', function()
    builtin.live_grep({
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
      layout_strategy = "horizontal",
      layout_config = {
        preview_width = 0.7
      }
    })
  end, { desc = '[S]earch [/] in Open Files' })