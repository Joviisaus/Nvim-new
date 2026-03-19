return {
    "nvimdev/lspsaga.nvim",
    -- 优化：只有当 LSP 启动时才加载，节省启动开销
    event = "LspAttach",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("lspsaga").setup({
            -- 1. 窗口内滚动保持和你的翻页习惯一致
            scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
            -- 2. 预览定义设置：允许你在弹窗里直接编辑代码
            definition = {
                edit = "<CR>",
                keys = {
                    edit = "o",
                    tabe = "i",
                    vsplit = "s",
                    split = "S",
                },
            },
            ui = {
                border = "rounded",
                code_action = "💡", -- 稍微给个提示，不碍眼
                expand = "",
                collapse = "",
            },

            -- 3. 面包屑导航：配合你 JK 快速切换 Buffer，一眼认清当前位置
            symbol_in_winbar = {
                enable = true,
                separator = "  ",
                respect_root = true,
                show_file = true,
                folder_level = 0,
            },

            -- 4. 优化诊断显示
            diagnostic = {
                on_insert = false, -- 输入时不跳诊断，减少视觉干扰
                insert_winblend = 0,
            },
            -- 5. 极简灯泡
            lightbulb = {
                enable = true,
                sign = true,
                virtual_text = false, -- 关闭虚拟文字，保持行尾整洁
            },
        })

        local keymap = vim.keymap.set
        local opts = { silent = true }

        -- === 保持你原有的键位 ===
        keymap("n", "<leader>dw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", { desc = "show workspace diagnostics" })
        keymap("n", "<leader>db", "<cmd>Lspsaga show_buf_diagnostics<CR>", { desc = "show buffer diagnostics" })
        keymap("n", "<leader>t", "<cmd>Lspsaga term_toggle<CR>", { desc = "toggle terminal" })
        keymap("t", "<leader>tt", "<cmd>Lspsaga term_toggle<CR>", { desc = "toggle terminal" })
        keymap({ "n", "t" }, "<C-t>", "<cmd>Lspsaga term_toggle<CR>", { desc = "toggle terminal" })

        keymap("n", "gh", "<cmd>Lspsaga hover_doc<CR>", opts)         -- 悬浮文档
        keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)  -- 预览定义 (超级好用)
        keymap("n", "gf", "<cmd>Lspsaga finder<CR>", opts)           -- 查看引用和定义
        keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
        keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)

        keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
        keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
    end,
}
