-- TODO: Look into lsp-zero. Integrates all LSP config and uses mason

-- -- WORKFLOW:
-- https://github.com/ThePrimeagen/git-worktree.nvim
-- https://github.com/chipsenkbeil/distant.nvim -- remote edits
-- https://github.com/ahmedkhalf/project.nvim

-- -- MANUALS:
-- https://github.com/sunaku/vim-dasht
-- https://github.com/rhysd/devdocs.vim

-- -- UTILITY:
-- https://github.com/b3nj5m1n/kommentary
-- https://github.com/gelguy/wilder.nvim -- wildmenu addon. Might not need it with nvim-cmp

-- -- MISC:
-- https://github.com/ibhagwan/fzf-lua -- Telescope alternative
-- https://github.com/d0c-s4vage/lookatme  -- presentation!
-- https://github.com/ngscheurich/iris.nvim -- color helper
-- use 'LnL7/vim-nix' -- probably not required, but potentially useful
-- https://github.com/junegunn/vim-peekaboo -- See register context
-- https://github.com/ofirgall/open.nvim

-- C++ dev
-- https://github.com/p00f/clangd_extensions.nvim
-- https://github.com/Civitasv/cmake-tools.nvim

-- Folds
-- https://github.com/chrisgrieser/nvim-origami

