local L = AceLibrary("AceLocale-2.2"):new("Caterer")

L:RegisterTranslations("enUS", function() return {
	
	[" loaded."] = true,
	
	--Food
	["Conjured Cinnamon Roll"] = true,
	["Conjured Sweet Roll"] = true,
	--Water
	["Conjured Crystal Water"] = true,
	["Conjured Sparkling Water"] = true,
	
	--Classes
	["Warlock"] = true,
	["Warrior"] = true,
	["Priest"] = true,
	["Rogue"] = true,
	["Hunter"] = true,
	["Paladin"] = true,
	["Druid"] = true,
	
	--Options
	["Food"] = true,
	["Set food for trades."] = true,
	["Water"] = true,
	["Set water for trades."] = true,
	["Filter"] = true,
	["Filter options."] = true,
	["Quantity"] = true,
	["Quantity options."] = true,
	["Set items quantity."] = true,
	["Set quantity for food."] = true,
	["Set quantity for water."] = true,
	["Trade"] = true,
	["Trade options."] = true,
	["Friends"] = true,
	["Toggle trade with friends."] = true,
	["Group/Raid members"] = true,
	["Toggle trade with group/raid members."] = true,
	["Guild members"] = true,
	["Toggle trade with guild members."] = true,
	["Other"] = true,
	["Toggle trade with other players."] = true,
	["Whisper requests"] = true,
	["Toggle whisper requests."] = true,
	
	--Errors
	["Service is temporarily disabled."] = true,
	["Expected string: '#cat [amount of food] [amount of water]'. Note: the number must be a multiple of 20."] = true,
	["I can't complete the trade right now. I'm out of "] = true,
	["Trade is impossible, no "] = true, 	
	["food."] = true,
	["water."] = true,
		
} end)