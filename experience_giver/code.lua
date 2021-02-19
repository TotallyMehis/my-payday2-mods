local my_menu_id = "MyExperienceMenu"

local experience_to_give = 0
local coins_to_give = 0


local function give_experience(xp)
	log(string.format("Giving experience: %d", xp))
	
	-- We need to pass true, or this will be ignored.
	managers.experience:give_experience(xp, true)
end

local function give_coins(amount)
	local new_total = managers.custom_safehouse:total_coins_earned() + amount
	local new_current = managers.custom_safehouse:coins() + amount
	Global.custom_safehouse_manager.total = Application:digest_value(new_current, true)
	Global.custom_safehouse_manager.total_collected = Application:digest_value(new_total, true)
end


Hooks:AddHook("LocalizationManagerPostInit", "ExpLocalizationManagerPostInit", function(self)
	self:add_localized_strings({
		["loc_expmenu_menu"] = "Experience Giver",
		["loc_expmenu_desc"] = "Supa secret menu",
		["loc_expmenu_coinsliderdesc"] = "Coins to give you.",
		["loc_expmenu_expsliderdesc"] = "Experience to give you times a million."
	})
end)

Hooks:AddHook("MenuManagerSetupCustomMenus", "ExpMenuManagerSetupCustomMenus", function(self, nodes)
	MenuHelper:NewMenu(my_menu_id)
end)

Hooks:AddHook("MenuManagerBuildCustomMenus", "ExpMenuManagerBuildCustomMenus", function(self, nodes)
	nodes[my_menu_id] = MenuHelper:BuildMenu(my_menu_id)
	MenuHelper:AddMenuItem(nodes["blt_options"], my_menu_id, "loc_expmenu_menu", "loc_expmenu_desc")
end)

Hooks:AddHook("MenuManagerPopulateCustomMenus", "ExpMenuManagerPopulateCustomMenus", function(self, nodes)
	MenuCallbackHandler.ExpGive = function(self)
		give_experience(experience_to_give)
	end
	
	MenuCallbackHandler.ExpGiveSlider = function(self, item)
		experience_to_give = item:value() * 1000000
	end
	
	
	MenuCallbackHandler.ContGive = function(self)
		give_coins(coins_to_give)
	end
	
	MenuCallbackHandler.ContGiveSlider = function(self, item)
		coins_to_give = item:value()
	end
	

	

	MenuHelper:AddButton({
		id			= "ContGiveButton",
		title		= "Give continental coins",
		desc		= "Gives you the slider amount of continental coins!",
		callback	= "ContGive",
		menu_id		= my_menu_id,
		localized	= false
	})
	
	MenuHelper:AddSlider({
		id = "ContGiveSlider",
		title = "Coins",
		desc = "loc_expmenu_coinsliderdesc",
		callback = "ContGiveSlider",
		value = coins_to_give,
		min = 0,
		max = 100,
		step = 1,
		show_value = true,
		menu_id = my_menu_id,
		localized = false
	})
	
	
	MenuHelper:AddDivider({
		id = "ContDiv",
		size = 16,
		menu_id = my_menu_id
	})
	
	
	MenuHelper:AddSlider({
		id = "ExpGiveSlider",
		title = "Experience (M)",
		desc = "loc_expmenu_expsliderdesc",
		callback = "ExpGiveSlider",
		value = experience_to_give / 1000000,
		min = 0,
		max = 24,
		step = 0.2,
		show_value = true,
		menu_id = my_menu_id,
		localized = false
	})
	
	MenuHelper:AddButton({
		id			= "ExpGiveButton",
		title		= "Give experience",
		desc		= "Gives you the slider amount of experience!",
		callback	= "ExpGive",
		menu_id		= my_menu_id,
		localized	= false
	})
end)
