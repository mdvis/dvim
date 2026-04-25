return {
  {
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
  },
  { "nvim-neotest/nvim-nio" },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mason-org/mason.nvim", "mfussenegger/nvim-dap" },
    opts = {
      ensure_installed = {},
      automatic_installation = false,
      handlers = {},
    },
  },
  {
    "leoluz/nvim-dap-go",
    ft = { "go" },
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {},
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = { "python" },
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local python = vim.fn.exepath("python3")
      if python == "" then
        python = "python3"
      end
      require("dap-python").setup(python)
    end,
  },
  {
    "microsoft/vscode-js-debug",
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    dependencies = { "mfussenegger/nvim-dap", "microsoft/vscode-js-debug" },
    config = function()
      require("dap-vscode-js").setup({
        debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
        adapters = { "pwa-node", "node-terminal" },
      })

      local dap = require("dap")
      local js_config = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
      dap.configurations.javascript = js_config
      dap.configurations.typescript = js_config
      dap.configurations.javascriptreact = js_config
      dap.configurations.typescriptreact = js_config
    end,
  },
  {
    "jbyuki/one-small-step-for-vimkind",
    cmd = "OSVStart",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap = require("dap")
      dap.adapters.nlua = function(callback, config)
        callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
      end
      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
          host = "127.0.0.1",
          port = 8086,
        },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    cmd = { "DapUIOpen", "DapUIClose", "DapUIToggle", "DapUIFloatElement", "DapEval" },
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    opts = {},
  },
  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerRun", "OverseerToggle", "OverseerOpen", "OverseerClose" },
    opts = {
      strategy = "jobstart",
    },
  },
}
