-- ~/.config/nvim/init.lua

-- Set <space> as the leader key
-- IMPORTANT: Must be done before plugins are required
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install lazy.nvim package manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require('lazy').setup({
  -- == Core Plugins == --
  'nvim-lua/plenary.nvim', -- Utility functions
  'nvim-tree/nvim-web-devicons', -- File icons

  -- == Theme == --
  {
    'sainnhe/everforest',
    priority = 1000, -- Ensure it loads first
    config = function()
      vim.g.everforest_background = 'hard' -- or 'medium', 'soft'
      vim.g.everforest_better_performance = 1
      vim.cmd.colorscheme('everforest')
    end,
  },

  -- == UI Enhancements == --
  {
    'nvim-lualine/lualine.nvim', -- Status line
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'everforest',
          -- ... other lualine options
        },
      })
    end,
  },
  {
    'nvim-tree/nvim-tree.lua', -- File explorer
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup({
        -- Optional: Setup git integration in nvim-tree
        git = {
          enable = true,
          ignore = false,
        },
        -- Optional: Hide .git, node_modules, etc.
        filters = {
          dotfiles = false, -- Show dotfiles
          custom = { '^.git$', '^node_modules$', '^target$' }, -- Hide these folders/files
        },
        view = {
          width = 30,
          side = 'left',
          -- Optional: adaptive size based on window width
          -- adaptive_size = true,
        },
        renderer = {
          group_empty = true,
          icons = {
            glyphs = {
              git = {
                unstaged = "",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
        diagnostics = {
          enable = true,
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          }
        },
        -- Update the focused file on cursor move
        update_focused_file = {
          enable = true,
          update_cwd = true, -- Also change Neovim's CWD
        },
      })
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim', -- Indentation guides
    main = "ibl",
    opts = {
      -- Use spaces for scope characters
      scope = { enabled = true, show_start = false, show_end = false },
      -- Exclude filetypes like help, terminal, dashboard
      exclude = { filetypes = { "help", "terminal", "lazy", "mason", "NvimTree" } },
    },
    config = function(_, opts)
        require("ibl").setup(opts)
    end,
  },

  -- == Editing Enhancements == --
  {
    'numToStr/Comment.nvim', -- Commenting (gcc, gc<motion>)
    config = function()
      require('Comment').setup()
    end,
  },
  {
    'windwp/nvim-autopairs', -- Auto closing pairs
    event = "InsertEnter",
    config = function()
        require('nvim-autopairs').setup({})
        -- Optional: If you want integration with nvim-cmp
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        cmp.event:on(
          'confirm_done',
          cmp_autopairs.on_confirm_done()
        )
    end
  },
  {
      "JoosepAlviste/nvim-ts-context-commentstring", -- Set commentstring based on cursor context
      lazy = true,
      opts = {
          enable_autocmd = false, -- We set it up manually in ftplugin files or lsp config
      },
  },

  -- == Treesitter == --
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'javascript',
          'html', 'css', 'json', 'yaml', 'markdown', 'markdown_inline',
          'bash', 'vim', 'vimdoc', 'java', 'make', 'cmake'
        },
        sync_install = false, -- Install parsers synchronously (blocks UI)
        auto_install = true, -- Automatically install missing parsers
        highlight = {
          enable = true, -- Enable syntax highlighting
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true, -- Enable indentation based on treesitter
        },
        -- Required for context commentstring plugin
        context_commentstring = {
           enable = true,
           enable_autocmd = false, -- We handle this elsewhere
        },
        -- Other modules: https://github.com/nvim-treesitter/nvim-treesitter#available-modules
      })

      -- Set commentstring for JSX/TSX files explicitly
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "typescriptreact", "javascriptreact" },
        callback = function()
          require("ts_context_commentstring.internal").update_commentstring()
          -- Optional: You might need specific settings here if the default isn't perfect
          -- vim.bo.commentstring = "{/* %s */}"
        end,
      })
    end,
  },

  -- == LSP & Completion == --
  {
    'neovim/nvim-lspconfig', -- LSP configuration framework
    dependencies = {
      -- Automatically install LSPs, formatters, linters
      { 'williamboman/mason.nvim', config = true }, -- Needs to run config() before mason-lspconfig
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} }, -- Consider replacing if causing issues

      -- Autocompletion Engine
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
      'hrsh7th/cmp-buffer', -- Buffer source for nvim-cmp
      'hrsh7th/cmp-path', -- Path source for nvim-cmp
      'hrsh7th/cmp-cmdline', -- Command line source for nvim-cmp

      -- Snippets Engine & Sources
      'L3MON4D3/LuaSnip', -- Snippet engine
      'saadparwaiz1/cmp_luasnip', -- Snippet source for nvim-cmp
      'rafamadriz/friendly-snippets', -- A collection of snippets
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      require('luasnip.loaders.from_vscode').lazy_load() -- Load VSCode-style snippets

      -- Setup nvim-cmp.
      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(), -- Trigger completion
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<Tab>'] = cmp.mapping(function(fallback) -- Navigate completion items / snippets
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For snippets
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),
      })

      -- Set configuration for specific filetype(s).
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you have it installed
        }, {
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })

      -- LSP Setup --
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      -- Add inlay hints capabilities if supported
      capabilities.textDocument.inlayHint = {
          dynamicRegistration = false,
          resolveSupport = {
              properties = {
                  "textEdits",
                  "tooltip",
                  "location",
                  "command",
              },
          },
      }


      local lspconfig = require('lspconfig')
      local mason_lspconfig = require('mason-lspconfig')

      -- Define LSP server configurations
      local servers = {
        -- Web Dev
        'typescript-language-server', -- TypeScript/JavaScript/React
        'html',
        'cssls', -- CSS/SCSS/Less
        'emmet_ls', -- HTML/CSS abbreviations

        -- Java
        'jdtls',

        -- C/C++
        'clangd',

        -- Lua (for Neovim config)
        'lua_ls',

        -- Shell
        'bashls',

        -- Other useful LSPs
        'jsonls',
        'yamlls',
        'marksman', -- Markdown
        'dockerls',
        'docker_compose_language_service',
        'tailwindcss', -- If you use TailwindCSS
      }

      -- Setup servers via mason-lspconfig
      mason_lspconfig.setup({
        ensure_installed = servers,
        handlers = {
          -- Default handler: Setup server with capabilities
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
              on_attach = on_attach, -- Common attach function
            })
          end,

          -- Custom handler for lua_ls
          ['lua_ls'] = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              on_attach = on_attach,
              settings = {
                Lua = {
                  runtime = { version = 'LuaJIT' },
                  diagnostics = {
                    globals = { 'vim' }, -- Recognize vim global
                  },
                  workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false, -- Avoid diagnosing lua files in other plugins
                  },
                  telemetry = { enable = false },
                },
              },
            })
          end,

          -- Custom handler for jdtls (requires more setup)
          ['jdtls'] = function()
            -- Requires java development kit (JDK) installed
            -- Point to the location of jdtls installation managed by mason
            local jdtls_path = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
            local lombok_path = vim.fn.glob(jdtls_path .. '/lombok.jar', true) -- Find lombok if present
            local config_dir = vim.fn.stdpath("config") .. "/lsp-settings/java" -- Store project specific settings here

            -- Determine OS specific path separator
            local path_sep = package.config:sub(1, 1) == '\\' and ';' or ':'

            -- Get root directory based on common Java project markers
            local root_markers = {'gradlew', 'mvnw', '.git'}
            local root_dir = require('lspconfig.util').root_pattern(unpack(root_markers))(vim.fn.expand('%:p:h')) or vim.fn.getcwd()

            -- Workspace folder (can be unique per project based on root_dir)
            local workspace_folder = config_dir .. "/" .. vim.fn.fnamemodify(root_dir, ':p:h:t')

            lspconfig.jdtls.setup({
              capabilities = capabilities,
              on_attach = on_attach,
              cmd = {
                'java',
                '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                '-Dosgi.bundles.defaultStartLevel=4',
                '-Declipse.product=org.eclipse.jdt.ls.core.product',
                '-Dlog.protocol=true',
                '-Dlog.level=ALL',
                '-Xms1g',
                '--add-modules=ALL-SYSTEM',
                '--add-opens', 'java.base/java.util=ALL-UNNAMED',
                '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
                '-jar', vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
                '-configuration', vim.fn.glob(jdtls_path .. '/config_linux'), -- Adjust if not on Linux
                '-data', workspace_folder,
                -- Add lombok agent if found
                (lombok_path ~= '' and '-javaagent:' .. lombok_path or ''),
              },
              root_dir = root_dir,
              settings = {
                java = {
                  -- Configure Java runtime path if needed
                  -- home = "/path/to/jdk",
                  signatureHelp = { enabled = true },
                  contentProvider = { preferred = 'fernflower' },
                  completion = {
                    favoriteStaticMembers = {
                      "org.hamcrest.MatcherAssert.assertThat",
                      "org.hamcrest.Matchers.*",
                      "org.hamcrest.CoreMatchers.*",
                      "org.junit.jupiter.api.Assertions.*",
                      "java.util.Objects.requireNonNull",
                      "java.util.Objects.requireNonNullElse",
                      "org.mockito.Mockito.*"
                    },
                    importOrder = {
                      "java",
                      "javax",
                      "com",
                      "org"
                    }
                  },
                  sources = {
                    organizeImports = {
                      starThreshold = 9999;
                      staticStarThreshold = 9999;
                    }
                  },
                  format = {
                    enabled = true, -- Use jdtls formatting
                    -- Or specify settings file: settingsUrl = "/path/to/eclipse-formatter.xml"
                  },
                  -- For Spring Boot
                  configuration = {
                     runtimes = {
                       -- Add runtimes if needed, e.g., for different JDK versions
                       -- { name = "JavaSE-17", path = "/usr/lib/jvm/java-17-openjdk" }
                     }
                  },
                  -- Enable inlay hints
                  inlayHints = {
                      parameterNames = { enabled = 'literals' } -- 'none', 'literals', 'all'
                  },
                  -- Enable debugging capabilities (requires nvim-dap setup separately)
                  -- implementaionSpecific = {
                  --   ['com.microsoft.java.debug.settings.vmArgs'] = '-XX:+UseG1GC -Xmx4G'
                  -- }
                }
              },
              -- Needed for debugging later with nvim-dap
              -- init_options = {
              --   bundles = {}
              -- },
            })
          end,
        }
      })

      -- LSP Keybindings (on_attach function)
      function on_attach(client, bufnr)
        local map = function(mode, lhs, rhs, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end
          vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
        end

        -- VS Code-like keybindings
        map('n', 'gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('n', 'gr', vim.lsp.buf.references, '[G]oto [R]eferences')
        map('n', 'gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
        map('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature Help')
        map('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame') -- Leader + rn
        map('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction') -- Leader + ca
        map('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, '[F]ormat Code') -- Leader + f
        map('n', '[d', vim.diagnostic.goto_prev, 'Go to Previous Diagnostic')
        map('n', ']d', vim.diagnostic.goto_next, 'Go to Next Diagnostic')
        map('n', '<leader>e', vim.diagnostic.open_float, 'Show Line Diagnostics') -- Leader + e
        map('n', '<leader>q', vim.diagnostic.setloclist, 'Open Diagnostics List') -- Leader + q

        -- Enable inlay hints on attach if supported by the client
        if client.supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            -- Optional: Toggle keymap
            map('n', '<leader>ih', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({bufnr}), {bufnr = bufnr}) end, 'Toggle Inlay Hints')
        end

        -- Set commentstring for the buffer using treesitter context
        if client.supports_method("textDocument/completion") then
            require("nvim-treesitter.configs").setup { context_commentstring = { enable = true, enable_autocmd = false } }
            pcall(require("ts_context_commentstring.internal").update_commentstring, bufnr)
        end
      end

      -- Configure diagnostic signs
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      vim.diagnostic.config({
        virtual_text = false, -- Disable virtual text diagnostics (inline)
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          source = "always", -- Show source of diagnostic e.g. 'tsserver'
          border = "rounded",
        },
      })

    end, -- End LSP config function
  }, -- End LSP plugin group

  -- == Git Integration == --
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        signs = {
          add = { hl = 'GitSignsAdd', text = '▎', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
          change = { hl = 'GitSignsChange', text = '▎', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
          delete = { hl = 'GitSignsDelete', text = '', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
          topdelete = { hl = 'GitSignsDelete', text = '', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
          changedelete = { hl = 'GitSignsChange', text = '▎', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000,
        preview_config = {
          -- Options passed to nvim_open_win
          border = 'rounded',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1,
        },
        yadm = {
          enable = false,
        },
        -- Actions (available via :Gitsigns command or custom keymaps)
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local map = function(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true, desc="Next Git Hunk"})

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true, desc="Prev Git Hunk"})

          -- Actions
          map('n', '<leader>hs', gs.stage_hunk, {desc="Git Stage Hunk"})
          map('n', '<leader>hr', gs.reset_hunk, {desc="Git Reset Hunk"})
          map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end, {desc="Git Stage Hunk"})
          map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end, {desc="Git Reset Hunk"})
          map('n', '<leader>hS', gs.stage_buffer, {desc="Git Stage Buffer"})
          map('n', '<leader>hR', gs.reset_buffer, {desc="Git Reset Buffer"})
          map('n', '<leader>hu', gs.undo_stage_hunk, {desc="Git Undo Stage Hunk"})
          map('n', '<leader>hp', gs.preview_hunk, {desc="Git Preview Hunk"})
          map('n', '<leader>hb', function() gs.blame_line{full=true} end, {desc="Git Blame Line"})
          map('n', '<leader>hd', gs.diffthis, {desc="Git Diff This"})
          map('n', '<leader>hD', function() gs.diffthis('~') end, {desc="Git Diff This ~"})

          -- Toggles (optional)
          -- map('n', '<leader>tb', gs.toggle_current_line_blame, {desc="Toggle Blame Current Line"})
          -- map('n', '<leader>td', gs.toggle_deleted, {desc="Toggle Delete Sign"})
        end
      })
    end,
  },

  -- == Fuzzy Finding (Telescope) == --
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.x', -- Or latest stable tag
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Optional: FZF sorter for performance
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup({
        defaults = {
          -- Default layout is vertical
          layout_strategy = 'vertical',
          layout_config = {
              vertical = {
                  height = 0.9,
                  width = 0.9,
                  preview_height = 0.5,
              },
              -- Other layouts: horizontal, flex, cursor
          },
          -- Use fd (faster) instead of find if installed
          file_ignore_patterns = { "node_modules", "%.git/", "^target/" },
          sorting_strategy = "ascending",
          prompt_prefix = " ", -- Nerd Font search icon
          selection_caret = " ", -- Nerd Font caret icon
          border = {},
          borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
          color_devicons = true,
        },
        pickers = {
          -- Configure specific pickers
          find_files = {
              -- find_command = { 'fd', '--type', 'f', '--hidden', '--exclude', '.git' } -- Example using fd
          },
          live_grep = {
              -- Additional arguments for ripgrep
              -- additional_args = function(opts) return {"--hidden"} end
          },
          buffers = {
            sort_mru = true,
            ignore_current_buffer = true,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- "smart_case", "ignore_case", "respect_case"
          },
        },
      })

      -- Load fzf extension if present
      pcall(telescope.load_extension, 'fzf')
    end,
  },
  {
        "github/copilot.vim",
        cmd = "copilot", -- Load on command
        event = "InsertEnter", -- Or load when entering insert mode
        config = function()
          require("copilot").setup({
            suggestion = {
              enabled = true,
              auto_trigger = true,
              keymap = {
                accept = "<C-a>", -- Example: Ctrl+L to accept suggestion
                dismiss = "<C-]>", -- Example: Ctrl+] to dismiss
              },
            },
            panel = { enabled = false }, -- We'll use CopilotChat for the panel/chat
            filetypes = {
              ["*"] = true, -- Enable for all filetypes by default
              -- Exclude specific filetypes if needed
              -- yaml = false,
              -- markdown = false,
            },
          })
          -- Run :Copilot auth or :Copilot setup if you haven't already
        end,
  },

    {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "main", -- Recommended branch for latest features
  dependencies = {
    { "github/copilot.vim" }, -- Reuse the Copilot instance
    { "nvim-lua/plenary.nvim" }, -- Required for tests
    { "nvim-telescope/telescope.nvim" }, -- Optional for picker functionality
  },
  opts = {
    debug = false, -- Enable debugging messages
    -- proxy = "socks5://127.0.0.1:1080", -- Example for proxy support
    show_help = true, -- Show help messages
    window = {
      layout = 'vertical', -- 'vertical', 'horizontal', 'float'
      width = 0.5, -- fractional width of the parent window
      height = 0.9, -- fractional height of the parent window
      -- Options for float layout
      -- relative = 'editor',
      -- border = 'rounded',
      -- row = 1,
      -- col = 1,
      -- title = 'Copilot Chat',
      -- footer = '',
    },
    mappings = {
      -- Custom key Nvim mappings for the chat buffer
      complete = {
        detail = "Use <TAB> to select commands",
        mapping = "<Tab>",
      },
      close = {
        detail = "Close the chat window",
        mapping = "<C-c>", -- Close with Ctrl+C in the chat window
      },
      submit = {
        detail = "Submit prompt",
        mapping = "<CR>", -- Submit with Enter
      },
      -- Add more custom mappings if needed
    },
    -- Example custom prompts:
    -- prompts = {
    --   Explain = "Please explain the following code: %s",
    --   Refactor = {
    --     prompt = "Please refactor the following code to be more concise: %s",
    --     target = "new", -- Open refactored code in a new buffer
    --   },
    -- },
  },
  -- event = "VeryLazy", -- Load when needed
  config = function(_, opts)
    require('CopilotChat').setup(opts)
    -- You can define global keymaps here or outside the lazy setup
  end
  },

}, {}) -- End lazy setup

