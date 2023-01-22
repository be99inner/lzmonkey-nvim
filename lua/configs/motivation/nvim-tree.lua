require("nvim-tree").setup({
  auto_reload_on_write = true,
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  sort_by = "case_sensitive",
  reload_on_bufenter = true,
  hijack_unnamed_buffer_when_opening = true,
  view = {
    adaptive_size = true,
    mappings = {
      -- list = {
      --   { key = "u", action = "dir_up" },
      -- },
    },
  },
  renderer = {
    group_empty = false,
    highlight_git = true,
    icons = {
      show = {
        folder_arrow = false,
      },
    },
    indent_markers = {
      enable = true,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        -- bottom = "─", -- Unknow bottom
        none = " ",
      },
    },
  },
  filters = {
    dotfiles = false,
    custom = { ".git$" },
    exclude = { ".gitignore" },
  },
  git = {
    timeout = 2000,
  },
  log = {
    enable = true,
    truncate = true,
    types = {
      git = true,
      profile = true,
    },
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 100,
  },
})

-- automatically close NvimTree when it's last buffer.
-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close#naive-solution
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
      vim.cmd("quit")
    end
  end,
})
