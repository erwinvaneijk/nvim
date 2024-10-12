vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache"

require('utils.globals')
require('utils.functions')

require('config.options')

require('config.lazy')

dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require('config.keymappings')
require('config.autocmds')

require('internal.winbar')
require('internal.cursorword')

require('lsp.config')
require('lsp.setup')
require('lsp.functions')

require('snippets.react')