-- == Basic Neovim Options == --
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.cursorline = true     -- Highlight the current line
vim.opt.termguicolors = true  -- Enable true color support
vim.opt.wrap = false          -- Disable line wrapping

-- Indentation
vim.opt.tabstop = 4           -- Number of visual spaces per TAB
vim.opt.softtabstop = 4       -- Number of spaces inserted when TAB is pressed
vim.opt.shiftwidth = 4        -- Number of spaces used for autoindent
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.autoindent = true     -- Copy indent from current line when starting new line
vim.opt.smartindent = true    -- Be smart about indentation

-- Search
vim.opt.incsearch = true      -- Highlight search results interactively
vim.opt.hlsearch = true       -- Highlight all search results
vim.opt.ignorecase = true     -- Ignore case in search patterns
vim.opt.smartcase = true      -- Override ignorecase if pattern contains uppercase letters

-- Behavior
vim.opt.scrolloff = 8         -- Minimum number of screen lines to keep above/below cursor
vim.opt.sidescrolloff = 8     -- Minimum number of screen columns to keep to the left/right of cursor
vim.opt.mouse = 'a'           -- Enable mouse support in all modes
vim.opt.splitright = true     -- Open new vertical splits to the right
vim.opt.splitbelow = true     -- Open new horizontal splits below
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
vim.opt.completeopt = 'menuone,noselect' -- Autocomplete options
vim.opt.hidden = true         -- Allow buffers to be hidden without saving
vim.opt.updatetime = 300      -- Faster update time for plugins like GitSigns
vim.opt.signcolumn = 'yes'    -- Always show the sign column

