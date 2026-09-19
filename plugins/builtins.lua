vim.cmd.packadd("nvim.undotree")
vim.keymap.set("n", "<leader>u", require("undotree").open, { desc = "Opens undotree" })

vim.cmd.packadd("nohlsearch")
vim.opt.rtp:prepend("~/projects/track-lite.nvim")

return {}
