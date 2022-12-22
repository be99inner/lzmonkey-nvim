local lspconfig = require("lspconfig");
local luasnip = require("luasnip")
local cmp = require("cmp")
local lspkind = require("lspkind")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- loading snippets from luasnippet
require("luasnip.loaders.from_vscode").lazy_load()

-- config icons display for cmp
lspkind.init({
  -- defines how annotations are shown
  -- default: symbol
  -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
  mode = "symbol_text",

  -- default symbol map
  -- can be either 'default' (requires nerd-fonts font) or
  -- 'codicons' for codicon preset (requires vscode-codicons font)
  --
  -- default: 'default'
  preset = "default",

  -- override preset symbols
  --
  -- default: {}
  symbol_map = {
    -- Text = "",
    -- Method = "",
    -- Function = "",
    -- Constructor = "",
    -- Field = "ﰠ",
    -- Variable = "",
    -- Class = "ﴯ",
    -- Interface = "",
    -- Module = "",
    -- Property = "ﰠ",
    -- Unit = "塞",
    -- Value = "",
    -- Enum = "",
    -- Keyword = "",
    -- Snippet = "",
    -- Color = "",
    -- File = "",
    -- Reference = "",
    -- Folder = "",
    -- EnumMember = "",
    -- Constant = "",
    -- Struct = "פּ",
    -- Event = "",
    -- Operator = "",
    -- TypeParameter = ""
  },
})

cmp.setup({
  -- preselect
  preselect = cmp.PreselectMode.None,
  autorestart = false,
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  view = {
    entries = "custom",
  },
  comfirmation = {
    completeopt = "menu,menuone,noinsert,noselect",
  },
  experimental = {
    ghost_text = false -- this feature conflict with copilot.vim's preview.
  },
  formatting = {
    format = lspkind.cmp_format(), -- load configuration from lspkind
  },
  sources = cmp.config.sources({
    { name = "luasnip" }, -- For luasnip users.
    { name = "nvim_lsp" },
    { name = "orgmode" },
    { name = "buffer" },
    { name = "path" },
  }),
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({
      select = false,
      behavior = cmp.ConfirmBehavior.Replace
    }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<C-l>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        return cmp.complete_common_string()
      end
      fallback()
    end, { 'i', 'c' }),
    -- Use Tab for select completion a snippet
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
        -- elseif luasnip.expand_or_jumpable() then
        --   luasnip.expand_or_jump()
        -- elseif has_words_before() then
        --   cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
        -- elseif luasnip.jumpable(-1) then
        --   luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    -- Snippet Jump
    ["<C-j>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-k>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = "buffer" },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" }
  },
  view = {
    entries = { name = "wildmenu", separator = " | " }
  }
})

-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" }
  }, {
    { name = "cmdline" }
  }),
  view = {
    entries = { name = "wildmenu", separator = " | " }
  }
})

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- If LuaLSP
  if client.name ~= "sumneko_lua" then
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

  -- if client.name ~= "jsonls" then
  --   client.resolved_capabilities.document_formatting = false
  -- end
  --
  -- if client.name ~= "terraformls" then
  --   client.resolved_capabilities.document_formatting = true
  -- end
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- list of LSP: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
  "terraformls", "tflint",
  "sumneko_lua", "vimls", "bashls",
  "pyright",
  "eslint",
  "gopls",
  "jsonls", "dockerls", "yamlls",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
  }
end