-- Backup/Swap files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath('data') .. '/undodir'
vim.opt.undofile = true

-- == Keybindings == --
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Remap leader and local leader
-- map('', '<Space>', '<Nop>', opts) -- Already set globally

-- VS Code-like Keybindings (Examples - Adjust as needed)
-- File operations
map('n', '<C-s>', ':w<CR>', { noremap = true, silent = true, desc = "Save File" }) -- Ctrl+S to Save
map('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true, desc = "Save File" })
map('n', '<C-w>', ':q<CR>', { noremap = true, silent = true, desc = "Close Window/Buffer" }) -- Ctrl+W to Close (Note: conflicts with window commands)
map('n', '<C-S-w>', ':qa!<CR>', { noremap = true, silent = true, desc = "Quit Neovim" }) -- Ctrl+Shift+W to Quit

-- Navigation & Window Management
map('n', '<C-p>', ':Telescope find_files<CR>', { noremap = true, silent = true, desc = "Find File (Ctrl+P)" })
map('n', '<C-f>', ':Telescope live_grep<CR>', { noremap = true, silent = true, desc = "Find in Files (Ctrl+Shift+F)" }) -- Using Ctrl+F for now
map('n', '<leader>b', ':Telescope buffers<CR>', { noremap = true, silent = true, desc = "Find Open Buffer" })
map('n', '<leader>/', function() require('Comment.api').toggle.linewise.current() end, { noremap = true, silent = true, desc = "Toggle Comment" }) -- Leader + /
map('v', '<leader>/', '<Esc><Cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { noremap = true, silent = true, desc = "Toggle Comment (Visual)" })

map('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true, desc = "Toggle File Explorer" }) -- Leader + e for Explorer
map('n', '<C-`>', ':NvimTreeToggle<CR>', { noremap = true, silent = true, desc = "Toggle File Explorer (Ctrl+`)" }) -- Ctrl+` like VSCode

-- Terminal
map('n', '<C-\\>', ':split | terminal<CR>', { noremap = true, silent = true, desc = "Open Terminal (Split)" }) -- Ctrl+\ (might conflict)
map('t', '<Esc>', '<C-\\><C-n>', opts) -- Escape from terminal mode

-- LSP keybinds are set in the on_attach function within lspconfig setup

-- Other useful mappings
map('n', '<leader>ww', ':w<CR>', { silent = true, desc = "Save" })
map('n', '<leader>qq', ':q<CR>', { silent = true, desc = "Quit" })
map('n', '<leader>qa', ':qa!<CR>', { silent = true, desc = "Quit All" })

-- Clear search highlight
map('n', '<leader>nh', ':nohl<CR>', { silent = true, desc = "Clear Search Highlight" })

-- Move lines up/down (like Alt+Up/Down in VSCode)
map('n', '<A-j>', ':m .+1<CR>==', { silent = true, desc = "Move Line Down" })
map('n', '<A-k>', ':m .-2<CR>==', { silent = true, desc = "Move Line Up" })
map('v', '<A-j>', ":m '>+1<CR>gv=gv", { silent = true, desc = "Move Selection Down" })
map('v', '<A-k>', ":m '<-2<CR>gv=gv", { silent = true, desc = "Move Selection Up" })

-- Github copilot chat key bindings
-- Toggle the chat window
map('n', '<leader>cc', '<cmd>CopilotChatToggle<CR>', { desc = "CopilotChat - Toggle" })

-- Ask Copilot Chat about the current buffer or visual selection
map('n', '<leader>ca', '<cmd>CopilotChat<CR>', { desc = "CopilotChat - Ask" })
map('v', '<leader>ca', '<cmd>CopilotChat<CR>', chat_opts, { desc = "CopilotChat - Ask about selection" })

-- Quick chat commands using visual selection
-- These often open the chat with the prompt pre-filled
map('v', '<leader>ce', '<cmd>CopilotChatExplain<CR>', chat_opts, { desc = "CopilotChat - Explain selection" })
map('v', '<leader>cf', '<cmd>CopilotChatFix<CR>', chat_opts, { desc = "CopilotChat - Fix selection" })
map('v', '<leader>co', '<cmd>CopilotChatOptimize<CR>', chat_opts, { desc = "CopilotChat - Optimize selection" })
map('v', '<leader>cd', '<cmd>CopilotChatDocs<CR>', chat_opts, { desc = "CopilotChat - Add Docs for selection" })
map('v', '<leader>ct', '<cmd>CopilotChatTests<CR>', chat_opts, { desc = "CopilotChat - Generate Tests for selection" })

-- Use Telescope to select prompts (if Telescope is installed)
map('n', '<leader>cp', function()
    local actions = require("CopilotChat.actions")
    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
end, { desc = "CopilotChat - Pick Action/Prompt" })


-- == Final Touches == --
-- Ensure undo directory exists
local undodir_path = vim.o.undodir -- Access the option value directly as a string
if vim.fn.isdirectory(undodir_path) == 0 then
  vim.fn.mkdir(undodir_path, 'p')
end

print("Neovim config loaded!")

