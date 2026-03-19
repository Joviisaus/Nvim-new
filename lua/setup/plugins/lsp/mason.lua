return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "typescript-language-server",
                "html-lsp",
                "html",
                "cssls",
                "lua_ls",
                "jedi_language_server",
                "jsonls",
                "clangd",
                "rust_analyzer",
                "yamlls",
                "taplo",
                "marksman",
                "prettier",
                "stylua",
                "isort",
                "black",
                "pylint",
                "eslint_d",
            },
            auto_update = true,
            run_on_start = true,
        })

        mason_lspconfig.setup({
            automatic_installation = true,
        })
    end,
}
