-- setup default function from builtin neovim
require("core.options")
require("core.keymaps")

-- setup plugins
require("core.packer")
-- automatically run :PackerCompile whenever plugins.lua is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
