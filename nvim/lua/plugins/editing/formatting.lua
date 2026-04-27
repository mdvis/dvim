return {
    {
        "stevearc/conform.nvim",
        cmd = "ConformInfo",
        opts = {
            formatters_by_ft = {
                go = { "goimports", "gofumpt" },
                rust = { "rustfmt" },
                python = { "ruff_format", "black" },
                lua = { "stylua" },
                sh = { "shfmt" },
                bash = { "shfmt" },
                zsh = { "shfmt" },
                javascript = { "prettierd", "prettier" },
                javascriptreact = { "prettierd", "prettier" },
                typescript = { "prettierd", "prettier" },
                typescriptreact = { "prettierd", "prettier" },
            },
            format_on_save = function(bufnr)
                return {
                    timeout_ms = 1200,
                    lsp_format = "fallback",
                    bufnr = bufnr,
                }
            end,
        },
    },
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPost", "BufNewFile", "BufWritePost", "InsertLeave" },
        config = function()
            local lint = require("lint")
            local function first_available(candidates)
                for _, item in ipairs(candidates) do
                    local linter_name = item[1]
                    local cmd = item[2]
                    if vim.fn.executable(cmd) == 1 then
                        return { linter_name }
                    end
                end
                return {}
            end

            local preferred_by_ft = {
                go = { { "golangcilint", "golangci-lint" } },
                rust = { { "clippy", "cargo" } },
                python = { { "ruff", "ruff" } },
                lua = { { "luacheck", "luacheck" } },
                sh = { { "shellcheck", "shellcheck" } },
                bash = { { "shellcheck", "shellcheck" } },
                zsh = { { "shellcheck", "shellcheck" } },
                javascript = { { "eslint_d", "eslint_d" }, { "eslint", "eslint" } },
                javascriptreact = { { "eslint_d", "eslint_d" }, { "eslint", "eslint" } },
                typescript = { { "eslint_d", "eslint_d" }, { "eslint", "eslint" } },
                typescriptreact = { { "eslint_d", "eslint_d" }, { "eslint", "eslint" } },
            }

            local group = vim.api.nvim_create_augroup("nvim_lint", { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = group,
                callback = function()
                    local ft = vim.bo.filetype
                    local candidates = preferred_by_ft[ft]
                    if candidates then
                        local linters = first_available(candidates)
                        if #linters > 0 then
                            lint.try_lint(linters)
                        end
                    end
                end,
            })
        end,
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("tiny-inline-diagnostic").setup({
                preset = "classic", -- 或 "dark", "classic"
                options = {
                    show_source = true,
                    throttle = 20,
                },
            })
        end,
    },
}
