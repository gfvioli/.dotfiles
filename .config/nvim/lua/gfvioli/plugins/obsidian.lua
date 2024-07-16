return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local obsidian = require('obsidian')
        local vault_path = vim.loop.os_getenv("OBSIDIAN_VAULT_PATH")

        if not vault_path then
            vim.notify("OBSIDIAN_VAULT_PATH environment variable is not set", vim.log.levels.ERROR)
            return
        end

        obsidian.setup({
            workspaces = {
                {
                    name = 'Obsidian Vault',
                    path = vault_path,
                }
            },

            completions = {
                nvimp_cmp = true,
                min_chars = 2,
                -- * 'current_dir' - put new notes in same directory as the current buffer.
                -- * 'notes_subdir' - put new notes in the default notes subdirectory.
                new_notes_location = 'current_dir',
                -- 1. Whether to add the note ID during competion.
                -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
                prepend_note_id = true,
            },

            vim.keymap.set('n', "<leader>of", function() return obsidian.util.gf_passthrough() end,
                { noremap = false, expr = true, buffer = true, desc = '[O]bisidan [f]ollow' }),

            vim.keymap.set('n', "<leader>od", function() return obsidian.util.toggle_checkbox() end,
                { buffer = true, desc = '[O]bsidian [d]one' }),

            note_fontmatter_func = function(note)
                -- This is equivalent to the default frontmatter
                local out = { id = note.id, aliases = note.aliases, tags = note.tags, area = "", project = "" }

                -- `note.metada` contains any manually added field in the frontmatter
                -- So here we just make sure those fields are kept in the frontmatter
                if note.metada ~= nil and not vim.tbl_isempty(note.metada) then
                    for k, v in pairs(note.metadata) do
                        out[k] = v
                    end
                end
                return out
            end,

            templates = {
                subdir = "Templates",
                date_format = "%Y-%m-%d-%a",
                time_format = "%H:%M",
                tags = "",
            },
        })
    end
}
