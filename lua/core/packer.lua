local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup({
  function(use)
    -- ################################################
    -- # Generic
    -- ################################################
    -- manage packer by itself
    use("wbthomason/packer.nvim")
    -- speedup startup time of neovim
    use({
      "lewis6991/impatient.nvim",
      config = function()
        local imp = require("impatient")
        imp.enable_profile()
      end,
    })
    -- easier to setup filetype
    use({
      "nathom/filetype.nvim",
      config = function()
        require("configs.utils.filetype")
      end,
    })

    -- ################################################
    -- # Tools
    -- ################################################
    -- integrate git changes with GitSign
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("configs.tools.gitsigns")
      end,
    })
    -- Cross editor configuration with editorconfig
    use({ "gpanders/editorconfig.nvim" })
    -- Time tracking with code with wakatime
    use({ "wakatime/vim-wakatime" })
    -- Terminal integration
    use({
      "akinsho/toggleterm.nvim",
      config = function()
        require("configs.tools.toggleterm")
      end,
    })
    -- Integrate with tmux
    use({
      "alexghergh/nvim-tmux-navigation",
      requires = {
        { "tmux-plugins/vim-tmux-focus-events" },
        { "tmux-plugins/vim-tmux" },
      },
      config = function()
        require("configs.tools.tmux")
      end,
    })

    -- ################################################
    -- # UI
    -- ################################################
    -- Control colorscheme with Themer
    use({
      "themercorp/themer.lua",
      config = function()
        require("configs.ui.themer")
      end,
    })
    -- Better indent line and trim whitespace EOL
    use({
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("configs.ui.indent-blankline")
      end,
    })
    -- Enrich search for neovim
    use({
      "kevinhwang91/nvim-hlslens",
      config = function()
        require("hlslens").setup({})
      end,
    })
    -- Syntax highlight and etc.
    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("configs.ui.nvim-treesitter")
      end,
    })
    -- Status line of Neovim
    use({
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = function()
        require("configs.ui.lualine")
      end,
    })
    -- tabline
    use({
      "akinsho/bufferline.nvim",
      tag = "v3.*",
      requires = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("bufferline").setup({})
      end,
    })
    -- Web Devicon Icons
    use({
      "nvim-tree/nvim-web-devicons",
      config = function()
        require("configs.ui.nvim-web-devicons")
      end,
    })
    -- Enhance smooth scrolling
    use({
      "declancm/cinnamon.nvim",
      config = function()
        require("configs.ui.cinnamon")
      end,
    })
    -- disable relative no when it doesn't make sense
    use({
      "nkakouros-original/numbers.nvim",
      config = function()
        require("configs.ui.numbers")
      end
    })

    -- ################################################
    -- # MOTIVATION
    -- ################################################
    -- smart indent guess
    use({
      "nmac427/guess-indent.nvim",
      config = function()
        require("configs.motivation.guess-indent")
      end,
      -- To comparasion about performance
      -- guess-indent vs indent-o-matic
      -- https://github.com/Darazaki/indent-o-matic/issues/12
    })
    -- auto match bracket and closer
    use({
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup({
          disable_filetype = { "TelescopePrompt", "vim" },
        })
      end,
    })
    -- fast surround word
    use({
      "kylechui/nvim-surround",
      tag = "*", -- Use for stability; omit to use `main` branch for the latest features
      config = function()
        require("nvim-surround").setup({})
      end,
    })
    -- multi-cursor
    use({
      "mg979/vim-visual-multi",
    })
    -- comment
    use({
      "terrortylor/nvim-comment",
      config = function()
        require("configs.motivation.nvim-comment")
      end,
    }) -- some issue, can"t run config from packer
    use({
      "ethanholz/nvim-lastplace",
      config = function()
        require("configs.motivation.nvim-lastplace")
      end,
    })
    -- fuzzy search
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "themercorp/themer.lua" },
        { "nvim-tree/nvim-web-devicons" },
      },
      config = function()
        require("configs.motivation.telescope")
      end,
    })
    -- file explorer
    use({
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons", -- optional, for file icons
      },
      tag = "nightly",                  -- optional, updated every week. (see issue #1193)
      config = function()
        require("configs.motivation.nvim-tree")
      end,
    })
    -- which keys
    use({
      "folke/which-key.nvim",
      config = function()
        require("configs.motivation.which-key")
      end,
    })

    -- ################################################
    -- # Completions & Linters
    -- ################################################
    -- better whitespace
    use({
      "lewis6991/spaceless.nvim",
      config = function()
        require("spaceless").setup()
      end,
    })
    -- formatting with lsp -> null-ls
    use({
      "jose-elias-alvarez/null-ls.nvim",
      requires = {
        { "neovim/nvim-lspconfig" },
      },
      config = function()
        require("configs.completion.null-ls")
      end,
    })
    -- LSP installer
    use({
      "williamboman/mason.nvim",
      requires = {
        { "williamboman/mason-lspconfig.nvim" },
        { "neovim/nvim-lspconfig" },
      },
      config = function()
        require("configs.completion.mason")
      end,
    })
    -- completions
    use({
      "hrsh7th/nvim-cmp",
      requires = {
        -- generic
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-cmdline" },
        -- fancy icons
        { "onsails/lspkind.nvim" },
        -- lsp
        { "hrsh7th/cmp-nvim-lsp" },
        { "neovim/nvim-lspconfig" },
        { "williamboman/nvim-lsp-installer" },
        -- snippets
        { "saadparwaiz1/cmp_luasnip" },
        { "L3MON4D3/LuaSnip" },
        { "rafamadriz/friendly-snippets" },
      },
      config = function()
        require("configs.completion.cmp")
      end,
    })
    -- flutter
    use({
      "akinsho/flutter-tools.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("configs.completion.lsp.flutter-tools")
      end,
    })

    -- automatically set up your configuration after cloning packer.nvim
    -- put this at the end after all plugins
    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  -- float term when packer popup the updates
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "rounded" })
      end,
    },
  },
})
