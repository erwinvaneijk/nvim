return {
  --{
  --  "yorik1984/newpaper.nvim",
  --  priority = 1000,
  --  lazy = false,
  --  config = function()
  --    -- load the colorscheme here
  --    require("config.colorscheme")
  --  end,
  --},
  { "nvim-lua/plenary.nvim",
    lazy = false,
    dependencies = {
      "nvchad/ui",
      "nvchad/base46"
    }
  },
  {
    "nvchad/ui",
    lazy = false,
    config = function ()
      require("nvchad")
    end
  },
  {
    "nvchad/base46",
    lazy = false,
    config = function ()
      require("base46").load_all_highlights()
    end
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  },
  {
    "goolord/alpha-nvim",
    lazy = false,
    config = function()
      require("plugins.alpha")
    end,
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = "bufreadpre",
    config = function()
      require("plugins.treesitter")
    end,
    dependencies = {
      "hiphish/rainbow-delimiters.nvim",
      "joosepalviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "rrethy/nvim-treesitter-textsubjects",
    },
  },

  -- navigating (telescope/tree/refactor)
  {
    "nvim-pack/nvim-spectre",
    lazy = true,
    keys = {
      {
        "<leader>pr",
        "<cmd>lua require('spectre').open_visual({select_word=true})<cr>",
        desc = "refactor",
      },
      {
        "<leader>pr",
        "<cmd>lua require('spectre').open_visual()<cr>",
        mode = "v",
        desc = "refactor",
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    config = function()
      require("plugins.telescope")
    end,
    dependencies = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "cljoly/telescope-repo.nvim" },
      { "nvim-telescope/telescope-frecency.nvim" },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = {
      "NvimTreeOpen",
      "NvimTreeClose",
      "NvimTreeToggle",
      "NvimTreeFindFile",
      "NvimTreeFindFileToggle",
    },
    keys = {
      { "<c-e>", "<cmd>lua require('nvim-tree.api').tree.toggle()<cr>", desc = "nvimtree" },
    },
    config = function()
      require("plugins.tree")
    end,
  },
  {
    "gbprod/stay-in-place.nvim",
    lazy = false,
    config = true, -- run require("stay-in-place").setup()
  },
  {
    "theprimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = "Refactor",
    keys = {
      { "<leader>re", ":Refactor extract ", mode = "x", desc = "extract function" },
      { "<leader>rf", ":Refactor extract_to_file ", mode = "x", desc = "extract function to file" },
      { "<leader>rv", ":Refactor extract_var ", mode = "x", desc = "extract variable" },
      { "<leader>ri", ":Refactor inline_var", mode = { "x", "n" }, desc = "inline variable" },
      { "<leader>ri", ":Refactor inline_func", mode = "n", desc = "inline function" },
      { "<leader>rb", ":Refactor extract_block", mode = "n", desc = "extract block" },
      { "<leader>rf", ":Refactor extract_block_to_file", mode = "n", desc = "extract block to file" },
    },
    config = function()
      require("refactoring").setup()
    end,
  },

  -- lsp base
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    servers = nil,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "mason" },
    },
  },
  -- linter config
  {
    "mfussenegger/nvim-lint",
    event = {
      "bufreadpre",
      "bufnewfile",
    },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        kotlin = { "ktlint" },
        markdown = { "vale" },
        clang = { "clangtidy" },
        python = { "flake8", "pylint" },
        zsh = { "zsh" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "bufenter", "bufwritepost", "insertleave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>ll", function()
        lint.try_lint()
      end, { desc = "trigger linting for current file" })
    end,
  },
  -- python support
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
    opts = {
      name = { "venv", ".venv" },
      auto_refresh = false,
    },
    event = "VeryLazy",
    keys = {
      { '<leader>vs', '<cmd>VenvSelect<cr>' },
      { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
    }
  },
  -- code formatters
  {
    "stevearc/conform.nvim",
    event = { "bufreadpre", "bufnewfile" },
    config = function()
      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
          svelte = { { "prettierd", "prettier" } },
          javascript = { { "prettierd", "prettier" } },
          typescript = { { "prettierd", "prettier" } },
          javascriptreact = { { "prettierd", "prettier" } },
          typescriptreact = { { "prettierd", "prettier" } },
          json = { { "prettierd", "prettier" } },
          graphql = { { "prettierd", "prettier" } },
          java = { "google-java-format" },
          kotlin = { "ktlint" },
          ruby = { "standardrb" },
          markdown = { { "prettierd", "prettier" } },
          erb = { "htmlbeautifier" },
          html = { "htmlbeautifier" },
          bash = { "beautysh" },
          proto = { "buf" },
          rust = { "rustfmt" },
          yaml = { "yamlfix" },
          toml = { "taplo" },
          css = { { "prettierd", "prettier" } },
          scss = { { "prettierd", "prettier" } },
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>lf", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = "format file or range (in visual mode)" })
    end,
  },
  -- lsp cmp
  {
    "hrsh7th/nvim-cmp",
    event = "insertenter",
    config = function()
      require("plugins.cmp")
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",
      "saadparwaiz1/cmp_luasnip",
      { "l3mon4d3/luasnip", dependencies = "rafamadriz/friendly-snippets" },
      {
        "david-kunz/cmp-npm",
        config = function()
          require("plugins.cmp-npm")
        end,
      },
      "petertriho/cmp-git",
    },
  },
  {
    "folke/noice.nvim",
    lazy = false,
    config = function()
      require('plugins.noice')
    end,
  },
  -- lsp addons
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    dependencies = "muniftanjim/nui.nvim",
    config = function()
      require("plugins.dressing")
    end,
  },
  { "onsails/lspkind-nvim" },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      dofile(vim.g.base46_cache .. "trouble")
      require("plugins.trouble")
    end,
  },
  { "nvim-lua/popup.nvim" },
  {
    "smiteshp/nvim-navic",
    config = function()
      require("plugins.navic")
    end,
    dependencies = "neovim/nvim-lspconfig",
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
        easing_function = nil,
        pre_hook = nil,
        post_hook = nil,
      })
    end,
  },
  {
    "dnlhc/glance.nvim",
    config = function()
      require("plugins.glance")
    end,
    cmd = { "Glance" },
    keys = {
      { "gd", "<cmd>Glance definitions<cr>", desc = "lsp definition" },
      { "gr", "<cmd>Glance references<cr>", desc = "lsp references" },
      { "gm", "<cmd>Glance implementations<cr>", desc = "lsp implementations" },
      { "gy", "<cmd>Glance type_definitions<cr>", desc = "lsp type definitions" },
    },
  },
  {
    "antosha417/nvim-lsp-file-operations",
    event = "lspattach",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-tree/nvim-tree.lua" },
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },

  -- general
  { "andrewradev/switch.vim", lazy = false },
  {
    "wansmer/treesj",
    dependencies = { 'nvim-treesitter/nvim-treesitter'},
    lazy = true,
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    keys = {
      { "gj", "<cmd>tsjtoggle<cr>", desc = "toggle split/join" },
    },
    config = function()
      require("treesj").setup({
        use_default_keymaps = false,
      })
    end,
  },
  {
    "numtostr/comment.nvim",
    lazy = false,
    dependencies = "joosepalviste/nvim-ts-context-commentstring",
    config = function()
      require("plugins.comment")
    end,
  },
  {
    "ludopinelli/comment-box.nvim",
    lazy = false,
    keys = {
      { "<leader>ac", "<cmd>lua require('comment-box').lbox()<cr>", desc = "comment box" },
      { "<leader>ac", "<cmd>lua require('comment-box').lbox()<cr>", mode = "v", desc = "comment box" },
    },
  },
  {
    "akinsho/nvim-toggleterm.lua",
    lazy = false,
    branch = "main",
    config = function()
      require("plugins.toggleterm")
    end,
    keys = {
      { "<leader>at", "<cmd>toggleterm direction=float<cr>", desc = "terminal float" },
    },
  },
  { "tpope/vim-repeat", lazy = false },
  { "tpope/vim-speeddating", lazy = false },
  { "dhruvasagar/vim-table-mode", ft = { "markdown" } },
  {
    "otavioschwanck/arrow.nvim",
    lazy = false,
    opts = {
      show_icons = true,
      leader_key = ";", -- this is the way to fire it up.
      always_show_path = false,
      hide_handbook = false,
      save_path = function()
        return vim.fn.stdpath("cache") .. "/arrow"
      end
    },
  },
  {
    "nacro90/numb.nvim",
    lazy = false,
    config = function()
      require("plugins.numb")
    end,
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    event = "bufenter",
    config = function()
      require("plugins.todo-comments")
    end,
  },
  {
    "folke/twilight.nvim",
    config = true,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "flash" },
      { "s", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "flash treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "remote flash" },
      { "r", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "treesitter search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "toggle flash search" },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    lazy = true,
    config = function()
      require("plugins.which-key")
    end,
  },
  {
    "echasnovski/mini.bufremove",
    version = "*",
    config = function()
      require("mini.bufremove").setup({
        silent = true,
      })
    end,
  },
  {
    "echasnovski/mini.nvim",
    version = false,
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "echasnovski/mini.bufremove",
    },
    version = "*",
    config = function()
      require("plugins.bufferline")
    end,
    keys = {
      { "<leader>1", "<cmd>bufferlinegotobuffer 1<cr>" },
      { "<leader>2", "<cmd>bufferlinegotobuffer 2<cr>" },
      { "<leader>3", "<cmd>bufferlinegotobuffer 3<cr>" },
      { "<leader>4", "<cmd>bufferlinegotobuffer 4<cr>" },
      { "<leader>5", "<cmd>bufferlinegotobuffer 5<cr>" },
      { "<leader>6", "<cmd>bufferlinegotobuffer 6<cr>" },
      { "<leader>7", "<cmd>bufferlinegotobuffer 7<cr>" },
      { "<leader>8", "<cmd>bufferlinegotobuffer 8<cr>" },
      { "<leader>9", "<cmd>bufferlinegotobuffer 9<cr>" },
      { "<a-1>", "<cmd>bufferlinegotobuffer 1<cr>" },
      { "<a-2>", "<cmd>bufferlinegotobuffer 2<cr>" },
      { "<a-3>", "<cmd>bufferlinegotobuffer 3<cr>" },
      { "<a-4>", "<cmd>bufferlinegotobuffer 4<cr>" },
      { "<a-5>", "<cmd>bufferlinegotobuffer 5<cr>" },
      { "<a-6>", "<cmd>bufferlinegotobuffer 6<cr>" },
      { "<a-7>", "<cmd>bufferlinegotobuffer 7<cr>" },
      { "<a-8>", "<cmd>bufferlinegotobuffer 8<cr>" },
      { "<a-9>", "<cmd>bufferlinegotobuffer 9<cr>" },
      { "<leader>bb", "<cmd>bufferlinemoveprev<cr>", desc = "move back" },
      { "<leader>bl", "<cmd>bufferlinecloseleft<cr>", desc = "close left" },
      { "<leader>br", "<cmd>bufferlinecloseright<cr>", desc = "close right" },
      { "<leader>bn", "<cmd>bufferlinemovenext<cr>", desc = "move next" },
      { "<leader>bp", "<cmd>bufferlinepick<cr>", desc = "pick buffer" },
      { "<leader>bp", "<cmd>bufferlinetogglepin<cr>", desc = "pin/unpin buffer" },
      { "<leader>bsd", "<cmd>bufferlinesortbydirectory<cr>", desc = "sort by directory" },
      { "<leader>bse", "<cmd>bufferlinesortbyextension<cr>", desc = "sort by extension" },
      { "<leader>bsr", "<cmd>bufferlinesortbyrelativedirectory<cr>", desc = "sort by relative dir" },
    },
  },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      require("plugins.notify")
    end,
  },
  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.fidget")
    end,
  },
  {
    "vuki656/package-info.nvim",
    event = "bufenter package.json",
    config = function()
      require("plugins.package-info")
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "ahmedkhalf/project.nvim",
    event = "bufwinenter",
    config = function()
      require("project_nvim").setup({
        -- configuration goes here.
        detection_methods = { "lsp", "pattern" },
        patterns = {
          ".git",
          "*.git",
          "_darcs",
          ".hg",
          ".bzr",
          ".svn",
          "makefile",
          "cargo.toml",
          "package.json",
          "!.git/worktrees",
        },
        exclude_dirs = { "~/.cargo/*" },
        silent_chdir = true,
        scope_chdir = "global",
      })
    end,
  },
  {
    "shatur/neovim-session-manager",
    lazy = false,
    config = function()
      require("plugins.session-manager")
    end,
    keys = {
      { "<leader>/sc", "<cmd>sessionmanager load_session<cr>", desc = "choose session" },
      { "<leader>/sr", "<cmd>sessionmanager delete_session<cr>", desc = "remove session" },
      { "<leader>/sd", "<cmd>sessionmanager load_current_dir_session<cr>", desc = "load current dir session" },
      { "<leader>/sl", "<cmd>sessionmanager load_last_session<cr>", desc = "load last session" },
      { "<leader>/ss", "<cmd>sessionmanager save_current_session<cr>", desc = "save session" },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true,
  },
  {
    "sunjon/shade.nvim",
    config = function()
      require("shade").setup()
      require("shade").toggle()
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      vim.keymap.set("n", "zr", require("ufo").openAllFolds)
      vim.keymap.set("n", "zm", require("ufo").closeAllFolds)
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
      -- taken from https://github.com/kevinhwang91/nvim-ufo
      -- tell the server the capability of foldingrange,
      -- neovim hasn't added foldingrange to default capabilities, users must add it manually
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true
      }
      local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
      for _, ls in ipairs(language_servers) do
          require('lspconfig')[ls].setup({
              capabilities = capabilities
              -- you can add other fields for setting up lsp server in this table
          })
      end
      require('ufo').setup()
    end,
  },
  --{
  --  "echasnovski/mini.align",
  --  lazy = false,
  --  version = "*",
  --  config = function()
  --    require("mini.align").setup()
  --  end,
  --},
  {
    "echasnovski/mini.ai",
    lazy = false,
    version = "*",
    config = function()
      require("mini.ai").setup()
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "bufreadpre",
    main = "ibl",
    config = function()
      require("plugins.indent")
    end,
  },
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    keys = { "w", "e", "b", "ge" },
    config = function()
      vim.keymap.set({ "n", "o", "x" }, "w", "w", { desc = "normal w" })
      vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<cr>", { desc = "spider-w" })
      vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<cr>", { desc = "spider-e" })
      vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<cr>", { desc = "spider-b" })
      vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<cr>", { desc = "spider-ge" })
    end,
  },

  -- snippets & language & syntax
  {
    "windwp/nvim-autopairs",
    event = "insertenter",
    config = function()
      require("plugins.autopairs")
    end,
  },
  {
    "nvchad/nvim-colorizer.lua",
    config = function()
      require("plugins.colorizer")
    end,
  },

  -- git
  {
    "lewis6991/gitsigns.nvim",
    event = "bufread",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.git.signs")
    end,
    keys = {
      { "<leader>ghd", desc = "diff hunk" },
      { "<leader>ghp", desc = "preview" },
      { "<leader>ghr", desc = "reset buffer" },
      { "<leader>ghr", desc = "reset hunk" },
      { "<leader>ghs", desc = "stage hunk" },
      { "<leader>ghs", desc = "stage buffer" },
      { "<leader>ght", desc = "toggle deleted" },
      { "<leader>ghu", desc = "undo stage" },
    },
  },
  {
    "sindrets/diffview.nvim",
    lazy = true,
    enabled = true,
    event = "bufread",
    config = function()
      require("plugins.git.diffview")
    end,
    keys = {
      { "<leader>gd", "<cmd>lua require('plugins.git.diffview').toggle_file_history()<cr>", desc = "diff file" },
      { "<leader>gs", "<cmd>lua require('plugins.git.diffview').toggle_status()<cr>", desc = "status" },
    },
  },
  {
    "akinsho/git-conflict.nvim",
    lazy = false,
    config = function()
      require("plugins.git.conflict")
    end,
    keys = {
      { "<leader>gcb", "<cmd>gitconflictchooseboth<cr>", desc = "choose both" },
      { "<leader>gcn", "<cmd>gitconflictnextconflict<cr>", desc = "move to next conflict" },
      { "<leader>gcc", "<cmd>gitconflictchooseours<cr>", desc = "choose current" },
      { "<leader>gcp", "<cmd>gitconflictprevconflict<cr>", desc = "move to prev conflict" },
      { "<leader>gci", "<cmd>gitconflictchoosetheirs<cr>", desc = "choose incoming" },
    },
  },
  {
    "theprimeagen/git-worktree.nvim",
    lazy = false,
    config = function()
      require("plugins.git.worktree")
    end,
  },
  {
    "neogitorg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
    opts = {
      disable_signs = false,
      disable_context_hightlighting = false,
      disable_commit_confirmation = false,
      disable_hint = false,
      graphstyle = "unicode",
      remember_settings = true,
      telescope_sorter = nil,
      integrations = {
        diffview = true,
      },
    },
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = {
      "Octo",
    },
    config = function()
      require("plugins.git.octo")
    end,
  },

  -- testing
  {
    "rcarriga/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/fixcursorhold.nvim",
      "haydenmeade/neotest-jest",
    },
    config = function()
      require("plugins.neotest")
    end,
  },
  {
    "andythigpen/nvim-coverage",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = {
      "Coverage",
      "CoverageSummary",
      "CoverageLoad",
      "CoverageShow",
      "CoverageHide",
      "CoverageToggle",
      "CoverageClear",
    },
    config = function()
      require("coverage").setup()
    end,
  },

  -- dap
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("plugins.dap")
    end,
    keys = {
      "<leader>da",
      "<leader>db",
      "<leader>dc",
      "<leader>dd",
      "<leader>dh",
      "<leader>di",
      "<leader>do",
      "<leader>do",
      "<leader>dt",
    },
    dependencies = {
      "thehamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "mxsdev/nvim-dap-vscode-js",
    },
  },
  {
    "liadoz/nvim-dap-repl-highlights",
    config = true,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-treesitter/nvim-treesitter",
    },
    build = function()
      if not require("nvim-treesitter.parsers").has_parser("dap_repl") then
        vim.cmd(":tsinstall dap_repl")
      end
    end,
  },
  {
    "lukas-reineke/virt-column.nvim",
    dev = true,
    config = function ()
      require("virt-column").setup {}
      require("virt-column").overwrite {
        virtcolumn = "+1",
        hightlight = "virtcolumn",
        exclude = {
          filetypes = {
            "lspinfo",
            "packer",
            "checkhealth",
            "man",
            "telescopeprompt",
            "telesecoperesults",
          },
        },
      }
    end,
  },
  {
    "chrisgrieser/nvim-early-retirement",
    opts = {
      retirementagemins = 20,
    },
    event = "VeryLazy",
  },
  {
    "tobinpalmer/tip.nvim",
    event = "vimenter",
    init = function()
      -- default config
      -- @type tip.config
      require("tip").setup({
        title = "tip!",
        url = "https://vtip.43z.one",
      })
    end,
  },
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>o", "<cmd>Outline<cr>", desc = "toggle the outline view" },
    },
    opts = {
      -- when we need extra options.
      width = 20, -- only use 20% of the realestate.
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- recommended in the readme
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
    ft = { "rust" },
    config = function()
      require("plugins.rustaceanvim")
    end,
  },
  {
    "wakatime/vim-wakatime",
    lazy = false,
    config = function()
      -- i think i need to do something, but this is the most
      -- innocent thing i can come up with. it also makes it easy
      -- to enable debugging if i want that.
      vim.cmd(":WakaTimeDebugDisable")
    end,
    opts = {},
  },
}
