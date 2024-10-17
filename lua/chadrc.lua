-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local options = {
  base46= {
    theme = "Rosepine",
    theme_toggle = { "Rosepine", "Rosepine-Dawn" },
    transparancy = true,
  },
  ui = {
    cmp = {
      style = "atom_colored",
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
