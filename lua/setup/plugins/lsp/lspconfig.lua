return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "williamboman/mason.nvim",           -- 强制依赖 mason
        "williamboman/mason-lspconfig.nvim", -- 强制依赖 mason-lspconfig
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        -- 确保此时 mason-lspconfig 已经准备好
        local lspconfig = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        -- [这里放你原来的 on_attach, capabilities, signs 定义...]
        mason_lspconfig.setup({})

        local on_attach = function(client, bufnr)
            local opts = { noremap = true, silent = true, buffer = bufnr }

            -- === 导航逻辑 (针对 JK 切换 Buffer 习惯优化) ===
            -- 使用 Lspsaga 预览功能可以让你在 JK 扫视文件时，不用离开当前 Buffer 就能改代码
            opts.desc = "Lspsaga Finder (Definition/References)"
            vim.keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", opts)

            opts.desc = "Peek Definition (在浮窗内编辑，不切 Buffer)"
            vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)

            opts.desc = "Go to declaration"
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

            opts.desc = "Show implementations"
            vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

            -- === 常用操作 ===
            opts.desc = "Smart Rename"
            vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)

            opts.desc = "Code Actions"
            vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)

            opts.desc = "Hover Doc"
            vim.keymap.set("n", "gh", "<cmd>Lspsaga hover_doc<CR>", opts)

            opts.desc = "Line Diagnostics"
            vim.keymap.set("n", "<leader>k", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)

            -- 配合 JK 切换，快速定位当前文件的错误
            opts.desc = "Next Diagnostic"
            vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
            opts.desc = "Prev Diagnostic"
            vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
        end

        -- 2. 能力配置 (启用补全)
        local capabilities = cmp_nvim_lsp.default_capabilities()
        -- 针对 clangd 的编码修复
        capabilities.offsetEncoding = { "utf-16" }

        -- 3. 诊断符号美化
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

    end,
}

