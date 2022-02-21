GuiFont! Share\ Tech\ Mono:h12

set title

augroup dirchange
    autocmd!
    autocmd DirChanged * let &titlestring=v:event['cwd']
augroup END
