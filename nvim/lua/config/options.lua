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
opt.termguicolors = true  -- enable 24-bit colors
opt.signcolumn    = "no"  -- always show sign column (git, breakpoints)
opt.cursorline    = false -- highlight current linte
opt.scrolloff     = 5     -- scroll-off size
opt.list          = false -- enable whitespace drawing (spaces and tabs)
opt.listchars     =       -- whitespace symbols
    { tab = '» ', trail = '·', space = '·', nbsp = '␣' }
vim.g.netrw_hide  = 0     -- show not-hidden (0 = show all, 2 = show only hidden)

cmd.colorscheme("jellybeans") -- set colorscheme

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

------------------------------------------------------
-- C/C++
------------------------------------------------------

local group = vim.api.nvim_create_augroup("ClangFormatGroup", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = { "c", "cpp" },
    callback = function(args)
        vim.keymap.set("n", "<Leader>f", function()
            if vim.bo[args.buf].modified then
                vim.cmd("write")
            end
            local filepath = vim.api.nvim_buf_get_name(args.buf)
            if filepath == "" then return end
            vim.system({ "clang-format", "-i", filepath }, {}, function(obj)
                vim.schedule(function()
                    if obj.code == 0 then
                        vim.cmd("checktime " .. args.buf)
                    else
                        local err = obj.stderr ~= "" and obj.stderr or "Unknown error"
                        vim.notify("Clang-format failed: " .. err, vim.log.levels.ERROR)
                    end
                end)
            end)
        end, { buffer = args.buf, desc = "Async clang-format" })
    end,
})
