local colorschemes = {
    -- 1
    {
        "bluz71/vim-nightfly-guicolors",
        priority = 1000,
        config = function()
            vim.cmd([[
                colorscheme nightfly
                highlight NvimTreeFolderArrowClosed guifg=#3FC5FF 
                highlight NvimTreeFolderArrowOpen guifg=#3FC5FF
                ]])
        end,
    },
    -- 2
    {
        "catppuccin/nvim",
        priority = 1000,
        opts = {
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = true,
                barbar = true,
                hop = true,

                mini = {
                    enabled = true,
                    indentscope_color = "",
                },
            }
        },
        config = function()
            vim.cmd([[
                colorscheme catppuccin-mocha
                ]])
        end,
    },
    -- 3
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function ()
            vim.cmd([[
                colorscheme tokyonight
                ]])
            end
    },
    -- 4
    {
        'hardhackerlabs/theme-vim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme 'hardhacker'
        end
    },
}

return {
    colorschemes[3], -- main theme
}
