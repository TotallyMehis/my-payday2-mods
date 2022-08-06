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
}

local function print_dlcs(onlynonverified)
	local t = {}

	-- Collect the DLCs.
	for dlc_name, dlc_data in pairs(Global.dlc_manager.all_dlc_data) do
		local do_print = false
		
		if onlynonverified then
			if not dlc_data.verified then
				do_print = true
			end
		else
			do_print = true
		end
		
		-- Some DLC may not have an app id.
		if do_print and dlc_data.app_id then
			local num = tonumber(dlc_data.app_id)
		
			table.insert(t, { name = dlc_name, app_id = num })
		end
	end
	
	-- Sort by app id
	table.sort(t, function(i, j)
		return i.app_id > j.app_id
	end )
	

	log( "-----------------")
	if onlynonverified then
		log("Not owned DlCs: ")
	else
		log("All DLCs: ")
	end
	log("-----------------")
	
	for k, v in pairs(t) do
		log(string.format("%s | %d", v.name, v.app_id))
	end
	
	log("-----------------")
end

local function unlock_dlcs()
	for dlc_name, dlc_data in pairs(Global.dlc_manager.all_dlc_data) do
		if dlc_data.app_id then
			local num = tonumber(dlc_data.app_id)
			
			for k, app_id in pairs(unlock_app_ids) do
				if app_id == num then
					dlc_data.verified = true
					log(string.format("Unlocked %s (%d)", dlc_name, app_id))
				end
			end
		end
	end
end


Hooks:PostHook(WINDLCManager, "_verify_dlcs", "MyHookVerifyDLCs", function(self)
	if not Global or not Global.dlc_manager or not Global.dlc_manager.all_dlc_data then
		log("dlc_manager or dlc_manager.all_dlc_data does not exist!")
		return
	end
	
	unlock_dlcs()
	print_dlcs(true)
end)

