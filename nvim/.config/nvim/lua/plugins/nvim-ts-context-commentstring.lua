return {
    -- Context-aware comment strings
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
    },

    -- nvim-comment plugin with context support
    {
        'terrortylor/nvim-comment',
        config = function()
            require('nvim_comment').setup({
                comment_empty = false,

                -- Integrating with nvim-ts-context-commentstring
                hook = function()
                    require('ts_context_commentstring.internal').update_commentstring()
                end
            })
        end
    }
}
