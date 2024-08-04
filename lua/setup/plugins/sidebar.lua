return{
    'sidebar-nvim/sidebar.nvim',
    config = function ()
        require("sidebar-nvim").setup({
            sections = {
                "datetime",
                "git",
                "diagnostics",
                "files",
                "containers",
                "TODOs"
            },
            vim.keymap.set("n", "<leader>sb", ":SidebarNvimToggle<CR>", { desc = "Toggle SidebarNvim" }),
        })
    end
}
