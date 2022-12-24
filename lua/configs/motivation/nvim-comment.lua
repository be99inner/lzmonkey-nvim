require("nvim_comment").setup({
  hook = function()
    -- Set comment string for Terraform
    if vim.api.nvim_buf_get_option(0, "filetype") == "terraform" then
      vim.api.nvim_buf_set_option(0, "commentstring", "# %s")
    end
  end,
})
