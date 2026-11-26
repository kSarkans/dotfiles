local km = vim.keymap

-- Common
km.set('n', '<Control>s', ':w<CR>', { desc = "Save buffer" })
km.set('n', '<Control>q', ':q<CR>', { desc = "Quit Neovim" })
km.set('n', '<Leader>bc', ':bdelete %<CR>', { desc = "Close buffer" })
km.set('n', '<Leader>bb', ':buffers<CR>', { desc = "Buffer list" })
km.set('n', '<Leader>e', ':Explore<CR>', { desc = "Open explorer" })
km.set('n', '<Esc>', '<cmd>nohlsearch<CR><Esc>', { desc = 'Clear search highlight' })

-- System clipboard
-- km.set('i', '<Control>v', '<C-r>+', { desc = "Paste from clipboard" })
-- km.set('v', '<Control>v', '"+p',    { desc = "Paste from clipboard" })
-- km.set('v', '<Control>c', '"+y',    { desc = "Copy to clipboard" })
