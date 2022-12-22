require("themer").setup({
  -- colorscheme = "amora",
  colorscheme = "darknight",
  dim_inactive = true,
  term_colors = false,
  transparent = false,
  styles = {
    ["function"]    = { style = 'italic,bold' },
    functionbuiltin = { style = 'italic,bold' },
    variable        = { style = 'italic' },
    variableBuiltIn = { style = 'italic' },
    parameter       = { style = 'italic' },
  },
  plugins = {
    treesitter = true,
    cmp = true,
    indentline = true,
    lsp = true,
    gitsigns = true,
    telescope = true,
    lualine = true,
  },
})
