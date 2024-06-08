return {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()

        vim.keymap.set('n', ';m', '<cmd>lua require"mini.files".open()<CR>')
    end
}
