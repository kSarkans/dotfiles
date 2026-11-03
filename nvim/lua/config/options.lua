local opt = vim.opt
local cmd = vim.cmd

vim.g.mapleader      = " "
vim.g.maplocalleader = "\\"

-- Line numbers
opt.number         = true -- line numbers
opt.relativenumber = true -- relative line numbers

-- Indentaion
opt.tabstop     = 4     -- indentation width
opt.shiftwidth  = 4     -- indentation width with autoindent
opt.expandtab   = true  -- use spaces instead of tabs
opt.smartindent = true  -- smart indentation

-- Search
opt.ignorecase = true -- ignore chars registers during the search...
opt.smartcase  = true -- ...if doesn't have capital letters
opt.hlsearch   = true -- highlight search
opt.incsearch  = true -- incremental search

-- Visuals
opt.termguicolors = true -- enable 24-bit colors
opt.signcolumn    = "no" -- always show sign column (git, breakpoints)
opt.cursorline    = true -- highlight current linte
opt.scrolloff     = 5    -- scroll-off size
opt.list          = true -- enable whitespace drawing (spaces and tabs)
opt.listchars     =      -- whitespace symbols
    { tab = '» ', trail = '·', space = '·', nbsp = '␣' }
vim.g.netrw_hide=1       -- show not-hidden (0 = show all, 2 = show only hidden)

cmd.colorscheme("sorbet") -- set colorscheme

-- Behaviour
opt.mouse      = "a"           -- enable mouse in all modes
opt.clipboard  = "unnamedplus" -- use system clipboard
opt.undofile   = true          -- persistent undo history
opt.swapfile   = false         -- no *.swp files
opt.updatetime = 250           -- update time
opt.timeoutlen = 300           -- mappings time out
-- Yank highlighting
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
    end,
    desc = "Highlight yanked text",
})
