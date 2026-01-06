local opts = {
  keymap = { preset = "default" },
  snippets = { preset = "luasnip" },
  appearance = { nerd_font_variant = "mono" },
  completion = {
    documentation = {
      auto_show = false,
      auto_show_delay = 200,
      window = {
        border = "rounded",
      },
    },
    list = {
      selection = {
        preselect = false,
      },
    },
    menu = {
      draw = {
        treesitter = { "lsp" },
      },
    },
    ghost_text = {
      enabled = true,
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer"},
    providers = {
    snippets = {
      opts = {
        friendly_snippets = true, -- default
        },
      },
    },
  },
}

return opts
