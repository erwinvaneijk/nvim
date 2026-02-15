local opts = {
  snippets = { preset = "luasnip" },
  appearance = {
    nerd_font_variant = "mono",
    use_nvim_cmp_as_default = false,
  },
  completion = {
    accept = {
      auto_brackets = {
        enabled = true,
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 250,
      treesitter_highlighting = true,
      window = {
        border = "rounded",
      },
    },
    list = {
      selection = {
        preselect = false,
        auto_insert = true,
      }
    },
    menu = {
      border = "rounded",
      draw = {
        treesitter = { "lsp" },
      },
    },
    ghost_text = {
      enabled = true,
    },
  },
  signature = {
    enabled = true,
    window = {
      border = "rounded",
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer"},
    providers = {
      lsp = {
        min_keyword_length = 2,
        score_offset = 0,
      },
      path = {
        min_keyword_length = 0,
      },
      snippets = {
        min_keyword_length = 2,
        opts = {
          friendly_snippets = true, -- default
          },
      },
      buffer = {
        min_keyword_length = 5,
        max_items = 5,
      },
    },
  },
  keymap = {
    ["<CR>"] = { "accept", "fallback" },
    ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<Tab>"] = {
      function(cmp)
        return cmp.select_next()
      end,
      "snippet_forward",
      "fallback",
    },
    ["<S-Tab>"] = {
      function(cmp)
        return cmp.select_prev()
      end,
      "snippet_backward",
      "fallback",
    },
    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },
    ["<C-n>"] = { "select_next", "fallback" },
    ["<C-Up>"] = { "scroll_documentation_up", "fallback" },
    ["<C-Down>"] = { "scroll_documentation_down", "fallback" },
  },
}

return opts
