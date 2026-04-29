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
  keys = {
    { "<leader>dc", function() require("dap").continue() end, desc = "DAP continue" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP toggle breakpoint" },
    {
      "<leader>dB",
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      desc = "DAP conditional breakpoint",
    },
    {
      "<leader>dl",
      function()
        require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end,
      desc = "DAP log point",
    },
    { "<leader>do", function() require("dap").step_over() end, desc = "DAP step over" },
    { "<leader>di", function() require("dap").step_into() end, desc = "DAP step into" },
    { "<leader>dO", function() require("dap").step_out() end, desc = "DAP step out" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "DAP toggle REPL" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "DAP terminate" },
    { "<leader>dL", function() require("dap").run_last() end, desc = "DAP run last" },
  },
  config = function()
    local dap = require("dap")
    local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/"
    local mason_packages = vim.fn.stdpath("data") .. "/mason/packages/"
    local codelldb = vim.fn.stdpath("data") .. "/mason/bin/codelldb"
    local debugpy = mason_packages .. "debugpy/venv/bin/python"
    local delve = mason_bin .. "dlv"
    local js_debug_adapter = mason_bin .. "js-debug-adapter"
    local bashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter"

    local function python_path()
      local venv = vim.env.VIRTUAL_ENV or vim.env.CONDA_PREFIX
      if venv then
        return venv .. "/bin/python"
      end

      local python3 = vim.fn.exepath("python3")
      if python3 ~= "" then
        return python3
      end

      local python = vim.fn.exepath("python")
      if python ~= "" then
        return python
      end

      return "python"
    end

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

    dap.adapters.python = {
      type = "executable",
      command = debugpy,
      args = { "-m", "debugpy.adapter" },
    }
    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = python_path,
        justMyCode = false,
      },
      {
        type = "python",
        request = "launch",
        name = "Launch module",
        module = function()
          return vim.fn.input("Module: ")
        end,
        pythonPath = python_path,
        justMyCode = false,
      },
    }

    dap.adapters.go = {
      type = "server",
      port = "${port}",
      executable = {
        command = delve,
        args = { "dap", "-l", "127.0.0.1:${port}" },
      },
    }
    dap.configurations.go = {
      {
        type = "go",
        name = "Debug package",
        request = "launch",
        program = "${workspaceFolder}",
      },
      {
        type = "go",
        name = "Debug file",
        request = "launch",
        program = "${file}",
      },
      {
        type = "go",
        name = "Debug test package",
        request = "launch",
        mode = "test",
        program = "${workspaceFolder}",
      },
      {
        type = "go",
        name = "Debug test file",
        request = "launch",
        mode = "test",
        program = "${file}",
      },
    }

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = js_debug_adapter,
        args = { "${port}" },
      },
    }
    dap.configurations.javascript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch npm script",
        runtimeExecutable = "npm",
        runtimeArgs = function()
          local script = vim.fn.input("npm script: ")
          return { "run", script }
        end,
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach process",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
    }
    dap.configurations.typescript = dap.configurations.javascript
    dap.configurations.javascriptreact = dap.configurations.javascript
    dap.configurations.typescriptreact = dap.configurations.javascript

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
