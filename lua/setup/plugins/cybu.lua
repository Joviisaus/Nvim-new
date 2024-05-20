return{"ghillb/cybu.nvim",
  branch = "main", -- timely updates
  -- branch = "v1.x", -- won't receive breaking changes
  requires = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim"}, -- optional for icon support
  config = function()
    local ok, cybu = pcall(require, "cybu")
    local opts = { noremap = true, silent = true }
    if not ok then
      return
    end
    cybu.setup()

    opts.desc = "Next Buffer"
    vim.keymap.set("n", "K", "<Plug>(CybuPrev)",opts)
    opts.desc = "Previous Buffer"
    vim.keymap.set("n", "J", "<Plug>(CybuNext)",opts)
    opts.desc = "Last used prev Buffer"
    vim.keymap.set({"n", "v"}, "<c-s-tab>", "<plug>(CybuLastusedPrev)",opts)
    opts.desc = "Last used next Buffer"
    vim.keymap.set({"n", "v"}, "<c-tab>", "<plug>(CybuLastusedNext)",opts)
  end}
