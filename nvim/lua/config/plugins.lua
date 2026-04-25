local function setup_plugins()
    -- Search
    -- require('telescope').setup({})

    -- Files
    require("neo-tree").setup({})
    require("oil").setup()

    -- LSP
    require("mason").setup({
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    })
    require("mason-lspconfig").setup({
        ensure_installed = { -- 自动安装的语言服务器
            "bashls",
            "cssls",
            "gopls",
            "html",
            "jdtls",
            "jsonls",
            "lua_ls",
            "pyright",
            "rust_analyzer",
            "sqls",
            "ts_ls",
        },
        automatic_installation = true, -- 自动安装上面列出的 LSP
    })

    -- CMP
    require("blink.cmp").get_lsp_capabilities()

    require("blink.cmp").setup({
        -- keymap = { preset = "default" },
        keymap = { preset = "super-tab" },
        appearance = {
            nerd_font_variant = "mono",
        },
        completion = {
            trigger = {
                show_on_trigger_character = true,
                show_on_keyword = true,
            },
            documentation = { auto_show = false },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
        fuzzy = {
            implementation = "prefer_rust_with_warning",
        },
    })

    -- Git
    require("gitsigns").setup({
        current_line_blame = true,
    })

    -- UI
    local notify = require("notify")
    notify.setup({
        render = "compact",
        stages = "slide",
        timeout = 50000,
    })
    notify("💰按时发薪💰", "info", {
        title = "🏮万事如意🏮",
    })

    require("noice").setup({
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
            },
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
        },
    })

    -- AI
    require("copilot").setup({})

    -- Line
    require("bufferline").setup()
    require("lualine").setup()

    -- Shortcut
    require("which-key").setup()

    -- Comment
    require("Comment").setup()

    -- auto pairs
    require("nvim-autopairs").setup({})

    -- ibl
    local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
    }

    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)

    require("ibl").setup({ indent = { highlight = highlight } })

    require("fidget").setup()

    vim.cmd([[
    hi BqfPreviewBorder guifg=#3e8e2d ctermfg=71
    hi BqfPreviewTitle guifg=#3e8e2d ctermfg=71
    hi BqfPreviewThumb guibg=#3e8e2d ctermbg=71
    hi link BqfPreviewRange Search
    ]])

    -- Startify
    local startify = require("alpha.themes.startify")
    startify.section.header.val = {
        "DEVE👻👻👻👻👻",
    }
    require("alpha").setup(startify.config)

    -- Md
    require("render-markdown").setup({})

    require("overseer").setup({
        strategy = "toggleterm",
    })

    require("flash").setup({
      search = {
        mode = "exact", -- 搜索模式：exact, fuzzy, 或 regex
      },
    })
end

pcall(setup_plugins)
