return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        require("mason").setup({
            ui = { icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" } }
        })

        require("mason-lspconfig").setup({
            ensure_installed = {
                "ts_ls", "html", "cssls", "lua_ls", "jedi_language_server",
                "jsonls", "clangd", "rust_analyzer", "yamlls", "taplo", "marksman",
            },
            automatic_installation = true,
        })

        require("mason-tool-installer").setup({
            ensure_installed = { "prettier", "stylua", "isort", "black", "pylint", "eslint_d" },
        })
    end,
}
