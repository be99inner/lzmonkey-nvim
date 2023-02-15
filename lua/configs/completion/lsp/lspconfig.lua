local lspconfig = require("lspconfig")

-- set log lv
vim.lsp.set_log_level("info")

-- ui border
require("lspconfig.ui.windows").default_options.border = "rounded"

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- list of LSP: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
  -- vim
  "lua_ls",
  "vimls",
  -- terraform
  "terraformls",
  "tflint",
  -- bash
  "bashls",
  -- python
  "pyright",
  -- javascript
  "tsserver",
  -- golang
  "gopls",
  -- json
  "jsonls",
  -- docker
  "dockerls",
  -- yaml
  "yamlls",
  -- markdown
  "marksman",
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    -- Auto format on saving
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

  -- If LuaLSP
  if client.name ~= "lua_ls" then
    client.settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you"re using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    }
  end
end

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end
