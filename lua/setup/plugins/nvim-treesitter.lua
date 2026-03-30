return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" }, -- 优化点：推迟到读取文件时加载
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
        "HiPhish/rainbow-delimiters.nvim",
    },
    config = function()
        local configs = pcall(require, "nvim-treesitter.configs")
        if configs then
            require("nvim-treesitter.configs").setup({
                highlight = { 
                    enable = true,
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then return true end
                    end,
                },
                indent = { enable = true },
                autotag = { enable = true },
                ensure_installed = { "json", "javascript", "typescript", "tsx", "lua", "vim", "vimdoc", "cpp", "c", "python" },
            })
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "c", "cpp", "lua", "python", "javascript", "typescript", "rust" },
            callback = function()
                if vim.api.nvim_buf_line_count(0) < 2000 then
                    vim.wo.foldmethod = "expr"
                    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()" 
                    vim.wo.foldlevel = 99
                end
            end,
        })
    end,
}
