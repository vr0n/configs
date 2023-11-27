" plugzzz
call plug#begin()
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'nvim-neo-tree/neo-tree.nvim', {'branch': 'v3.x'} | Plug 'nvim-lua/plenary.nvim' | Plug 'nvim-tree/nvim-web-devicons' | Plug 'MunifTanjim/nui.nvim'
  Plug 'utilyre/barbecue.nvim' | Plug 'SmiteshP/nvim-navic' | Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } | Plug 'linrongbin16/fzfx.nvim'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'williamboman/mason.nvim'
  Plug 'savq/melange-nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'altercation/vim-colors-solarized'
call plug#end()

" undofile
set undodir=~/.config/nvim/undo-dir
set undofile

" open files at last line saw
if has("autocmd")
  autocmd BufReadPost * if line("'\'") > 0 && line ("'\"") <= line("$") |  exe "normal g'\"" | endif
endif

" remaps
imap jj <esc>	
map ZW :w!<CR>

" spellcheck
set spell spelllang=en_us
hi SpellBad ctermfg=none ctermbg=none cterm=underline
hi SpellLocal ctermfg=185 ctermbg=88 cterm=none
hi SpellCap ctermfg=none ctermbg=235 cterm=none

" use <tab> for trigger completion and navigate to the next complete item

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" my goods
set expandtab tabstop=2 shiftwidth=2
  
" highlight the tabs
function! HiTabs()
	syntax match TAB /\t/ containedin=all
	hi TAB cterm=underline ctermfg=blue
endfunction
au BufEnter,BufRead * call HiTabs()

set nu
syntax on

" open files at last line saw
if has("autocmd")
  autocmd BufReadPost *
    \ if line("'\'") > 0 && line ("'\"") <= line("$") |
    \  exe "normal g'\"" |
    \ endif
endif

" use <tab> for trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

lua << END
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {
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
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
  })

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
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
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  --require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
  --  capabilities = capabilities
  --}
  require('lualine').setup {
    options = {
        theme = 'dracula',
    }
  };
  require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
  };
  require("mason").setup()
END
