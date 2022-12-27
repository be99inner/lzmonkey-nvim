-- default from lsp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("flutter-tools").setup({
  ui = {
    border = "rounded",
    notification_style = "plugin",
  },
  widget_guides = {
    enabled = false,
  },
  lsp = {
    capabilities = capabilities,
    color = {
      enabled = true,
    },
  },
})
