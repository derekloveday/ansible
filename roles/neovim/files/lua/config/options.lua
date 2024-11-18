
local options = {
  autoindent = true,                         -- Copy indent from current line when starting new one (default: true)
  autoread = true,
  autowrite = true,
  backspace = "indent,eol,start",
  backup = false,                            -- creates a backup file
  breakindent = true,                        -- set break indent
  clipboard = "unnamed,unnamedplus",         -- allows neovim to access the system clipboard
  cmdheight = 1,                             -- more space in the neovim command line for displaying messages
  colorcolumn = "120",                       -- limit line length
  completeopt = "menuone,noinsert,noselect", -- mostly just for cmp
  conceallevel = 1,                          -- so that `` is visible in markdown files
  cursorline = true,                         -- highlight the current line
  errorbells = false,                        -- no error bells
  expandtab = true,                          -- convert tabs to spaces
  exrc = true,                               -- enable .exrc files
  fileencoding = "utf-8",                    -- the encoding written to a file
  foldlevelstart = 99,
  foldmethod = "syntax",
  guicursor =
  "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175",
  guifont = "BerkeleyMono Nerd Font:h17",
  hidden = true,                             -- enable modified buffers in background
  hlsearch = false,                          -- highlight all matches on previous search pattern
  ignorecase = true,                         -- ignore case in search patterns
  inccommand = "split",                      -- incrementally show the effects of a command
  incsearch = true,                          -- show search matches incrementally
  laststatus = 2,
  lazyredraw = true,
  linebreak = true,                          -- Companion to wrap, don't split words (default: false)
  list = true,
  modeline = false,
  mouse = "a",                               -- allow the mouse to be used in neovim
  nu = true,                                 -- enable line numbers
  number = true,                             -- set numbered lines
  numberwidth = 4,                           -- set number column width to 2 {default 4}
  pumheight = 10,                            -- pop up menu height
  relativenumber = true,                     -- set relative numbered lines
  scrolloff = 4,                             -- Minimal number of screen lines to keep above and below the cursor (default: 0)
  shiftround = true,
  shiftwidth = 2,                            -- the number of spaces inserted for each indentation
  showbreak = "↳⋅",
  showcmd = true,
  showmode = false,                          -- we don"t need to see things like -- INSERT -- anymore
  showtabline = 2,                           -- never show tabs
  sidescrolloff = 8,
  signcolumn = "yes",                        -- always show the sign column, otherwise it would shift the text each time
  smartcase = true,                          -- smart case
  smartindent = true,                        -- make indenting smarter again
  softtabstop = 2,
  splitbelow = true,                         -- force all horizontal splits to go below current window
  splitkeep = "screen",                      -- Used for avante.nvim
  splitright = true,                         -- force all vertical splits to go to the right of current window
  swapfile = false,                          -- creates a swapfile
  synmaxcol = 4000,
  tabstop = 2,                               -- insert 2 spaces for a tab
  termguicolors = true,                      -- set term gui colors (most terminals support this)
  timeoutlen = 300,                          -- time to wait for a mapped sequence to complete (in milliseconds)
  undodir = os.getenv("HOME") .. "/.vim/undodir",
  undofile = true,                           -- enable persistent undo
  updatetime = 250,                          -- faster completion (4000ms default)
  whichwrap = 'bs<>[]hl',                    -- Which "horizontal" keys are allowed to travel to prev/next line (default: 'b,s')
  winfixwidth = true,
  writebackup = false,                       -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  wrap = false,                              -- display lines as one long line
  -- guifont = "monospace:h17", -- the font used in graphical neovim applications
}

vim.opt.shortmess:append "c"
for k, v in pairs(options) do
  vim.opt[k] = v
end

if vim.fn.has("multi_byte") == 1 and vim.opt.encoding == "utf-8" then
  vim.opt.listchars = [[tab:▸ ,extends:❯,precedes:❮,nbsp:±,trail:…]]
else
  vim.opt.listchars = [[tab:> ,extends:>,precedes:<,nbsp:.,trail:_]]
end

if vim.opt.shell == "fish$" then
  vim.opt.shell = [[/bin/bash]]
end

if ConfigMode == "rich" then
  vim.opt.termguicolors = true
  vim.o.background = "dark"
  vim.opt.clipboard = "unnamedplus"
end

vim.opt.shortmess:append 'c' -- Don't give |ins-completion-menu| messages (default: does not include 'c')
vim.opt.iskeyword:append '-' -- Hyphenated words recognized by searches (default: does not include '-')
vim.opt.formatoptions:remove { 'c', 'r', 'o' } -- Don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode. (default: 'croql')
vim.opt.runtimepath:remove '/usr/share/vim/vimfiles' -- Separate Vim plugins from Neovim in case Vim still in use (default: includes this path if Vim is installed)