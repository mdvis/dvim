local function setup_plugins()
    require("fidget").setup()
    require("gitsigns").setup({
        current_line_blame = true,
    })
    require("bufferline").setup()
    require("nvim-autopairs").setup({})
    require("codecompanion").setup()
    require("which-key").setup()

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
            "rust-analyzer",
            "sqls",
            "ts_ls",
        },
        automatic_installation = true, -- 自动安装上面列出的 LSP
    })

    local capabilities = require("blink.cmp").get_lsp_capabilities()

    local notify = require("notify")
    notify.setup({
        render = "compact",
        stages = "slide",
        timeout = 500,
    })
    notify("💰按时发薪💰", "info", {
        title = "🏮万事如意🏮",
    })

    vim.cmd([[
    hi BqfPreviewBorder guifg=#3e8e2d ctermfg=71
    hi BqfPreviewTitle guifg=#3e8e2d ctermfg=71
    hi BqfPreviewThumb guibg=#3e8e2d ctermbg=71
    hi link BqfPreviewRange Search
    ]])

    require("bqf").setup({
        auto_enable = true,
        auto_resize_height = true,
        preview = {
            win_height = 12,
            win_vheight = 12,
            delay_syntax = 80,
            border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
            show_title = false,
            should_preview_cb = function(bufnr, _)
                local ret = true
                local bufname = vim.api.nvim_buf_get_name(bufnr)
                local fsize = vim.fn.getfsize(bufname)
                if fsize > 100 * 1024 then
                    ret = false
                elseif bufname:match("^fugitive://") then
                    ret = false
                end
                return ret
            end,
        },
        func_map = {
            drop = "o",
            openc = "O",
            split = "<C-s>",
            tabdrop = "<C-t>",
            tabc = "",
            ptogglemode = "z,",
        },
        filter = {
            fzf = {
                action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
                extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
            },
        },
    })

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

    require("toggleterm").setup({
        size = 55,
        open_mapping = [[<c-\>]],
        shade_filetypes = {},
        direction = "vertical",
    })
end

pcall(setup_plugins)
