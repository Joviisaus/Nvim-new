return {
    "MattesGroeger/vim-bookmarks",
    event = "VimEnter",
    config = function()
        vim.cmd([[
            highlight BookmarkSign ctermbg=NONE ctermfg=red
            highlight BookmarkLine ctermbg=194 ctermfg=NONE
            let g:bookmark_sign = '🔖'
            let g:bookmark_annotation_sign = '🖋️'
            let g:bookmark_highlight_lines = 1
            unmap mp
            ]])
    end,
}
