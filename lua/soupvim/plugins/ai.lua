return {
	"olimorris/codecompanion.nvim",
	semver = "^19.0.0",
	opts = {
		interactions = {
			chat = {
				adapter = {
                    name = "openai_responses",
                    model = "gpt-6-luna"
                },
				tools = {
					["run_command"] = {
						opts = { judge = true },
					},
				},
			},
			inline = {
				adapter = {
                    name = "openai_responses",
                    model = "gpt-6-luna"
                },
			},
			background = {
				adapter = {
					name = "openai",
					model = "gpt-5-nano",
				},
			},
		},
		-- extensions = {
		-- 	mcphub = {
		-- 		callback = "mcphub.extensions.codecompanion",
		-- 		opts = {
		-- 			make_vars = true,
		-- 			make_slash_commands = true,
		-- 			show_result_in_chat = true,
		-- 		},
		-- 	},
		-- },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- "ravitemer/mcphub.nvim",
	},
}
