" Django template comments surround with -
" 45 is ASCII for - to see, use :echo char2nr("-")
let b:surround_45 = "{# \r #}"

inoremap <buffer> <c-t> {%<space><space>%}<left><left><left>
inoremap <buffer> <c-f> {{<space><space>}}<left><left><left>
set shiftwidth=2
set softtabstop=2
set tabstop=2
