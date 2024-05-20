return{
  "github/copilot.vim",
  config = function()
    vim.keymap.set('i', '<C-w>', '<Plug>(copilot-accept-word)',{desc = 'Copilot accept a word'})
    vim.keymap.set('i', '<C-l>', '<Plug>(copilot-accept-line)',{desc = 'Copilot accept a line'})
  end,
}
