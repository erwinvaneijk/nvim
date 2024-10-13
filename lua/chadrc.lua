-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local options = {
  base46= {
    theme = "one_light", 
    theme_toggle = { "onedark", "one_light" },
    transparancy = true,
  },
  ui = {
    cmp = {
      style = "atom",
    },
    statusline = {
      theme = "default",
    }
  },
  lsp = {
    signature = true,
  },
}
return options
