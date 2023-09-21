local unlock_app_ids = {
	1347750, -- Breakfast in Tijuana Heist
	1252200, -- San Martin Bank Heist
	1184411, -- Border Crossing Heist
	1449450, -- Buluc's Mansion Heist
	1555040, -- Dragon Pack
	1654480, -- The Ukrainian Prisoner Heist
	1778790, -- Black Cat Heist
	1906240, -- Mountain Master Heist
	1945681, -- Midland Ranch Heist
	2074240, -- Lost in Transit Heist
	2215010, -- Hostile Takeover Heist
	2353512, -- Crude Awakening Heist
}

local function unlock_dlc(dlc_data)
	if dlc_data.app_id == nil then
		return false
	end
	local dlc_app_id = tonumber(dlc_data.app_id)
	for index, app_id in pairs(unlock_app_ids) do
		if dlc_app_id == app_id then
			log(string.format("Unlocking %d", app_id))
			return true
		end
	end

	return false
end

local _win_check_dlc_data = WINDLCManager._check_dlc_data
function WINDLCManager:_check_dlc_data(dlc_data)
	if unlock_dlc(dlc_data) then
		return true
	else
		return _win_check_dlc_data(self, dlc_data)
	end
end

local _steam_check_dlc_data = WinSteamDLCManager._check_dlc_data
function WinSteamDLCManager:_check_dlc_data(dlc_data)
	if unlock_dlc(dlc_data) then
		return true
	else
		return _steam_check_dlc_data(self, dlc_data)
	end
end
