-- Leader key settings
vim.g.mapleader = " " vim.g.maplocalleader = " "
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Require smt
require("config.lazy")
require('lualine').setup()
require('bufferline').setup()
require('nvim-tree').setup()
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-nvim-dap").setup({
  ensure_installed = {}
})
require("nvim-dap-virtual-text").setup()
require("toggleterm").setup{}
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "bash", "helm", "json", "go", "lua", "vim", "yaml" }, 
  auto_install = true,
  highlight = {
    enable = true,
  },
}
require("dapui").setup()
require('dap-go').setup()

-- Setup formatter
local util = require "formatter.util"
require("formatter").setup{
  logging = true,
  filetype = {
    go = {
      function()
        return {
          exe = "gofmt",
          args = { vim.api.nvim_buf_get_name(0)},
          stdin = true,
        }
      end
    }
  }
}

-- Tab settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

-- Telescope settings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Debugger keybind
vim.keymap.set('n', '<leader>1', ":lua require('dapui').toggle()<CR>")
vim.keymap.set('n', '<leader>2', ":lua require('dap').toggle_breakpoint()<CR>")
vim.keymap.set('n', '<leader>3', ":lua require('dap').continue()<CR>")
vim.keymap.set('n', '<leader>4', ":lua require('dap').step_over()<CR>")
vim.keymap.set('n', '<leader>5', ":lua require('dap').step_into()<CR>")

-- Enable number
vim.wo.number = true

-- Custom keybind
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- LSP Config 
require'lspconfig'.sqlls.setup{}
-- require'lspconfig'.shellcheck.setup{}
require'lspconfig'.docker_compose_language_service.setup{}
require("lspconfig").dockerls.setup{}
require'lspconfig'.helm_ls.setup{}
require'lspconfig'.golangci_lint_ls.setup{}
require'lspconfig'.gopls.setup{}

-- Quickly swap between split
vim.keymap.set('n', '<C-l>', '<C-W><C-L>')
vim.keymap.set('n', '<C-k>', '<C-W><C-K>')
vim.keymap.set('n', '<C-j>', '<C-W><C-J>')
vim.keymap.set('n', '<C-h>', '<C-W><C-H>')

-- Quickly swap in terminal
vim.keymap.set('t', '<C-l>', [[<C-\><C-N><C-W><C-L>]])
vim.keymap.set('t', '<C-k>', [[<C-\><C-N><C-W><C-K>]])
vim.keymap.set('t', '<C-j>', [[<C-\><C-N><C-W><C-J>]])
vim.keymap.set('t', '<C-h>', [[<C-\><C-N><C-W><C-H>]])

-- Quickly toogle terminal
vim.keymap.set('n', '<C-`>', [[:ToggleTerm size=20 direction=horizontal name=main<CR>]])
vim.keymap.set('t', '<C-`>', [[<C-\><C-N>:ToggleTerm size=20 direction=horizontal name=main<CR>]])

-- Quickly cycle around buffer
vim.keymap.set('n', '<leader><tab>', [[:bnext<CR>]])

-- Auto close if nvim tree is the only left
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local invalid_win = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("NvimTree_") ~= nil then
        table.insert(invalid_win, w)
      end
    end
    if #invalid_win == #wins - 1 then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(invalid_win) do vim.api.nvim_win_close(w, true) end
    end
  end
})

-- Setup auto complete
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})


cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  autocomplete = false,
  sources = {
    { name = 'cmdline' }
  }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Auto format on save
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})

-- Stub for LSP 
-- General/Global LSP Configuration
local api = vim.api
local lsp = vim.lsp

local make_client_capabilities = lsp.protocol.make_client_capabilities
function lsp.protocol.make_client_capabilities()
    local caps = make_client_capabilities()
    if not (caps.workspace or {}).didChangeWatchedFiles then
        vim.notify(
            'lsp capability didChangeWatchedFiles is already disabled',
            vim.log.levels.WARN
        )
    else
        caps.workspace.didChangeWatchedFiles = nil
    end

    return caps
end

-- Color for breakpoint
vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })

vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })
