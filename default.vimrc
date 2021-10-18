" vim: set ft=vim :
let mapleader = ","

syntax on
filetype plugin indent on
set mouse=a
set ruler
set tabstop=2
set shiftwidth=2
set number
set expandtab
set autoindent
set copyindent
set foldmethod=syntax
set foldlevelstart=99 " don't fold by default

" set text width to 80. in program files this will only wrap comments.
" in html and shell scripts, don't wrap at all
set textwidth=80
autocmd FileType html,sh set textwidth=0

" convenience mappings
"new buffer because I forget this all the tiem
nnoremap <leader>nb :new<CR>

" reload vim config
if has('nvim')
  nnoremap <Leader>rl :so ~/.config/nvim/init.vim<CR>
else
  nnoremap <Leader>rl :so ~/.vimrc <CR>
end

nnoremap <leader>ev :e ~/.vimrc<CR>

"command! E :e
"command! W :w
"command! Q :q
"command! Wq :wq
"cnoreabbrev ff ALEFix
cnoreabbrev move Move
cnoreabbrev delete Delete
inoremap <Leader>pwd <C-R>=getcwd()<CR> " insert filepath

" touble tap esc to dehighlight the last search
nnoremap <esc><esc> :noh<return><esc>

" uppercase Y to yank full line - wtf neovim nightly, why you playin with my heart
nnoremap Y yy

" format with jq
command! JQ set ft=json | :%!jq .

" maintain selection fixing indent
vnoremap > >gv
vnoremap < <gv
vnoremap = =gv

" speedup since I run vim from terminal
let did_install_default_menus = 1
let did_install_syntax_menu = 1

" caddyfile
au BufRead,BufNewFile Caddyfile* set filetype=caddyfile
au BufRead,BufNewFile *env.* set filetype=sh
au BufRead,BufNewFile Dockerfile.* set filetype=dockerfile
au BufRead,BufNewFile docker-compose.* set filetype=yaml.docker-compose

call plug#begin('~/.vim/plugged')
  Plug 'ueaner/molokai'
  Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

" General config
colorscheme molokai

" show capture group word is highlighted by
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


"" add highlighting for note and todo
match vimTodo "FIXME"
match vimTodo "NOTE"

" NOTE setup for tagging - not used
"set tags+=.tags
"nnoremap <leader>rt :silent ! ripper-tags -R --exclude=src-databases --exclude=volume --exclude=log --exclude=tmp --exclude=dumps --exclude=test/data --exclude=.git --exclude=log -f .tags<cr>
"nnoremap <leader>pt :silent ! ptags -R --languages=ruby --exclude=volume --exclude=test/data --exclude=.git --exclude=log -f .tags<cr>
"nnoremap <silent> <leader>d :call LanguageClient#textDocument_definition()<CR>


" autoclose
"inoremap " ""<left>
"inoremap ' ''<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>
"inoremap {<CR> {<CR>}<ESC>O
"inoremap {;<CR> {<CR>};<ESC>O
