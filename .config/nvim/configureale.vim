" disable ALE LSP because we're using coc
let g:ale_disable_lsp = 1

" only lint on save for performance reasons
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1

" enable airline extension
let g:airline#extensions#ale#enabled = 1
