vim.keymap.set("n", "<leader>pa", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file: ", path)
end)

-- has lag for some reason
-- vim.api.nvim_create_autocmd("TextYankPost", {
-- 	callback = function()
-- 		vim.hl.on_yank()
-- 	end,
-- })

vim.api.nvim_create_augroup("TypstCompileOnType", { clear = true })

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
	group = "TypstCompileOnType",
	pattern = "*.typ",
	callback = function()
		local filepath = vim.fn.expand("%:p")
		local pdf_path = filepath:gsub("%.typ$", ".pdf")

		local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
		local buffer_content = table.concat(lines, "\n")

		local file_dir = vim.fn.expand("%:p:h")

		vim.system({
			"typst",
			"compile",
			"--root",
			file_dir,
			"-",
			pdf_path,
		}, {
			stdin = buffer_content,
		})
	end,
})
