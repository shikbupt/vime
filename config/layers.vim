" 插件组合
if exists('g:vscode')
    LoadScript layers/vscode.vim
    finish
endif

" lsp插件选择
" LoadScript layers/lsp_ycm.vim
" LoadScript layers/lsp_lspsaga.vim
" LoadScript layers/lsp_completion-nvim.vim
LoadScript layers/lsp_coc.vim

" git类插件组合
LoadScript layers/git.vim

" search
" LoadScript layers/search_telecope.vim
LoadScript layers/search_fzf.vim

" theme
LoadScript layers/theme.vim

" 其他插件
LoadScript layers/plugin_list.vim

" 经过长时间的使用，我发现我常用的插件并不多，所以我经常使用下面的simple组合
" LoadScript layers/simple.vim
