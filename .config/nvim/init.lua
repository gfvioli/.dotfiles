require("gfvioli.core")
require("gfvioli.lazy")

vim.g.clipboard = {
    name = 'myClipboard',
    copy = {
        ['+'] = 'xclip -selection clipboard',
        ['*'] = 'xclip -selection primary',
    },
    paste = {
        ['+'] = 'xclip -selection clipboard -o',
        ['*'] = 'xclip -selection primary -o',
    },
}
