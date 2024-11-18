local module_name = "undotree"

return {
  'mbbill/undotree',

  config = function()
    local options = require("config.utils.keymap_options")

    vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle, options.opts("Toggle Undo Tree", module_name))
    vim.keymap.set("n", "<leader>uf", vim.cmd.UndotreeFocus, options.opts("Focus on Undo Tree", module_name))
  end
}