local navic = require("nvim-navic")

vim.api.nvim_set_hl(0, "NavicText", { link = "Comment" })
vim.api.nvim_set_hl(0, "NavicSeparator", { link = "Comment" })

local icons = require("utils.icons")

navic.setup {
  lsp = {
    auto_attach = true,
    preference = nil,
  },
  highlight = true,
  separator = " " .. icons.caretRight .. " ",
  depth_limit = 0,
  depth_limit_indicator = "..",
  safe_output = true
}
