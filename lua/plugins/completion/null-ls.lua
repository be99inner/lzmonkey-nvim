local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- Code Action
    null_ls.builtins.code_actions.gitsigns,

    -- Code Formatting
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettier, -- need to figure out how to config with prettier
    null_ls.builtins.formatting.terraform_fmt,
  },
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.formatting()<CR>")

      -- format on save
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format({timeout = 3000})")
    end

    if client.server_capabilities.documentRangeFormattingProvider then
      vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_formatting({})<CR>")
    end
  end,
})
