local module_name = "harpoon"

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },

  config = function()
    local harpoon = require("harpoon")
    local options = require("config.utils.keymap_options")

    -- REQUIRED
    harpoon.setup()
    -- REQUIRED
    --harpoon:extend(extensions.builtins.navigate_with_number)

    local normal_mode = "n"

    -- Harpoon --
    vim.keymap.set(normal_mode, "<leader>a", function() harpoon:list():add() end, options.opts("Add file to list", module_name))
    vim.keymap.set(normal_mode, "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, options.opts("Display list", module_name))

    --
    for i = 1, 9 do
      vim.keymap.set(normal_mode, "" .. i , function()
        harpoon:list():select(i)
      end, options.opts("Select list index " .. i, module_name))
    end

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set(normal_mode, "<A-S-P>", function() harpoon:list():prev() end, options.opts("Toggle to previous file in list", module_name))
    vim.keymap.set(normal_mode, "<A-S-N>", function() harpoon:list():next() end, options.opts("Toggle to next file in list", module_name))
  end
}