return {
    'rcarriga/nvim-notify',
    config = function()
        require('notify').setup({
            enablede = false,
            backgroun_colour = '#000000'
        })
    end
}
