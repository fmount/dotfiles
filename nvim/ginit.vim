GuiFont! NeoSpleen:h12
call GuiClipboard()

set mouse=a
set title

augroup dirchange
    autocmd!
    autocmd DirChanged * let &titlestring=v:event['cwd']
augroup END
