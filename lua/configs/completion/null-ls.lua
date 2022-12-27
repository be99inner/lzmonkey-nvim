local null_ls = require("null-ls")

local sources = {
  -- Code Action
  null_ls.builtins.code_actions.gitsigns,

  -- Code Formatting
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.formatting.prettier, -- need to figure out how to config with prettier
  null_ls.builtins.formatting.terraform_fmt,
  null_ls.builtins.formatting.eslint,
  null_ls.builtins.formatting.dart_format,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
        vim.lsp.buf.format({ timeout = 3000 })
      end,
    })
  end
end

null_ls.setup({
  sources = sources, -- load sources
  on_attach = on_attach, -- load on_attach function
})