return {

    'ggandor/lightspeed.nvim',
    'duane9/nvim-rg',

    {
        'onsails/diaglist.nvim',
        config = function()
            require("diaglist").init({
                debug = false,
                debounce_ms = 150,
            })

            vim.cmd [[ command! DiagBuf lua require('diaglist').open_all_diagnostics() ]]
            vim.cmd [[ command! DiagAll lua require('diaglist').open_buffer_diagnostics() ]]

        end
    },

    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require'colorizer'.setup()
        end
    },

    -- {
    --   'editorconfig/editorconfig-vim', -- Project-specific settings
    --   config = function()
    --     vim.g.EditorConfig_preserve_formatoptions = 1
    --   end,
    -- }

    {
        'vim-pandoc/vim-pandoc',
        config = function()
            require 'cfg.plugins.pandoc'
        end,
        ft = {
            'markdown',
            'vimwiki',
            'tex',
            'pandoc'
        }
    },

    { 'vim-pandoc/vim-pandoc-syntax' },

    {
        'vimwiki/vimwiki',
        config = function()
            require 'cfg.plugins.vimwiki'
        end,
        ft = {'markdown', 'vimwiki', 'pandoc'}
    },

    -- -- NOTE: doesn't work everywhere since vimwiki
    -- -- is only used for certain filetypes
    -- {
    --     'ElPiloto/telescope-vimwiki.nvim',
    --     config = function()
    --         require('telescope').load_extension('vw')
    --         local map = require('cfg.utils').map
    --         map('n', '<space>n', ':Telescope vw<cr>')
    --     end
    -- },

    {
        'lervag/vimtex',
        ft = {
            'vimwiki',
            'markdown',
            'tex'
        }
    },

    'mboughaba/i3config.vim',

    -- doesn't work on windows?
    'm-pilia/vim-ccls',

    -- -- Unsure if I need this
    -- use {
    --     "cuducos/yaml.nvim",
    --     ft = {"yaml"}, -- optional
    --     dependencies = {
    --         "nvim-treesitter/nvim-treesitter",
    --         "nvim-telescope/telescope.nvim" -- optional
    --     },
    --     -- config = function ()
    --     --     require("yaml_nvim").init()
    --     -- end,
    -- }

    { 'ray-x/lsp_signature.nvim', config=function() require'lsp_signature'.setup() end },
    {'kevinhwang91/nvim-bqf', ft = 'qf'},

    {
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('treesj').setup({
                use_default_keymaps = false,
            })
        end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require('cfg.plugins.tree')
        end,
    },

    {
        "m-demare/hlargs.nvim",
        config = function()
            require('hlargs').setup()
        end
    },
    {
        "stevearc/aerial.nvim",
        config = function()
            require('aerial').setup({
                -- optionally use on_attach to set keymaps when aerial has attached to a buffer
                on_attach = function(bufnr)
                    -- Jump forwards/backwards with '{' and '}'
                    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
                    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
                end
            })
            -- You probably also want to set a keymap to toggle aerial
            vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
        end
    },
    -- { 'nvim-focus/focus.nvim', version = false , config=true},
    {
        "nvim-zh/colorful-winsep.nvim",
        config = true,
        event = { "WinNew" },
    },

    { 'LnL7/vim-nix' },

    -- {
    --   "klen/nvim-config-local",
    --   config = function()
    --     require('config-local').setup ({
    --       -- Config file patterns to load (lua supported)
    --       config_files = { ".nvim.lua", ".nvimrc", ".exrc" },
    --
    --       -- Where the plugin keeps files data
    --       hashfile = vim.fn.stdpath("data") .. "/config-local",
    --
    --       autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
    --       commands_create = true,     -- Create commands (ConfigLocalSource, ConfigLocalEdit, ConfigLocalTrust, ConfigLocalIgnore)
    --       silent = false,             -- Disable plugin messages (Config loaded/ignored)
    --       lookup_parents = true,     -- Lookup config files in parent directories
    --     })
    --   end
    -- },

    { "folke/neodev.nvim", opts = {}, config=true},

    -- "stefandtw/quickfix-reflector.vim",

    {
        "linux-cultist/venv-selector.nvim",
        dependencies = {
            "neovim/nvim-lspconfig", 
            "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
            { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
        },
        lazy = false,
        branch = "regexp", -- This is the regexp branch, use this for the new version
        config = function()
            require("venv-selector").setup()
        end,
        keys = {
            { ",v", "<cmd>VenvSelect<cr>" },
        },
    },

    {
        "David-Kunz/gen.nvim",
        cmd = { "Gen" },
        config = function()
            local gen = require("gen")
            gen.setup({
                model = "llama3.1:8b", -- The default model to use.
                host = '192.168.2.33',
                port = 11434,
                display_mode = "horizontal-split", 
                show_prompt = false, -- Shows the Prompt submitted to Ollama.
                show_model = true, -- Displays which model you are using at the beginning of your chat session.
                no_auto_close = false, -- Never closes the window automatically.
                -- init = function(options)
                --     pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
                -- end,
                -- Function to initialize Ollama
                command = function(options)
                    return "curl --silent --no-buffer -X POST http://"
                        .. options.host
                        .. ":"
                        .. options.port
                        .. "/api/chat -d $body"
                end,
                -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
                -- This can also be a lua function returning a command string, with options as the input parameter.
                -- The executed command must return a JSON object with { response, context }
                -- (context property is optional).
                debug = false,
            })
            gen.prompts['jrewrite'] = {
                prompt = "Modify the following text for a scientific journal article, just output the final text without additional quotes around it:\n$register",
                replace = true
            }
            gen.prompts['jrewritevis'] = {
                prompt = "Modify the following text for a scientific journal article, just output the final text without additional quotes around it:\n$text",
            }
            gen.prompts['jwrite'] = {
                prompt = "Write a paragraph as if for a scientific journal article. Respond with only the text requested. Do not address me in any way:\n$register",
                replace = true
            }

            local map = require('cfg.utils').map
            -- map({'n', 'v'}, "<space>s", "<Esc><cmd>lua require('gen').select_model()<CR>")
            -- map("n", "<space>j", "<Esc><cmd>lua require('cfg.utils').LlamaRun('jwrite', {replace=true})<CR>")
            -- map("n", "<space>k", "<Esc><cmd>lua require('cfg.utils').LlamaRun('jrewrite', {yank=true})<CR>")
            -- map("v", "<space>k", "<Esc><cmd>lua require('cfg.utils').LlamaRun('jrewritevis', {visual=true})<CR>")
            -- map("n", "<space>v", "<Esc><cmd>lua require('telescope').extensions.gen.prompts({ mode = 'n'})<CR>")
            -- map("v", "<space>v", "<Esc><cmd>lua require('telescope').extensions.gen.prompts({ mode = 'v'})<CR>")
        end,
        dependencies = {
            {
                'dj95/telescope-gen.nvim',
                config=function()
                    require('telescope').load_extension('gen')
                end
            }
        }
    },
}

