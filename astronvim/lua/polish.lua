-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- set tabstop=4
-- set softtabstop=4
-- set shiftwidth=4

vim.opt.matchpairs = {'(:)', '{:}', '[:]', '<:>'}

vim.opt.clipboard = "unnamedplus"

-- vim.keymap.set('n', '<C-v>', '"+p', { desc = 'Paste from system buffer.' })
vim.keymap.set('i', '<C-v>', '<Escape>"+pa', { desc = 'Paste from system buffer.' })
vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Copy to system buffer.' })
vim.keymap.set('v', '<C-v>', '"+p', { desc = 'Replace selection with system buffer.' })

if vim.fn.has('unix') == 1 and vim.env.XDG_SESSION_TYPE == 'wayland' then
    vim.g.clipboard = {
        name = 'wl-clipboard',
        copy = {
            ['+'] = 'wl-copy',
            ['*'] = 'wl-copy -p',
        },
        paste = {
            ['+'] = 'wl-paste -n',
            ['*'] = 'wl-paste -p -n',
        },
        cache_enabled = false,
    }
end

if vim.g.neovide then
    vim.keymap.set({"n", "v", "i", "t"}, "<C-+>", function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.05
    end, { desc = "Increase GUI size." })

    vim.keymap.set({"n", "v", "i", "t"}, "<C-_>", function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.05
    end, { desc = "Decrease GUI size." })

    vim.keymap.set({"n", "v", "i", "t"}, "<C-)>", function()
        vim.g.neovide_scale_factor = 1.0
    end, { desc = "Reset GUI size." })

    vim.keymap.set('t', '<C-S-v>', [[<C-\><C-n>"+pi]], { desc = 'Replace selection with system buffer.' })

    vim.g.neovide_opacity = 0.9
    vim.g.neovide_normal_opacity = 0.9
end
