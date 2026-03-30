-- 1. 开启 Lua 字节码缓存 (Neovim 0.9+)
if vim.loader then
  vim.loader.enable()
end

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.python3_host_prog = '/opt/homebrew/anaconda3/bin/python'
require("setup.core")
require("setup.init_lazy")

