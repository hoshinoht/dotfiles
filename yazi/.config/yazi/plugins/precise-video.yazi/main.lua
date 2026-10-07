-- Fractional seeking for short recordings. Decode intervening frames too.
local M = {}

function M:seek(job)
	local h = cx.active.current.hovered
	if h and h.url == job.file.url then
		ya.emit("peek", { math.max(0, math.min(90, cx.active.preview.skip + job.units)), only_if = h.url })
	end
end

function M:peek(job)
	local cache = ya.file_cache { file = job.file, skip = 10000 + job.skip }
	if not cache then return end
	local cha = fs.cha(cache)
	if not cha or cha.len == 0 then
		local meta, err = require("video").list_meta(job.file.path, "format=duration")
		local duration = meta and tonumber(meta.format.duration)
		if not duration or duration <= 0 then
			return ya.preview_widget(job, err or Err("Video duration unavailable"))
		end
		local output, spawn_err = Command("ffmpeg")
			:stderr(Command.PIPED)
			:arg { "-v", "error", "-threads", "1", "-ss", string.format("%.6f", duration * (5 + math.min(90, job.skip)) / 100),
				"-i", tostring(job.file.path), "-map", "0:v:0", "-an", "-sn", "-dn", "-frames:v", "1",
				"-vf", string.format("scale=%d:%d:force_original_aspect_ratio=decrease", rt.preview.max_width, rt.preview.max_height),
				"-f", "image2", "-c:v", "mjpeg", "-q:v", "2", "-y", tostring(cache) }
			:output()
		if not output or not output.status.success then
			return ya.preview_widget(job, Err("Video preview failed: %s", output and output.stderr or tostring(spawn_err)))
		end
	end
	local _, err = ya.image_show(cache, job.area)
	ya.preview_widget(job, err)
end

return M
