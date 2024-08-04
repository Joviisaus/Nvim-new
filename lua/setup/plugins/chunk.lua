return {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("hlchunk").setup({
            chunk = {
                enable = true,
                delay = 100,
                exclude_filetypes = {
                    dashboard = true,
                    NvimTree = true,
                    help = true,
                    packer = true,
                    checkhealth = true,
                    man = true,
                    manson = true,
                }
            },
            line_num = {
                enable = true,
            },
        })
    end,
}
