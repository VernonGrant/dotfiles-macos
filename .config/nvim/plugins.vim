call plug#begin('~/.vim/plugged')
Plug 'evidens/vim-twig'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'nvim-lualine/lualine.nvim'
Plug 'editorconfig/editorconfig-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'mattn/emmet-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'dcampos/nvim-snippy'
Plug 'honza/vim-snippets'
Plug 'dcampos/cmp-snippy'
Plug 'smithbm2316/centerpad.nvim'
Plug 'lourenci/github-colors'
call plug#end()

" Theming:
" -----------------------------------------------------------------------------

syntax on
set termguicolors
set background=light
colorscheme github-colors

" Make Vim transparent.
hi Normal guibg=NONE ctermbg=NONE

" Language Server Protocol And Snippets:
" -----------------------------------------------------------------------------

set completeopt=menu,menuone,noselect

lua << EOF
    local map = function(type, key, value)
        vim.api.nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true});
    end

    local custom_attach = function(client)
        print("LSP started.");
        map('n','<leader><leader>=','<cmd>lua vim.lsp.buf.formatting()<CR>')
        map('n','<leader><leader>D','<cmd>lua vim.lsp.buf.declaration()<CR>')
        map('n','<leader><leader>d','<cmd>lua vim.lsp.buf.definition()<CR>')
        map('n','<leader><leader>r','<cmd>lua vim.lsp.buf.rename()<CR>')
        map('n','<leader><leader>R','<cmd>lua vim.lsp.buf.references()<CR>')
        map('n','<leader><leader>h','<cmd>lua vim.lsp.buf.hover()<CR>')
    end

    local cmp = require'cmp'

    cmp.setup({
        completion = {
          autocomplete = false
        },
        snippet = {
          expand = function(args)
            require('snippy').expand_snippet(args.body)
          end,
        },
        -- autocomplete = false,
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'snippy' },
        }, {
          { name = 'buffer' },
        })
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )

    -- TODO: Implement a loop here.

    -- Clang
    require'lspconfig'.clangd.setup{
        on_attach=custom_attach,
        capabilities = capabilities
    }

    -- Bash
    require'lspconfig'.bashls.setup{
        on_attach=custom_attach,
        capabilities = capabilities
    }

    -- PHP
    require'lspconfig'.intelephense.setup{
        on_attach=custom_attach,
        capabilities = capabilities
    }

    -- HTML
    require'lspconfig'.html.setup{
        on_attach=custom_attach,
        capabilities = capabilities
    }

    -- CSS
    require'lspconfig'.cssls.setup{
        on_attach=custom_attach,
        capabilities = capabilities
    }

    -- YAML
    require'lspconfig'.yamlls.setup{
        on_attach=custom_attach,
        capabilities = capabilities
    }

    -- Docker Files
    require'lspconfig'.dockerls.setup{
        on_attach=custom_attach,
        capabilities = capabilities
    }

    -- TypeScript and JavaScript
    require'lspconfig'.tsserver.setup{
        on_attach=custom_attach,
        capabilities = capabilities
    }
EOF

" Lua Line:
" -----------------------------------------------------------------------------

lua << EOF

-- Molokai theme for lua line:
--  local custom_molokai = require'lualine.themes.molokai'
--  custom_molokai.normal.b.bg = '#272822'
--  custom_molokai.normal.b.fg = '#f8f8f2'
--  custom_molokai.normal.c.bg = '#3B3A32'
--  custom_molokai.normal.c.fg = '#f8f8f2'
--  custom_molokai.inactive.a.bg = '#272822'
--  custom_molokai.inactive.b.bg = '#272822'
--  custom_molokai.inactive.c.bg = '#272822'

-- Customizing Lua Line
require('lualine').setup {
  options = {
    icons_enabled = false,
    -- theme = custom_molokai,
    theme = 'auto',
    section_separators = { left = ' ', right = ' ' },
    component_separators = { left = ' ', right = ' ' },
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    -- lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    -- lualine_z = { 'diff', 'diagnostics', 'location'}
    lualine_z = { 'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
EOF

" FZF:
" -----------------------------------------------------------------------------

" Use Rip Grep for everything.
" let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" This is the default option.
let g:fzf_preview_window = []

" Jump to the existing window if possible.
let g:fzf_buffers_jump = 1

" Layout customization.
let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.6 } }

" Match theme colors.
let g:fzf_colors =
            \ { 'fg':    ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Vim Commentor:
" -----------------------------------------------------------------------------

autocmd FileType c,cpp setlocal commentstring=//\ %s
