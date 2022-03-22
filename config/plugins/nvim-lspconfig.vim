if !exist("g:lspconfig")
    finish
endif

lua << EOF
-- clangd
require'lspconfig'.clangd.setup{
    cmd = {"clangd", "--background-index"},
    filetypes = { "c", "cpp", "objc", "objcpp" },
    -- root_dir = root_pattern("compile_commands.json", "compile_flags.txt", ".git")
}
require'lspconfig'.gopls.setup{
    cmd = {"gopls", "serve"},
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
}
EOF
