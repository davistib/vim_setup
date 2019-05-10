" ---------------------------------------------------------------------------
"  VIM setup
" ---------------------------------------------------------------------------
"  author: brian.davis
"   email: davistib@gmail.com
"    date: 05.08.2019  
" ---------------------------------------------------------------------------

" ----------------------------------------
" Default inputs
" ----------------------------------------
set encoding=utf-8

" coloring
syntax on

" dark background
set bg=dark


" default tabs and such
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=-1 

" indentation
set autoindent
set smartindent
" This keeps smartindent from aligning comments at the beginning of the line    
inoremap # X#

" set column ruler                                                              
set colorcolumn=80   " change this if you are a savage and go past 80 columns
highlight ColorColumn ctermbg=DarkGray

" default to no text wrapping
set nowrap

" allow nice pasting 
"set paste - note: this screws with autoindent 
set pastetoggle=<F7>                                                            
                                                                                 
" turn on line numbers                                                          
set number

" set no line wrapping by default                                               
set nowrap  

" split windows navigations
nnoremap <C-J> <C-W><C-J>                                                          
nnoremap <C-K> <C-W><C-K>                                                          
nnoremap <C-L> <C-W><C-L>                                                          
nnoremap <C-H> <C-W><C-H>                                                          
                                                                                   
" Enable code folding                                                                   
set foldmethod=indent                                                              
set foldlevel=99                                                                   
" Enable folding with the spacebar                                                 
nnoremap <space> za                                                                

" python indentation and such
au BufNewFile,BufRead *.py                                                         
    \ set tabstop=4 |                                                              
    \ set softtabstop=4 |                                                       
    \ set shiftwidth=4 |                                                        
    \ set textwidth=79 |                                                        
    \ set expandtab |                                                           
    \ set autoindent |                                                          
    \ set fileformat=unix                                                       
                                                                                
" tcl indentation and such
au BufNewFile,BufRead *.tcl.*
    \ set tabstop=3 |                                                              
    \ set softtabstop=3 |                                                       
    \ set shiftwidth=3 |                                                        
    \ set textwidth=79 |                                                        
    \ set expandtab |                                                           
    \ set autoindent |                                                          
    \ set fileformat=unix                                                       

" flag bad white space - comment if you don't like it                           
"highlight BadWhitespace ctermbg=red guibg=darkred                               
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/            
                                                                                
" ---------------------------------------------------------------------------   
" Vundle and Plugin  inputs                                                                 
" ---------------------------------------------------------------------------   
" inputs from: https://realpython.com/vim-and-python-a-match-made-in-heaven/    
" ---------------------------------------------------------------------------   
set nocompatible              " required                                        
filetype off                  " required                                        
set t_Co=256                  " set terminal to 256 colors for powerline
                                                                                
" set the runtime path to include Vundle and initialize                         
set rtp+=~/.vim/bundle/Vundle.vim                                               
call vundle#begin()                                                             
                                                                                
" alternatively, pass a path where Vundle should install plugins                
"call vundle#begin('~/some/path/here')                                          
                                                                                
" let Vundle manage Vundle, required                                            
Plugin 'gmarik/Vundle.vim'                                                      
                                                                                
" add all your plugins here 
" (note older versions of Vundle used Bundle instead of Plugin)                                                
Plugin 'tmhedberg/SimpylFold'                                                   
let g:SimpylFold_docstring_preview=1                                            
 
" python indentation                                                            
Plugin 'vim-scripts/indentpython.vim'                                           
                                                                               
" code completion using YCM
" NOTE: this requires vim 7.4.1056+ - not installed by default on linux boxes
if v:version > 704
    Plugin 'Valloric/YouCompleteMe'                                                 
    let g:ycm_autoclose_preview_window_after_completion=1                           
    map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
endif
" NOTE: this does not work with conda python installation. Install by running   
" /usr/bin/python  ~/.vim/bundle/YouCompleteMe/install.py                       
                                                                               
" python with virtualenv support                                                
"py << EOF                                                                      
"import os                                                                      
"import sys                                                                     
"if 'VIRTUAL_ENV' in os.environ:                                                
"    project_base_dir = os.environ['VIRTUAL_ENV']                               
"    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')     
"    execfile(activate_this, dict(__file__=activate_this))                      
"EOF
" The VIM needs python support for this to work

" syntax highlighting                                                           
Plugin 'vim-syntastic/syntastic'                                                
Plugin 'nvie/vim-flake8'                                                        
let python_highlight_all=1                                                      
syntax on                                                                       
                                                                                
" file tree                                                                     
Plugin 'scrooloose/nerdtree'                                                    
" ignore *.pyc files                                                            
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
" use F6 to launch file tree
nmap <F6> :NERDTreeToggle<CR>
                                                                               
" powerline status bar                                                          
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}                 
set laststatus=2                                                                
" install fonts for powerline by:
" git clone https://github.com/powerline/fonts.git --depth=1
" cd fonts
" ./install.sh
" cd ..
" rm -rf fonts

" auto-pairs for parenthesis and such
Plugin 'jiangmiao/auto-pairs'

" block comments
Plugin 'scrooloose/nerdcommenter'
let g:NERDDefaultAlign='left'
let g:NERDTrimTrailingWhitespace=1
" use like \cc to block comment out a visual block or current line
" see https://github.com/scrooloose/nerdcommenter for help

" surround text
Plugin 'tpope/vim-surround'
" e.g., use cd"' to change from double quote to single quote  
" e.g., use ds" to delete quotes from surrounding text

" ...add more plugins here 
                                                                                
" All of your Plugins must be added before the following line                   
call vundle#end()            " required                                         
filetype plugin indent on    " required                                         
" --------------------------------------------------------------------------- 
