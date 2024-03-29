-- custom sign for diagnostic
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- diagnostic config
vim.diagnostic.config({
  underline = true,
  signs = true,
  virtual_text = false,
  float = {
    show_header = true,
    source = "always",
    border = "rounded",
    focusable = true,
  },
  update_in_insert = false, -- default to false
  severity_sort = true, -- default to false
})

-- auto popup diagnostic message when cursor is hover the line
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]])

-- reddit thread for floating window
-- https://www.reddit.com/r/neovim/comments/mq2nyw/floating_window_can_have_borders_now_on_neovim/
