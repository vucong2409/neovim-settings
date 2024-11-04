return {
	{
		"nyoom-engineering/oxocarbon.nvim",
		config = function() 
				vim.opt.background = "dark"
				vim.cmd([[colorscheme oxocarbon]])
		end,
	},
	{
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
	{
		'akinsho/bufferline.nvim',
		version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function()
			vim.opt.termguicolors = true
		end,
	},
	{
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
	},
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'nvim-tree/nvim-web-devicons',
  },
  {
    'neovim/nvim-lspconfig'
  },
  {
    'williamboman/mason.nvim',
    dependencies = 'williamboman/mason-lspconfig.nvim'
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true
  },
  {
    'nvim-treesitter/nvim-treesitter',
  },
  {
    'goolord/alpha-nvim',
    config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
  },  
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
        {'L3MON4D3/LuaSnip'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'saadparwaiz1/cmp_luasnip'},
    },
  },
  { 'echasnovski/mini.nvim', version = false },
  { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },
  { 'mhartington/formatter.nvim' },
  { 'jay-babu/mason-nvim-dap.nvim' },
  { 'tpope/vim-fugitive', cmd = "Git"},
  { 'leoluz/nvim-dap-go' },
  { 'theHamsta/nvim-dap-virtual-text'},
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
  },
} 
