Hooks:PostHook(AchievementDetailGui, "init", "MyAchinit", function(self, parent, achievement_data_or_id, back_callback)
	local placer = self:placer()
	local medium_font = tweak_data.menu.pd2_medium_font
	local medium_font_size = tweak_data.menu.pd2_medium_font_size
	
	if not self._info.awarded then
		-- Add unlock button
		placer:add_bottom_ralign(TextButton:new(self, {
			input = true,
			text = "UNLOCK",
			font = medium_font,
			font_size = medium_font_size
		}, function ()
			--log("Identifier: " .. tostring(self._info.id))
			
			if not self._info.awarded then
				managers.achievment:award(self._info.id)
			end

			self._back_callback()
		end))
	end
end)
