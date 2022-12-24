-- require toggleterm
local M = {}

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", direction = "float", hidden = true })

function M.lazygit_toggle()
  lazygit:toggle()
end

return M
