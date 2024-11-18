local telescope = require("telescope.builtin")

local function find_files()
  telescope.find_files({
    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.7
    }
  })
end

local function git_files()
  telescope.git_files({
    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.7
    }
  })
end

local function keymaps()
  telescope.keymaps({
    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.7
    }
  })
end

local function builtin()
  telescope.builtin({
    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.7
    }
  })
end


local function oldfiles()
  telescope.oldfiles({
    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.7
    }
  })
end

local function live_grep()
  telescope.live_grep({
    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.7
    }
  })
end

local function help_tags()
  telescope.help_tags({
    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.7
    }
  })
end

local function grep_string(word)
  telescope.grep_string({ 
    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.7
    },
    search = word 
  })
end

local function diagnostics()
  telescope.diagnostics({ 
    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.7
    } 
  })
end

local function resume()
  telescope.resume({ 
    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.7
    } 
  })
end

local function buffers()
  telescope.buffers({ 
    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.7
    } 
  })
end

return {
  find_files = find_files,
  git_files = git_files,
  keymaps = keymaps,
  builtin = builtin,
  oldfiles = oldfiles,
  live_grep = live_grep,
  help_tags = help_tags,
  grep_string = grep_string,
  diagnostics = diagnostics,
  resume = resume,
  buffers = buffers,
}
