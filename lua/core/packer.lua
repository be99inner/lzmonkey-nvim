local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup({
  function(use)
    -- manage packer by itself
    use "wbthomason/packer.nvim"
    -- sppedup startup time of neovim
    use {
      "lewis6991/impatient.nvim",
      config = function()
        local imp = require("impatient")
        imp.enable_profile()
      end
    }

    -- ################################################
    -- # Tools
    -- ################################################
    use {
      "lewis6991/gitsigns.nvim",
      config = function()
        require("plugins.tools.gitsigns")
      end
    }
    use { "editorconfig/editorconfig-vim" } -- editorconfig
    use { "wakatime/vim-wakatime" } -- wakatime
    -- terminal
    use {
      "akinsho/toggleterm.nvim",
      config = function()
        require("toggleterm").setup()
      end
    }
    -- tmux
    use {
      "alexghergh/nvim-tmux-navigation",
      requires = {
        { "tmux-plugins/vim-tmux-focus-events" },
        { "tmux-plugins/vim-tmux" }
      },
      config = function()
        require("plugins.tools.tmux")
      end
    }

    -- ################################################
    -- # UI
    -- ################################################
    use {
      "themercorp/themer.lua",
      config = function()
        require("plugins.ui.themer")
      end
    }
    -- indent line
    use {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("indent_blankline").setup {
          -- for example, context is off by default, use this to turn it on
          show_current_context = true,
          show_current_context_start = true,
          space_char_blankline = " ",
        }
      end
    }
    -- enrich search
    use {
      "kevinhwang91/nvim-hlslens",
      config = function()
        require("hlslens").setup({})
      end
    }
    -- syntax highlight and etc.
    use {
      "nvim-treesitter/nvim-treesitter",
      run = "<cmd>TSUpdate",
      config = function()
        require("plugins.ui.tree-sitter")
      end
    }
    -- status line
    use {
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = function()
        require("plugins.ui.lualine")
      end
    }
    -- icons
    use {
      "nvim-tree/nvim-web-devicons",
      config = function()
        require("plugins.ui.nvim-web-devicons")
      end
    }
    -- smooth scrolling
    use {
      "declancm/cinnamon.nvim",
      config = function()
        require("plugins.ui.cinnamon")
      end
    }

    -- ################################################
    -- # MOTIVATION
    -- ################################################
    -- smart indent guess
    use {
      "nmac427/guess-indent.nvim",
      config = function()
        require("plugins.motivation.guess-indent")
      end,
      -- To comparasion about performance
      -- guess-indent vs indent-o-matic
      -- https://github.com/Darazaki/indent-o-matic/issues/12
    }
    -- auto match bracket and closer
    use {
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup({
          disable_filetype = { "TelescopePrompt", "vim" },
        })
      end
    }
    -- fast surround word
    use {
      "kylechui/nvim-surround",
      tag = "*", -- Use for stability; omit to use `main` branch for the latest features
      config = function()
        require("nvim-surround").setup({})
      end
    }
    -- comment
    use {
      "terrortylor/nvim-comment",
      config = function()
        require("plugins.motivation.nvim-comment")
      end
    } -- some issue, can"t run config from packer
    use {
      "ethanholz/nvim-lastplace",
      config = function()
        require 'nvim-lastplace'.setup {
          lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
          lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
          lastplace_open_folds = true
        }
      end
    }
    -- fuzzy search
    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "themercorp/themer.lua" },
        { "nvim-tree/nvim-web-devicons" },
      },
      config = function()
        require("plugins.motivation.telescope")
      end
    }
    -- file explorer
    use {
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons", -- optional, for file icons
      },
      tag = "nightly", -- optional, updated every week. (see issue #1193)
      config = function()
        require("plugins.motivation.nvim-tree")
      end
    }
    -- which keys
    use {
      "folke/which-key.nvim",
      config = function()
        require("plugins.motivation.which-key")
      end
    }

    -- ################################################
    -- # Completions & Linters
    -- ################################################
    -- better whitespace
    use {
      "lewis6991/spaceless.nvim",
      config = function()
        require("spaceless").setup()
      end
    }
    -- formatting with lsp -> null-ls
    use {
      "jose-elias-alvarez/null-ls.nvim",
      requires = {
        { "neovim/nvim-lspconfig" },
      },
      config = function()
        require("plugins.completion.null-ls")
      end
    }
    -- LSP installer
    use {
      "williamboman/mason.nvim",
      requires = {
        { "williamboman/mason-lspconfig.nvim" },
        { "neovim/nvim-lspconfig" },
      },
      config = function()
        require("plugins.completion.mason")
      end
    }
    -- completions
    use {
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
        require("plugins.completion.cmp")
      end
    }

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
        return require('packer.util').float({ border = 'rounded' })
      end
    }
  }
})
