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
  { "itchyny/lightline.vim", event = "VeryLazy" },
  { "ryanoasis/vim-devicons", lazy = false },
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
  { "OXY2DEV/markview.nvim", ft = "markdown" },

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

  -- LSP extensions
  { "nvim-lua/lsp_extensions.nvim", event = "LspAttach" },

  -- Claude Code integration
  {
    "greggh/claude-code.nvim",
    cmd = "ClaudeCode",
    keys = {
      { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
      { "<C-,>", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
    },
  },
}