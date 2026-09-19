--[[
╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
│                                                          │
│                         autocmds                         │
│                                                          │
╰──────────────────────────────────────────────────────────╯
]]

local fn = vim.fn

-- closes Lexplore automatically when entering a file
soupvim.create_autocmd("BufWinEnter", {
	callback = function()
		if fn.getbufvar(fn.winbufnr(fn.winnr()), "&filetype") ~= "netrw" then
			for bufn = 1, fn.bufnr("$") do
				if fn.bufexists(bufn) and fn.getbufvar(bufn, "&filetype") == "netrw" then
					vim.cmd("silent! bwipeout" .. bufn)
					return
				end
			end
		end
	end,
	pattern = "*",
})

-- Highlights Yanked text
soupvim.create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 150,
		})
	end,
	pattern = "*",
})

-- Saves the colorscheme whenever it changes
soupvim.create_autocmd("ColorScheme", {
	callback = function(args)
		vim.g.LAST_COLORSCHEME = args.match
	end,
})
-- Loads last used colorscheme
soupvim.create_autocmd("VimEnter", {
	callback = function()
		vim.cmd("colorscheme " .. vim.g.LAST_COLORSCHEME or soupvim.default_colorscheme)
	end,
})

-- =============================================================================
-- PONTE OBSIDIAN - PROTEÇÃO DE ESTADO (ANTI-LOOP)
-- =============================================================================

local last_sync_path = "" -- Variável de controle para evitar duplicidade

local function sync_to_obsidian()
	if not vim.g.launched_from_obsidian then
		return
	end

	local filepath = vim.fn.expand("%:p"):gsub("\\", "/"):lower()
	local bufnr = vim.api.nvim_get_current_buf()

	-- 1. Filtros de segurança
	if vim.bo[bufnr].buftype ~= "" or filepath == "" then
		return
	end
	if not (filepath:find("%.md$") or filepath:find("%.qmd$") or filepath:find("%.base$")) then
		return
	end

	-- 2. Verifica a trava vinda do Obsidian (impede o loop de volta)
	local lock_path = (vim.g.obsidian_lock or ""):gsub("\\", "/"):lower()
	if lock_path ~= "" and filepath == lock_path then
		vim.g.obsidian_lock = ""
		last_sync_path = filepath -- Registra que o Obsidian já sabe deste arquivo
		return
	end

	-- 3. Evita enviar a notificação se o arquivo for o mesmo que acabamos de sincronizar
	if filepath == last_sync_path then
		return
	end

	-- 4. Execução (Ação manual do usuário no Neovim)
	last_sync_path = filepath
	local raw_path = vim.fn.expand("%:p")
	local encoded_path = raw_path:gsub(" ", "%%20")

	-- Adicionamos o parâmetro silent=true (se o plugin do Obsidian suportar)
	-- ou simplesmente limpamos o log.
	local uri = "obsidian://open?path=" .. encoded_path

	if vim.fn.has("unix") == 1 then
		vim.fn.jobstart({ "xdg-open", uri }, { detach = true })
	elseif vim.fn.has("win32") == 1 then
		vim.fn.jobstart({ "cmd.exe", "/c", "start", uri }, { detach = true })
	end
end

local obsidian_sync_group = vim.api.nvim_create_augroup("ObsidianSync", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
	group = obsidian_sync_group,
	pattern = { "*.md", "*.qmd", "*.base" },
	callback = function()
		-- schedule garante que variáveis globais enviadas por RPC já foram processadas
		vim.schedule(sync_to_obsidian)
	end,
})

-- =============================================================================
