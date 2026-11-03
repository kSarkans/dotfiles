if vim.g.neovide then
    -- vim.o.guifont = "JetBrainsMono Nerd Font:h15"
    vim.o.guifont = "ZedMono Nerd Font:h15"

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

    vim.g.neovide_opacity        = 0.85
    vim.g.neovide_normal_opacity = 0.85
end
