local builtin = require("telescope.builtin")
local telescope = require('telescope')

telescope.setup {
	defaults = {
		layout_strategy = 'horizontal',
		layout_config = {
				vertical = { width = 0.95, anchor=2 }
		},
		file_ignore_patterns = { '.git/*', 'node_modules', 'env/*' },
		color_devicons = true,
		winblend = 20,
		wrap_results = true, 
	},
}
builtin.project_files = function()
	local opts = {
		show_untracked = true
	} -- Define here if you want to define something
	vim.fn.system("git rev-parse --is-inside-work-tree")
	if vim.v.shell_error == 0 then
		builtin.git_files(opts)
	else
		builtin.find_files(opts)
	end
end

vim.keymap.set("n","<C-p>",builtin.project_files,{})
vim.keymap.set("n","<C-e>","<cmd>Telescope oldfiles<cr>",{})
vim.keymap.set("n","<C-f>",function()
	builtin.grep_string({search = vim.fn.input("Ag ")})
end)
