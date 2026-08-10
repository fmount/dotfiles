-- Main plugin specification for lazy.nvim
return {
  -- Git integration
  { "tpope/vim-fugitive", cmd = { "Git", "Gdiff", "Gwrite", "Gcommit" } },
  { "tpope/vim-obsession", lazy = false },
  { "airblade/vim-gitgutter", event = "VeryLazy" },

  -- File management and navigation  
  { 
    "scrooloose/nerdtree", 
    cmd = "NERDTreeToggle",
    keys = { { "<F3>", "<cmd>NERDTreeToggle<cr>", desc = "Toggle NERDTree" } },
  },

  -- UI and appearance
  { "ap/vim-buftabline", event = "VeryLazy" },
  {
    "itchyny/lightline.vim",
    lazy = false,
    init = function()
      vim.g.lightline = { colorscheme = "jellybeans" }
    end,
  },
  { "ryanoasis/vim-devicons", event = "VeryLazy" },
  { 
    "mhinz/vim-startify", 
    lazy = false,
    priority = 1000,
  },

  -- Code navigation and analysis
  { 
    "liuchengxu/vista.vim", 
    cmd = "Vista",
    keys = { { "<F2>", "<cmd>Vista!!<cr>", desc = "Toggle Vista" } },
  },
  { 
    "mbbill/undotree", 
    cmd = "UndotreeToggle",
    keys = { { "<F6>", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" } },
  },

  -- Writing and notes
  { "fmount/vim-notes", ft = "markdown" },
  { "junegunn/goyo.vim", cmd = "Goyo" },
  -- GUI support
  { "equalsraf/neovim-gui-shim", lazy = false },

  -- LSP and completion
  { 
    "neovim/nvim-lspconfig", 
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
  },
  { 
    "glepnir/lspsaga.nvim", 
    event = "LspAttach",
    dependencies = { "nvim-lspconfig" },
  },

  -- Completion framework
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-vsnip", 
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/vim-vsnip",
    },
  },

  -- Telescope and dependencies
  { "nvim-lua/popup.nvim", lazy = true },
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "LSP references" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      "nvim-telescope/telescope-media-files.nvim", 
      "nvim-telescope/telescope-project.nvim",
    },
  },

  -- TreeSitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
  },

 -- Claude Code integration
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    cmd = { "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeAdd", "ClaudeCodeSend", "ClaudeCodeDiffAccept", "ClaudeCodeDiffDeny", "ClaudeCodeTreeAdd" },
    opts = {
      -- terminal_cmd = vim.fn.exepath("/sbin/claude"), -- lets Neovim resolve it at runtime
      terminal = {
        provider = "snacks",
        split_side = "right",
        split_width_percentage = 0.50,
      },
    },
    keys = {
      { "<leader>cc", "<cmd>ClaudeCode<cr>",           desc = "Toggle Claude" },
      { "<C-,>",      "<cmd>ClaudeCodeFocus<cr>",      desc = "Focus Claude",  mode = { "n", "x" } },
      { "<leader>ca", "<cmd>ClaudeCodeAdd %<cr>",      desc = "Add buffer to Claude" },
      { "<leader>cs", "<cmd>ClaudeCodeSend<cr>",       mode = "v", desc = "Send selection to Claude" },
      { "<leader>cn", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>cx", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
      -- NERDTree integration
      { "<leader>ca", "<cmd>ClaudeCodeTreeAdd<cr>",    desc = "Add file to Claude", ft = { "nerdtree" } },
    },
  },

  -- OpenCode integration
  {
    "nickjvandyke/opencode.nvim",
    cmd = "OpenCode",
    config = function()
      require('fmount.opencode')
    end,
  },
}
