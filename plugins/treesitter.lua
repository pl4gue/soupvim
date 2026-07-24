--[[
╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
│                                                          │
│                        Treesitter                        │
│                                                          │
╰──────────────────────────────────────────────────────────╯
]]

return {
	"nvim-treesitter/nvim-treesitter",
	build = ':TSUpdate',

		-- dependencies = {
	-- 	{
	-- 		"nvim-treesitter/nvim-treesitter-textobjects",
	-- 		branch = 'main',
	-- 		init = function()
	-- 			-- Disable entire built-in ftplugin mappings to avoid conflicts.
	-- 			-- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
	-- 			vim.g.no_plugin_maps = true
	-- 		end
	-- 	}
	-- },

	config = function()
		local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim',
			'vimdoc' }
		require('nvim-treesitter').install(parsers)

		---@param buf integer
		---@param language string
		local function ts_attach(buf, language)
			-- Check if a parser exists and load it
			if not vim.treesitter.language.add(language) then return end
			-- Enable syntax highlighting and other treesitter features
			vim.treesitter.start(buf, language)

			-- Enable treesitter based folds
			-- For more info on folds see `:help folds`
			vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
			vim.wo.foldmethod = 'expr'

			-- Check if treesitter indentation is available for this language, and if so enable it
			-- in case there is no indent query, the indentexpr will fallback to the vim's built in one
			local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

			-- Enable treesitter based indentation
			if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
		end

		local available_parsers = require('nvim-treesitter').get_available()
		soupvim.create_autocmd('FileType', {
			callback = function(args)
				local buf, filetype = args.buf, args.match

				local language = vim.treesitter.language.get_lang(filetype)
				if not language then return end

				local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

				if vim.tbl_contains(installed_parsers, language) then
					-- Enable the parser if it is already installed
					ts_attach(buf, language)
				elseif vim.tbl_contains(available_parsers, language) then
					-- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
					require('nvim-treesitter').install(language):await(function() ts_attach(buf, language) end)
				else
					-- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
					ts_attach(buf, language)
				end
			end,
		})
	end
}
