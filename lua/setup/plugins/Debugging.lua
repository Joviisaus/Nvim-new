return{
  {
  'mfussenegger/nvim-dap',
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "jay-babu/mason-nvim-dap.nvim",

  },
  config = function ()
    local dap = require("dap")
    local dapui = require("dapui")
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap. listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
    local function get_executable_from_cmake(path)
      local get_executable = 'sed -n "s/.*add_executable(\\([[:alnum:]_]*\\).*/\1/p"'
    .. path .. "CMakeLists.txt"

    return vim.fn.system(get_executable)
    end

    local get_args = function()
      -- 获取输入命令行参数
      local cmd_args = vim.fn.input('CommandLine Args:')
      local params = {}
      -- 定义分隔符(%s在lua内表示任何空白符号)
      local sep = "%s"
      for param in string.gmatch(cmd_args, "[^%s]+") do
        table.insert(params, param)
      end
      return params
    end;

    dap.adapters.lldb = {
      type = 'executable',
      command = '/opt/homebrew/Cellar/llvm/17.0.6_1/bin/lldb-vscode', -- adjust as needed, must be absolute path
      name = 'lldb'
    }

    dap.configurations.cpp = {
    {
      name = 'Launch file',
      type = 'lldb',
      request = 'launch',
      program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = get_args,
    },
  }
    dap.configurations.c = dap.configurations.cpp


    vim.keymap.set('n','<leader>dt',dap.toggle_breakpoint,{})
    vim.keymap.set('n','<leader>dc',dap.continue,{})
    vim.keymap.set('n','<leader>de',dapui.eval,{})
    require("dapui").setup()
  end,
}}
