return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, desc)
                vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
            end

            -- Navigation
            map("n", "]h", gs.next_hunk, "Next [H]unk")
            map("n", "[h", gs.prev_hunk, "Previous [H]unk")

            -- Actions
            map("n", "<leader>hs", gs.stage_hunk, "[H]unk: [S]tage")
            map("n", "<leader>hr", gs.reset_hunk, "[H]unk: [R]eset")

            map("v", "<leader>hs", function()
                gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, "[H]unk: [S]tage (visual mode)")
            map("v", "<leader>hr", function()
                gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, "[H]unk: [R]eset")

            map("n", "<leader>gS", gs.stage_buffer, "[G]it: [S]tage buffer")
            map("n", "<leader>gR", gs.reset_buffer, "[G]it: [R]eset buffer")

            map("n", "<leader>hu", gs.undo_stage_hunk, "[H]unk: [U]ndo stage")

            map("n", "<leader>hp", gs.preview_hunk, "[H]unk: [P]review")

            -- NOTE: duplicated from neogit, keeping that one for now
            -- map("n", "<leader>gB", function()
            --     gs.blame_line({ full = true })
            -- end, "Blame line")

            map("n", "<leader>hB", gs.toggle_current_line_blame, "Line [B]lame")

            map("n", "<leader>hd", gs.diffthis, "[D]iff this")
            map("n", "<leader>hD", function()
                gs.diffthis("~")
            end, "[D]iff this ~")

            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")
        end,
    },
}
