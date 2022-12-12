-- default option for nvim
local g_options = {
  -- mapleader = " ",                    -- set leader to SPACE
  mapleader = "<space>"
}

local options = {
  encoding = "utf-8", -- encoding
  fileencoding = "utf-8",
  termguicolors = true, -- set term gui colors (most terminals support this)
  cursorline = true, -- show cursorline
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  guifont = "Hack Nerd Font", -- set font for gui client

  showtabline = 2, -- always show tabs

  tabstop = 4, -- default tabstop
  softtabstop = 4,
  shiftwidth = 4,
  shiftround = true,
  expandtab = true,
  smartindent = true,

  number = true, -- display line number
  relativenumber = true, -- display line number in relative number of cursorline
  scrolloff = 8, -- is one of my fav
  sidescrolloff = 8,
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time

  backup = false, -- disable backup
  writebackup = false,
  swapfile = false, -- disable swapfile
  hidden = true, -- required to keep multiple buffers and open multiple buffers
  undofile = true, -- enable persistent undo

  hlsearch = true, -- make search case insensitive
  incsearch = true,
  ignorecase = true,
  smartcase = true,

  wrap = false, -- display lines as one long line

  timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
  updatetime = 300, -- faster completion (4000ms default)

  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
}

-- set bundle of globa options
for k, v in pairs(g_options) do
  vim.g[k] = v
end
-- set bundle of options
for k, v in pairs(options) do
  vim.opt[k] = v
end

-- wild ignore
vim.opt.wildignore:append { "*/tmp/*", "*.so", "*.swp", "*.zip", "*.pyc", "*./.terraform/*", ".git" }
