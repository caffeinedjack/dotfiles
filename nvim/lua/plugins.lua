return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.6',
		dependencies = {
			'nvim-lua/plenary.nvim'
		},
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-p>", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		end
	},
	{
    		"nvim-treesitter/nvim-treesitter",
    		build = ":TSUpdate",
    		config = function ()
      		local configs = require("nvim-treesitter.configs")
      		configs.setup({
          		ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "go", "html" },
          		sync_install = true,
          		highlight = { enable = true },
          		indent = { enable = true },
        	})
    		end
 	},
	{
  		"folke/tokyonight.nvim",
  		lazy = false,
  		priority = 1000,
  		opts = {},
	},
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup()
		end
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/nvim-cmp',
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "gopls", "lua_ls" }
			})
			require("mason-lspconfig").setup_handlers {
        			function (server_name)
            				require("lspconfig")[server_name].setup {}
    				end
			}
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
				      expand = function(args)
					require('luasnip').lsp_expand(args.body)
				      end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
						{ name = 'nvim_lsp' },
						{ name = 'luasnip' },
					}, {{ name = 'buffer' }}
				)
  			})
		end
	},
	{
		"vimwiki/vimwiki",
		init = function() 
        		vim.g.vimwiki_list = {
            			{
            			path = '~/wiki',
            			syntax = 'markdown',
            			ext = '.md',
            			},
        		}
    		end
	}
 }
