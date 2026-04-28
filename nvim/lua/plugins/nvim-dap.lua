return {
  "mfussenegger/nvim-dap",
  cmd = {
    "DapContinue",
    "DapToggleBreakpoint",
    "DapToggleRepl",
    "DapStepOver",
    "DapStepInto",
    "DapStepOut",
    "DapTerminate",
    "DapRestartFrame",
    "DapRunLast",
    "DapClearBreakpoints",
    "DapSetLogLevel",
    "DapShowLog",
  },
  config = function()
    local dap = require("dap")
    local codelldb = vim.fn.stdpath("data") .. "/mason/bin/codelldb"
    local bashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter"

    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = codelldb,
        args = { "--port", "${port}" },
      },
    }
    dap.configurations.rust = {
      {
        name = "Launch executable",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }

    dap.adapters.bash = {
      type = "executable",
      command = "node",
      args = { bashdb },
    }
    dap.configurations.sh = {
      {
        type = "bash",
        request = "launch",
        name = "Launch bash script",
        program = "${file}",
        cwd = "${workspaceFolder}",
        pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
        pathBashdbLib = vim.fn.stdpath("data")
          .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
        pathBash = "bash",
        pathCat = "cat",
        pathMkfifo = "mkfifo",
        pathPkill = "pkill",
        env = {},
        args = {},
        terminalKind = "integrated",
      },
    }
    dap.configurations.bash = dap.configurations.sh
  end,
}
