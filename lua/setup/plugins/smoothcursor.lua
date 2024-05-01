return{ 
  'gen740/SmoothCursor.nvim',
  config = function()
  require("smoothcursor").setup({
    type = "matrix",           -- Cursor movement calculation method, choose "default", "exp" (exponential) or "matrix".
    })
  end
}
