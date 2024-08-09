local finders = require('telescope.finders')
local actions = require 'telescope.actions'
local builtin = require 'telescope.builtin'
-- local extensions = require 'telescope.extensions'
-- local layout_strategies = require 'telescope.pickers.layout_strategies'
-- local custom_pickers = require 'cfg.plugins.telescope_custom_pickers'

local map = require('cfg.utils').map

map('n', '<space>o', builtin.find_files)
map('n', '<space>p', builtin.git_files)
map('n', '<space>g', builtin.live_grep)

map('n', '<space>b', builtin.buffers)
-- map('n', '<space>h', builtin.help_tags) --TODO: use for harpoon and git worktree
-- map('n', '<space>e', builtin.current_buffer_fuzzy_find)
map('n', '<space>;', builtin.command_history)
map('n', '<space>/', builtin.search_history)
map('n', '<space>t', builtin.builtin)
map('n', '<space>d', function() builtin.lsp_dynamic_workspace_symbols({fname_width=60,}) end)
map('n', '<space>s', function() builtin.lsp_document_symbols({symbol_width=60}) end)
map('n', '<space>i', builtin.lsp_implementations)
map('n', '<space>r', builtin.reloader)
map('n', '<space>j', builtin.jumplist)


-- Unused
-- map('n', '<space>m', [[<cmd>lua require'telescope.builtin'.marks()<cr>]])

local opts = { noremap = true, silent = true }

map('n', 'gr', builtin.lsp_references, opts)
map('n', '<space>gs', builtin.git_status, opts)
map('n', '<space>gc', builtin.git_commits)

-- map('n', '<leader>fr', [[<cmd>lua require'telescope.builtin'.oldfiles()<cr>]])
-- map('n', '', [[<cmd>lua require'telescope.builtin'.quickfix()<cr>]])

map('n', '<space>gi', [[<cmd>lua require'telescope'.extensions.gh.issues()<cr>]])
map('n', '<space>gp', [[<cmd>lua require'telescope'.extensions.gh.pull_request()<cr>]])
map('n', '<space>gg', [[<cmd>lua require'telescope'.extensions.gh.gist()<cr>]])
map('n', '<space>gr', [[<cmd>lua require'telescope'.extensions.gh.run()<cr>]])

require('telescope').setup {
    defaults = {
        prompt_prefix = ' ❯ ',
        selection_caret = '❯ ',
        mappings = {
            i = {
                ['<esc>'] = actions.close,
                ['<C-q>'] = actions.send_to_qflist,
                ['<c-j>'] = actions.move_selection_next,
                ['<c-k>'] = actions.move_selection_previous,
                ['<s-up>'] = actions.cycle_history_prev,
                ['<s-down>'] = actions.cycle_history_next,
                ['<c-y>'] = require("telescope.actions.layout").toggle_preview,
            },
        },
        preview = {
            hide_on_startup=true,
        },
        path_display = {'shorten'},
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
        },
        -- fzy_native = {
        --     override_generic_sorter = false,
        --     override_file_sorter = true,
        -- },
    },
    pickers = {
        oldfiles = {
            sort_lastused = true,
            cwd_only = true,
        },
        find_files = {
            hidden = false,
            -- find_command = {
            --     'rg',
            --     '--files',
            --     '--color',
            --     'never',
            --     '--ignore-file',
            --     vim.env.XDG_CONFIG_HOME .. '/ripgrep/ignore',
            -- },
        },
        live_grep = {
            path_display = { 'shorten' },
            -- mappings = {
            --     i = {
            --         ['<c-f>'] = custom_pickers.actions.set_extension,
            --         ['<c-l>'] = custom_pickers.actions.set_folders,
            --     },
            },
        },
        lsp_document_symbols= {
            fname_width = {100},
            symbol_width = {100},
        },
        lsp_dynamic_workspace_symbols = {
            fname_width = {100},
        }
    }

require('telescope').load_extension('gh')
-- require('telescope').load_extension('fzy_native')
-- require('telescope').load_extension('telescope-asynctasks')

local M = {}

M.project_files = function()
    local opts = {} -- define here if you want to define something
    local ok = pcall(require'telescope.builtin'.git_files, opts)
    if not ok then require'telescope.builtin'.find_files(opts) end
end

function M.find_in_root(opts)
    opts = opts or {}
    opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if vim.v.shell_error ~= 0 then
        -- if not git then active lsp client root
        -- will get the configured root directory of the first attached lsp. You will have problems if you are using multiple lsps
        opts.cwd = vim.lsp.get_clients()[1].config.root_dir
    else
        opts.cwd = require('cfg.utils').find_root()
    end
    require('telescope.builtin').live_grep(opts)
end
map('n', '<space>f', M.find_in_root)

-- M.git_dirty=function()
--     require('telescope.builtin').find_files({
--         prompt_title = "Git Dirty >",
--         finder = finders.new_oneshot_job({'git', 'ls-files', '-m', '-o', '--exclude-standard'}),
--     })
-- end


return M
