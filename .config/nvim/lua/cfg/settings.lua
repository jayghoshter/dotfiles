local opt = vim.opt

-- Indentation
opt.exrc = true
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.autoindent = false
opt.smartindent = false
opt.title = true

-- Set the shell to pwsh on Windows
if vim.fn.has('win32') == 1 then
    vim.opt.shell = vim.fn.expand('~/scoop/apps/pwsh/current/pwsh.exe')
    vim.opt.shellcmdflag = '-NoLogo -NoProfile -Command'  -- Command to pass when executing shell commands
    vim.opt.shellquote = ''                          -- No need to quote the arguments
    vim.opt.shellxquote = ''                         -- No need to quote the shell itself
    vim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode' -- Redirect output
    vim.opt.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode' -- Redirect stderr to stdout
    vim.opt.shellslash = false                       -- Use backslashes for paths
end

-- Buffers
opt.hidden = true -- Buffer switching without saving

-- Search
opt.ignorecase = true -- Case insensitive search
opt.smartcase = true -- But sensitive if includes capital letter
opt.grepprg = 'rg --ignore-case --vimgrep'
opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'

opt.path = '**'
-- Ignore some folders and files with find
opt.wildignore = {
  '**/node_modules/**',
  '**/.git/**',
  '**/.o', 
  '**/.mod', 
  '**/.aux', 
}

-- UI
opt.wrap = true
-- opt.linebreak = true -- Break lines by spaces or tabs

opt.termguicolors = true
opt.modeline = true
opt.ruler = true

opt.number = true
opt.relativenumber = false
opt.signcolumn = 'yes'
opt.showmode = true -- Do not show mode in command line

opt.list = true
opt.listchars = {
  nbsp = '⦸', -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  tab = '»»',
  extends = '»', -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  precedes = '«', -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  trail = '·', -- Dot Operator (U+22C5)
}
-- Show cool character on line wrap
opt.showbreak = '↳ ' -- DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
opt.fillchars = {
  eob = ' ', -- Suppress ~ at EndOfBuffer
  fold = ' ', -- Hide trailing folding characters

  -- -- thicker borders between splits
  -- horiz = '━',
  -- horizup = '┻',
  -- horizdown = '┳',
  -- vert = '┃',
  -- vertleft  = '┫',
  -- verthoriz = '╋',
  -- vertright = '┣',

}

opt.cursorline = true -- Highlight current line
-- opt.colorcolumn = { 81, 121 } -- Highlight columns
opt.showmatch = true -- Highlight matching parenthesis, etc.

opt.lazyredraw = true -- Redraw only when need to


-- UX
opt.confirm = false
opt.updatetime = 300 -- Trigger cursorhold faster
opt.inccommand = 'split' -- Show preview of ex commands
opt.incsearch = true
opt.hlsearch = true

opt.mouse = 'a' -- Enable mouse usage
opt.splitright = true -- Open new split to the right
opt.splitbelow = true -- Open new split below
opt.whichwrap = opt.whichwrap + 'h,l,<,>,[,]'
opt.joinspaces = false -- Prevent inserting two spaces with J

opt.completeopt = { 'menu', 'menuone', 'noselect' } -- Completion menu

--  Autoformatting
--  TODO: Might need to use concat because of
--  https://github.com/neovim/neovim/issues/14669
opt.formatoptions = table.concat {
  'c', -- Auto-wrap comments
  -- 'a', -- Auto format paragraph
  '2', -- Use the second line's indent vale when indenting (allows indented first line)
  'q', -- Formatting comments with `gq`
  -- 'w', -- Trailing whitespace indicates a paragraph
  'j', -- Remove comment leader when makes sense (joining lines)
  'r', -- Insert comment leader after hitting Enter
  'o', -- Insert comment leader after hitting `o` or `O`
  't',
}

-- Messages
opt.shortmess:append {
  I = true, -- No splash screen
  W = true, -- Don't print "written" when editing
  a = true, -- Use abbreviations in messages ([RO] intead of [readonly])
  c = true, -- Do not show ins-completion-menu messages (match 1 of 2)
}

-- Integration with the system clipboard
opt.clipboard = { 'unnamed', 'unnamedplus' }

-- Navigation
opt.scrolloff = 2 -- Lines to scroll when cursor leaves screen
opt.sidescrolloff = 2 -- Lines to scroll horizontally
opt.suffixesadd = { '.md', '.js', '.ts', '.tsx' } -- File extensions not required when opening with `gf`

-- Backups
opt.backup = true
opt.backupdir = { '~/.vim-tmp', '~/.tmp', '~/tmp', '/tmp' }
opt.backupskip = { '/tmp/*', '/private/tmp/*' }
opt.writebackup = true

-- Undo & History
opt.undofile = true
opt.undolevels = 1000
opt.undoreload = 10000
opt.shada = { '!', "'1000", '<50', 's10', 'h' } -- Increase the shadafile size so that history is longer

-- Sesssions
-- opt.sessionoptions:remove { 'buffers', 'folds' }

-- Misc
opt.backspace={ 'indent','eol','start' }
opt.laststatus = 3
opt.spell = false
opt.hlsearch = false

-- Fortran
vim.cmd [[ let fortran_free_source = 1 ]]
vim.cmd [[ let fortran_do_enddo = 1]]
vim.cmd [[ let fortran_more_precise  = 1 ]]
vim.cmd [[ let fortran_fold = 1 ]]
vim.cmd [[ let fortran_fold_conditionals = 1 ]]
vim.cmd [[ let fortran_fold_multilinecomments = 1 ]]
-- vim.cmd [[ let fortran_have_tabs = 1]]
-- vim.cmd [[ let fortran_dialect = 'f90']]
