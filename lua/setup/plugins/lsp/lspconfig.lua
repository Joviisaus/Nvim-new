return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        "simrat39/rust-tools.nvim",
    },

    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local mason_lspconfig = require("mason-lspconfig")

        -- 1. 统一处理 On_Attach 逻辑
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

        -- 4. 核心优化：全自动 Server 配置
        -- 只要你在 Mason 里安装了 Server，这里就会自动 setup，不需要再一个一个写
        mason_lspconfig.setup_handlers({
            -- 默认配置函数
            function(server_name)
                -- 自动更名修复
                local server = server_name == "tsserver" and "ts_ls" or server_name
                lspconfig[server].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end,

            -- 特殊 Server 的个性化配置写在这里
            ["lua_ls"] = function()
                lspconfig.lua_ls.setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = {
                        Lua = {
                            diagnostics = { globals = { "vim" } },
                            workspace = {
                                library = {
                                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                    [vim.fn.stdpath("config") .. "/lua"] = true,
                                },
                            },
                        },
                    },
                })
            end,

            ["clangd"] = function()
                lspconfig.clangd.setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=never",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                        "--fallback-style=llvm",
                        "-j=4",
                    },
                })
            end,
        })
    end,
}
