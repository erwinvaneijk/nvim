-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local options = {
  base46= {
    theme = "Rxyhn",
    theme_toggle = { "Rxyhn", "Oceanic-Light" },
    transparancy = true,
  },
  ui = {
    cmp = {
      -- style = "atom_colored",
      style = "default",
      lspkind_text = false,
      icons = true,
    },
    statusline = {
      theme = "vscode" },
  },
  lsp = {
    signature = true,
  },
}
return options
