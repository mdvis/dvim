return {
  "stevearc/overseer.nvim",
  cmd = {
    "OverseerOpen",
    "OverseerClose",
    "OverseerToggle",
    "OverseerSaveBundle",
    "OverseerLoadBundle",
    "OverseerDeleteBundle",
    "OverseerRunCmd",
    "OverseerRun",
    "OverseerInfo",
    "OverseerBuild",
    "OverseerQuickAction",
    "OverseerTaskAction",
    "OverseerClearCache",
  },
  keys = {
    { "<leader>oo", "<cmd>OverseerToggle<cr>", desc = "Toggle Overseer" },
    { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Run task" },
    { "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Quick action" },
    { "<leader>oi", "<cmd>OverseerInfo<cr>", desc = "Overseer info" },
    { "<leader>ob", "<cmd>OverseerBuild<cr>", desc = "Build task" },
    { "<leader>ot", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
  },
  opts = {
    -- 任务列表配置
    task_list = {
      direction = "bottom",
      min_height = 25,
      max_height = 25,
      default_detail = 1,
      bindings = {
        ["?"] = "ShowHelp",
        ["g?"] = "ShowHelp",
        ["<CR>"] = "RunAction",
        ["<C-e>"] = "Edit",
        ["o"] = "Open",
        ["<C-v>"] = "OpenVsplit",
        ["<C-s>"] = "OpenSplit",
        ["<C-f>"] = "OpenFloat",
        ["<C-q>"] = "OpenQuickFix",
        ["p"] = "TogglePreview",
        ["<C-l>"] = "IncreaseDetail",
        ["<C-h>"] = "DecreaseDetail",
        ["L"] = "IncreaseAllDetail",
        ["H"] = "DecreaseAllDetail",
        ["["] = "DecreaseWidth",
        ["]"] = "IncreaseWidth",
        ["{"] = "PrevTask",
        ["}"] = "NextTask",
        ["<C-k>"] = "ScrollOutputUp",
        ["<C-j>"] = "ScrollOutputDown",
        ["q"] = "Close",
      },
    },
    -- 组件别名
    component_aliases = {
      default = {
        { "display_duration", detail_level = 2 },
        "on_output_summarize",
        "on_exit_set_status",
        "on_complete_notify",
        "on_complete_dispose",
      },
    },
    -- 任务模板
    templates = { "builtin" },
    -- 策略配置
    strategy = {
      "toggleterm",
      direction = "horizontal",
      autos_croll = true,
      quit_on_exit = "success",
    },
    -- 日志配置
    log = {
      {
        type = "echo",
        level = vim.log.levels.WARN,
      },
      {
        type = "file",
        filename = "overseer.log",
        level = vim.log.levels.DEBUG,
      },
    },
    -- 自动检测任务
    dap = false,
    -- 任务启动器
    task_launcher = {
      bindings = {
        i = {
          ["<C-s>"] = "Submit",
          ["<C-c>"] = "Cancel",
        },
        n = {
          ["<CR>"] = "Submit",
          ["<C-s>"] = "Submit",
          ["q"] = "Cancel",
          ["<Esc>"] = "Cancel",
        },
      },
    },
    -- 任务编辑器
    task_editor = {
      bindings = {
        i = {
          ["<CR>"] = "NextOrSubmit",
          ["<C-s>"] = "Submit",
          ["<Tab>"] = "Next",
          ["<S-Tab>"] = "Prev",
          ["<C-c>"] = "Cancel",
        },
        n = {
          ["<CR>"] = "NextOrSubmit",
          ["<C-s>"] = "Submit",
          ["<Tab>"] = "Next",
          ["<S-Tab>"] = "Prev",
          ["q"] = "Cancel",
          ["<Esc>"] = "Cancel",
        },
      },
    },
    -- 确认提示
    confirm = {
      border = "rounded",
      zindex = 40,
      min_width = 20,
      max_width = 0.5,
      max_height = 0.9,
      min_height = 5,
    },
    -- 任务窗口
    task_win = {
      border = "rounded",
      win_opts = {
        winblend = 0,
      },
    },
  },
}
