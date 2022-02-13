"{{{ modeline
" vim: foldmethod=marker
"}}}

"{{{ col: vundle
set nocompatible               " be iMproved
filetype off                   " required!
set shellslash

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle -- required! 
Plugin 'VundleVim/Vundle.vim'

" my bundles:
Plugin 'majutsushi/tagbar'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'junegunn/vim-easy-align'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tmhedberg/simpylfold'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'vim-voom/VOoM'
Plugin 'juneedahamed/vc.vim'
Plugin 'mkalinski/vim-lightline_tagbar'

" github repos of the user 'vim-scripts' => can omit the username part
Plugin 'taglist.vim'
"Plugin 'L9'
"Plugin 'FuzzyFinder'

" non github repos
Plugin 'git://git.wincent.com/command-t.git'

call vundle#end()
filetype plugin indent on " required!
"}}}
"{{{ col: general stuff
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set foldopen=block,hor,mark,percent,quickfix,search,undo
set number
set nowrap
set fo=qcrotc
set laststatus=2
set belloff=all
set hidden
"}}}
"{{{ col: search options
set incsearch
set ignorecase smartcase
"}}}
"{{{ col: appearance
let g:solarized_underline  = 0      "default value is 1
let g:solarized_contrast   = "high" "default value is normal
let g:solarized_visibility = "high" "default value is normal

let g:lightline = { 'colorscheme': 'jellybeans', 
                 \  'component_function': { 'tagbar': 'lightline_tagbar#component', },
                 \  'active': { 
                 \             'right': [ 
                 \                       ['lineinfo'], 
                 \                       ['percent'], 
                 \                       ['tagbar'], 
                 \                      ], 
                 \            },
                 \}
" , 'fileformat', 'fileencoding', 'filetype'], 
" printf-compatible string that accepts a single value - the name of the tag.
let g:lightline_tagbar#format = '%s'  " Flags argument passed to
" tagbar#currenttag. See documentation of that " function for details. let
let g:lightline_tagbar#flags = ''

syntax enable
set background=dark
colorscheme solarized
set guifont=Monospace\ 10
set guioptions=aegitm
set relativenumber

"}}}
"{{{ col: window motions unimpaired style
noremap <silent> [w <C-W><Left>
noremap <silent> ]w <C-W><Right>
noremap <silent> [W <C-W><Up>
noremap <silent> ]W <C-W><Down>
"}}}
"{{{ col: easyalign mappings
" interactive easyalign in visual mode (e.g., vipga)
xmap ga <Plug>(EasyAlign)
" interactive easyalign for a motion/text object (e.g., gaip)
nmap ga <Plug>(EasyAlign)
"}}}
"{{{ col: taglist settings
let Tlist_Sort_Type = 'name'
let Tlist_Show_Menu = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Process_File_Always = 1
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Enable_Fold_Column = 0
"}}}
"{{{ col: filename tab completion
set wildmode=longest,list,full
set wildmenu
"}}}
"{{{ col: highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1

let g:cpp_experimental_simple_template_highlight = 1
" let g:cpp_experimental_template_highlight = 1

let g:cpp_concepts_highlight = 1

" let g:cpp_no_function_highlight = 1
"}}}
"{{{ col: cpp settings
autocmd FileType cpp setlocal commentstring=//%s
autocmd FileType cpp set foldmethod=syntax
"}}}

"{{{ fun: custom fold text
fu! CustomFoldText()
    "get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile
    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif
    let line = substitute(line, '[^ ]*{{{ ', '', '')

    let w               = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let foldSize        = 1 + v:foldend - v:foldstart - 2
    let foldSizeStr     = "[" . foldSize . " lines]"
    let foldLevelStr    = repeat("+--", v:foldlevel)
    let lineCount       = line("$")
    let foldPercentage  = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    "let expansionString = repeat(" ", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    let expansionString = repeat(" ", w - strwidth(foldSizeStr.line))
    "return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
    return line . expansionString . foldSizeStr
endf
set foldtext=CustomFoldText()
"}}}
