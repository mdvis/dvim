return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local startify = require("alpha.themes.startify")
    
    -- Custom header
    startify.section.header.val = {
      "██████╗ ███████╗██╗   ██╗███████╗",
      "██╔══██╗██╔════╝██║   ██║██╔════╝",
      "██║  ██║█████╗  ██║   ██║█████╗  ",
      "██║  ██║██╔══╝  ╚██╗ ██╔╝██╔══╝  ",
      "██████╔╝███████╗ ╚████╔╝ ███████╗",
      "╚═════╝ ╚══════╝  ╚═══╝  ╚══════╝",
    }
    
    -- Add custom buttons
    startify.section.top_buttons.val = {
      startify.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
      startify.button("f", "  Find file", ":Telescope find_files<CR>"),
      startify.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
      startify.button("g", "  Find text", ":Telescope live_grep<CR>"),
      startify.button("c", "  Config", ":e $MYVIMRC<CR>"),
      startify.button("q", "  Quit", ":qa<CR>"),
    }
    
    -- Disable MRU cwd
    startify.section.mru_cwd.val = { { type = "padding", val = 0 } }
    
    alpha.setup(startify.config)
  end,
}
