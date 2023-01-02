local lspconfig = require("lspconfig")

-- ui border
require("lspconfig.ui.windows").default_options.border = "rounded"

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- list of LSP: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
	"terraformls",
	"tflint",
	"sumneko_lua",
	"vimls",
	"bashls",
	"pyright",
	"tsserver",
	"gopls",
	"jsonls",
	"dockerls",
	"yamlls",
}

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
end

for _, server in ipairs(servers) do
	lspconfig[server].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
end
