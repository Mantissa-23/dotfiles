-- Additional Plugins
lvim.plugins = {
  {
    'vimwiki/vimwiki',
    config = function()
      vim.g.vimwiki_list = {
        {
          path = '$HOME/Wiki',
          syntax = 'markdown',
          ext = '.md',
        }
      }
    end
  },
  {
    'dhruvasagar/vim-table-mode',
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {'morhetz/gruvbox'},
  {'tpope/vim-surround'},
  {'tpope/vim-fugitive'},
}

-- General

-- Timeoutlen to 100ms
vim.o.timeoutlen = 200

lvim.log.level = "warn"
-- lvim.format_on_save = true
lvim.colorscheme = "gruvbox"

-- Set ignorecase and smartcase so that all-lowercase searches are case-insensitive, but everything else is
vim.o.ignorecase = true
vim.o.smartcase = true

-- Set scrolloff so we can always see above and below the cursor by at last 10 lines
vim.o.scrolloff = 10

-- Set linebreak so that words don't get cut off in the middle
vim.o.linebreak = true

-- Turn off wrap by default and enable sidescroll
vim.o.wrap = false
vim.o.sidescroll = 1

-- autocmds
lvim.autocommands.custom_groups = {
  -- BUT enable wrap for "plaintext" files
  { "BufWinEnter", "markdown,tex,markdown.mdx,vimwiki", "setlocal wrap"}
}

-- Keymappings

lvim.leader = "space"
-- add your own keymapping
lvim.keys.insert_mode["jj"] = false
lvim.keys.insert_mode[";;"] = "<ESC>"

-- Custom whichkey mappings
local builtin_mappings = lvim.builtin.which_key.mappings

lvim.builtin.which_key.mappings = {
  e = builtin_mappings['e'],
  L = builtin_mappings['L'],
  l = builtin_mappings['l'],
  b = builtin_mappings['b'],
  p = builtin_mappings['p'],
  g = {
    g = { "<cmd>Git<cr>", "Git Interface" },
  },
  q = { "<cmd>BufferClose!<CR>", "Close Buffer" },
  f = {
    name = "Find (Telescope)",
    g = {
      name = "Git",
      c = { "<cmd>Telescope git_branches<cr>", "Branches (checkout)" },
    },
    p = { "<cmd>Telescope projects<cr>", "Projects" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    s = { "<cmd>Telescope live_grep<cr>", "Text Search (Grep)" },
    S = { "<cmd>Telescope symbols<cr>", "Symbols" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    c = {
      "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
      "Colorscheme with Preview",
    },
  },
  w = {
    name = "VimWiki",
    i = "Diary Index",
    w = "Wiki Index",
    t = "Wiki Index (new tab)",
    d = "Delete this wiki file",
    r = "Rename this file",
    f = { "<cmd>lua require('telescope.builtin').find_files({ cwd = '$HOME/Wiki/'})<cr>", "Find file in wiki" },
    s = { "<cmd>lua require('telescope.builtin').live_grep({ cwd = '$HOME/Wiki/'})<cr>", "Find file in wiki" },
  },
  j = {
    name = "Journal",
    j = { "<cmd>VimwikiMakeDiaryNote<cr>", "New entry (today)" },
    g = { "<cmd>VimwikiDiaryGenerateLinks<cr>", "Regenerate Index" },
    i = { "<cmd>VimwikiDiaryIndex<cr>", "Goto Index" },
    f = { "<cmd>lua require('telescope.builtin').find_files({ cwd = '$HOME/Wiki/diary'})<cr>", "Find file in wiki" },
    s = { "<cmd>lua require('telescope.builtin').live_grep({ cwd = '$HOME/Wiki/diary'})<cr>", "Find file in wiki" },
  },
  -- Comment.api not working
  -- c = { "<CMD>lua require('Comment.api').toggle_current_linewise()<CR>", "Toggle Comment" },
  t = {
    name = "Table Mode",
    m = "Toggle table mode",
    t = "Tableize",
  },
  i = {
    name = "Insert",
    t = { "<cmd>pu=strftime('%H:%M:%S %Z')<cr>", "Insert Current Timestamp"},
    d = { "<cmd>pu=strftime('%a %d %b %Y')<cr>", "Insert Current Day"},
    s = { "<cmd>pu=strftime('%a %d %b %Y %H:%M:%S %Z')<cr>", "Insert Current Day" },
  },
}
lvim.builtin.which_key.vmappings = {
  -- Commnt.api not working
  -- c = { "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", "Toggle Comment" },
  T = "Tableize Delimiter",
  t = {
    name = "Table Mode",
    t = "Tableize"
  },
}
-- Disable whichkey specifically for the semicolon key so we can still type in semicolons and use ;; to escape
lvim.builtin.which_key.on_config_done = function(which_key)
  which_key.register({
    [';'] = 'which_key_ignore'
  }, {
    mode = 'i',
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
  })
end

-- LunarVim builtin plugin settings

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.nvimtree.setup.update_cwd = false
lvim.builtin.project.manual_mode = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
lvim.lsp.automatic_servers_installation = false

-- Use prettier for JavaScript
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   -- { exe = "black", filetypes = { "python" } },
--   -- { exe = "isort", filetypes = { "python" } },
--   {
--     exe = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { exe = "flake8", filetypes = { "python" } },
--   {
--     exe = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     args = { "--severity", "warning" },
--   },
--   {
--     exe = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }
