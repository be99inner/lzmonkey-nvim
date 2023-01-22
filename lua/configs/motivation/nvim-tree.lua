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
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
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
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
  pattern = "NvimTree_*",
  callback = function()
    local layout = vim.api.nvim_call_function("winlayout", {})
    if layout[1] == "leaf"
        and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
        and layout[3] == nil
    then
      vim.cmd("confirm quit")
    end
  end,
})
