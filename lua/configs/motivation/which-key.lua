local wk = require("which-key")

local mappings = {
  f = {
    name = "+file",
    b = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
    c = { "<cmd>Telescope commands<cr>", "Find command" },
    e = { "<cmd>NvimTreeToggle<cr>", "Open/Close File Explorer" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    g = { "<cmd>Telescope live_grep<cr>", "Search In File" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    n = { "<cmd>enew<cr>", "New File" },
  },
  g = { "<cmd>:lua require('configs.tools.term.lazygit').lazygit_toggle()<cr>", "Open/Close LazyGit" },
  s = { "<cmd>nohlsearch<CR>", "No Search Hightlighting" },
  P = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
  t = {
    name = "Terminal",
    f = { "<cmd>ToggleTerm direction=float<cr>", "Open Float Terminal" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Open Horizontal Terminal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Open Vertical Terminal" },
    t = { "<cmd>ToggleTerm size=80 direction=tab<cr>", "Open Terminal in tab" },
  },
  l = {
    name = "LSP",
    D = { "<cmd>:lua vim.lsp.buf.declaration()<cr>", "Go to declaration" },
    d = { "<cmd>:lua vim.lsp.buf.definition()<cr>", "Go to definition" },
    h = { "<cmd>:lua vim.lsp.buf.hover()<cr>", "Display Hover information" },
    i = { "<cmd>:lua vim.lsp.buf.implementation()<cr>", "Lists all the implementations" },
    r = { "<cmd>:lua vim.lsp.buf.references()<cr>", "Lists all the references" },
    l = { "<cmd>:lua vim.diagnostic.open_float()<cr>", "Show diagnostics in a floating window" },
    f = { "<cmd>:lua vim.lsp.buf.format({ async = true })<cr>", "Format current buffer" },
    a = { "<cmd>:lua vim.lsp.buf.code_action()<cr>", "Selects a code action available" },
    j = { "<cmd>:lua vim.diagnostic.goto_prev({buffer=0})<cr>", "Move to the previous diagnostic" },
    k = { "<cmd>:lua vim.diagnostic.goto_next({buffer=0})<cr>", "Move to the next diagnostic" },
    R = { "<cmd>:lua vim.lsp.buf.rename()<cr>", "Rename all references" },
    s = { "<cmd>:lua vim.lsp.buf.signature_help()<cr>", "Displays signature information" },
    q = { "<cmd>:lua vim.diagnostic.setloclist()<cr>", "Add buffer diagnostics to the location list" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  -- prefix: use "<leader>f" for example for mapping everything related to finding files
  -- the prefix is prepended to every mapping part of `mappings`
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  show_keys = true, -- show the currently pressed key and its label as a message in the command line
  triggers = "auto", -- automatically setup triggers
  -- triggers = { "<leader>" }, -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
  -- disable the WhichKey popup for certain buf types and file types.
  -- Disabled by deafult for Telescope
  disable = {
    buftypes = {},
    filetypes = { "TelescopePrompt" },
  },
}

wk.setup(setup)
wk.register(mappings, opts)
