set t_BE=          " paste the text from X-session buffer (the middle button of mouse)
set number
syntax on

set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

autocmd BufWritePre * :%s/\s\+$//e

# colorscheme desert
