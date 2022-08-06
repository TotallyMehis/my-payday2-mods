-- Go to lib/tweak_data/weapontweakdata.lua
-- Hook to *_crew methods.
Hooks:PostHook(WeaponTweakData, "_init_data_m249_crew", "My_init_data_m249_crew", function(self)
	log("Modifying crew weapon data!")
	log("Damage was: " .. tostring(self.m249_crew.DAMAGE))
end)
