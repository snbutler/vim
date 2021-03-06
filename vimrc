"{{{ modeline
" vim: foldmethod=marker
"}}}

"{{{ vundle
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle -- required! 
Plugin 'VundleVim/Vundle.vim'

" my bundles:
Plugin 'majutsushi/tagbar'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'junegunn/vim-easy-align'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tmhedberg/simpylfold'

" github repos of the user 'vim-scripts' => can omit the username part
Plugin 'taglist.vim'
"Plugin 'L9'
"Plugin 'FuzzyFinder'

" non github repos
Plugin 'git://git.wincent.com/command-t.git'

call vundle#end()
filetype plugin indent on " required!
"}}}
"{{{ general stuff
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set foldopen=block,hor,mark,percent,quickfix,search,undo
set number
set nowrap
set fo=qcrotc
set laststatus=2
"}}}
"{{{ search options
set incsearch
set ignorecase smartcase
"}}}
"{{{ appearance
let g:solarized_underline  = 0      "default value is 1
let g:solarized_contrast   = "high" "default value is normal
let g:solarized_visibility = "high" "default value is normal

let g:lightline = { 'colorscheme': 'jellybeans', }

syntax enable
set background=dark
colorscheme solarized
set guifont=Monospace\ 10
set guioptions=aegiLtm

"}}}
"{{{ window motions unimpaired style
noremap <silent> [w <C-W><Left>
noremap <silent> ]w <C-W><Right>
noremap <silent> [W <C-W><Up>
noremap <silent> ]W <C-W><Down>
"}}}
"{{{ taglist settings
let Tlist_Sort_Type = 'name'
let Tlist_Show_Menu = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Process_File_Always = 1
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Enable_Fold_Column = 0
"}}}
"{{{ filename tab completion
set wildmode=longest,list,full
set wildmenu
"}}}

"{{{ custom fold text
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

    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart - 2
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat("+--", v:foldlevel)
    let lineCount = line("$")
    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    let expansionString = repeat(" ", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf
set foldtext=CustomFoldText()
"}}}
