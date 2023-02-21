local null_ls = require("null-ls")

local sources = {
  -- Code Action
  null_ls.builtins.code_actions.gitsigns,

  -- Code Formatting
  null_ls.builtins.formatting.prettier, -- need to figure out how to config with prettier
  null_ls.builtins.formatting.terraform_fmt,
}

null_ls.setup({
  sources = sources, -- load sources
})
