local M = {}
local maximized = ya.sync(function() return rt.mgr.ratio[3] == 9999 end)

function M:peek(job)
	if not maximized() then return require("image"):peek(job) end
	-- Separate from the original image cache; originals are never modified.
	local cache = ya.file_cache { file = job.file, skip = 20000 }
	if not cache then return require("image"):peek(job) end
	local cha = fs.cha(cache)
	if not cha or cha.len == 0 then
		local output, spawn_err = Command("magick")
			:stderr(Command.PIPED)
			:arg { tostring(job.file.path) .. "[0]", "-auto-orient", "-resize",
				string.format("%dx%d", rt.preview.max_width, rt.preview.max_height), "png:" .. tostring(cache) }
			:output()
		if not output or not output.status.success then
			return ya.preview_widget(job, Err("Enlarged preview failed: %s", output and output.stderr or tostring(spawn_err)))
		end
	end
	local _, err = ya.image_show(cache, job.area)
	ya.preview_widget(job, err)
end

function M:seek() end

return M
