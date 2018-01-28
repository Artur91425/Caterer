local L = AceLibrary('AceLocale-2.2'):new('Caterer')
local BC = AceLibrary('Babble-Class-2.2')
local Dewdrop = AceLibrary('Dewdrop-2.0')

local classes = {'Druid', 'Hunter', 'Paladin', 'Priest', 'Rogue', 'Shaman', 'Warlock', 'Warrior'}
local trades = {
	friends = 'Friends',
	group = 'Group/Raid members',
	guild = 'Guild members',
	other = 'Other players'
}
local i = 0

Caterer.options = {
	type = 'group',
	args = {
		filter = {
			order = 3,
			type = 'group',
			name = L["Filter"],
			desc = L["Filter options."],
			args = {
				quantity = {
					order = 1,
					type = 'group',
					name = L["Quantity"],
					desc = L["Quantity options."],
					args = {
						space1 = {
							order = 200,
							type = 'header',
							name = ' ',
						},
						tooltip = {
							order = 201,
							type = 'toggle',
							name = L["Add to tooltip"],
							desc = L["Adds the current settings to the tooltip."],
							get = function() return Caterer.db.profile.tooltip.classes end,
							set = function(v)
								Caterer.db.profile.tooltip.classes = v
								Caterer:TriggerEvent('Caterer_CLASS_UPDATE')
							end,
						}
					}
				},
				trade = {
					order = 2,
					type = 'group',
					name = L["Trade"],
					desc = L["Trade options."],
					args = {}
				},
				list = {
					order = 3,
					type = 'group',
					name = L["List of exceptions"],
					desc = L["Exception list options."],
					args = {
						add = {
							order = 1,
							type = 'text',
							name = L["Add/Edit"],
							desc = string.format(L["Add/Edit a player to the exclusion list.\n\nUsage: <%s> <%s> <%s>"], L["player name"], L["amount of food"], L["amount of water"]),
							usage = '<'..L["player name"]..'> <'..L["amount of food"]..'> <'..L["amount of water"]..'>',
							get = false,
							set = 'AddPlayer',
						},
						remove = {
							order = 2,
							type = 'text',
							name = L["Remove"],
							desc = string.format(L["Remove a player from the exclusion list.\n\nUsage: <%s>"], L["player name"]),
							usage = '<'..L["player name"]..'>',
							get = false,
							set = 'RemovePlayer',
						},
						print = {
							order = 3,
							type = 'execute',
							name = L["Print"],
							desc = L["Printing an exclusion list."],
							func = 'PrintList',
						},
						space2 = {
							order = 4,
							type = 'header',
							name = ' ',
						},
						clear = {
							order = 5,
							type = 'execute',
							name = L["Clear"],
							desc = L["Completely clears the entire list."],
							func = function()
								Dewdrop:Close(1) -- hide, so as not to interfere
								StaticPopup_Show('CATERER_CONFIRM_CLEAR')
							end,
						},
						tooltip = {
							order = 6,
							type = 'toggle',
							name = L["Add to tooltip"],
							desc = L["Adds the list of exceptions to the tooltip."],
							get = function() return Caterer.db.profile.tooltip.exceptionList end,
							set = function(v)
								Caterer.db.profile.tooltip.exceptionList = v
								Caterer:TriggerEvent('Caterer_LIST_UPDATE')
							end,
						}
					}
				}
			}
		},
		requests = {
			order = 4,
			type = 'toggle',
			name = L["Whisper requests"],
			desc = L["Toggle whisper requests."],
			get = function() return Caterer.db.profile.whisperRequest end,
			set = function(v) Caterer.db.profile.whisperRequest = v end,
		},
		resetdb = {
			order = 5,
			type = 'execute',
			name = L["Reset"],
			desc = L["Reset all settings."],
			func = function()
				Dewdrop:Close(1) -- Close Dewdrop menu (this needs for update settings on Dewdrop menu)
				StaticPopup_Show('CATERER_CONFIRM_RESET')
			end,
		}
	}
}

for k, trade_name in pairs(trades) do
	local trade = k
	i = i + 1
	Caterer.options.args.filter.args.trade.args[trade] = {
		order = i,
		type = 'toggle',
		name = L[trade_name],
		desc = L[string.format("Toggle trade with %s.", string.lower(trade_name))],
		get = function() return Caterer.db.profile.tradeFilter[trade] end,
		set = function(v) Caterer.db.profile.tradeFilter[trade] = v end,
	}
end

for k, class in pairs(classes) do
	Caterer.options.args.filter.args.quantity.args[string.lower(class)] = {
		order = k,
		type = 'group',
		name = BC[class],
		desc = L["Set items quantity."],
		args = {}
	}
end

for i = 1, 2 do -- 1 - food, 2 - water
    local name
    local itemType = i
    if i == 1 then name = 'Food' else name = 'Water' end
    Caterer.options.args[string.lower(name)] = {
		order = itemType,
		type = 'text',
		name = L[name],
		desc = L[string.format("Set %s for trades.", string.lower(name))],
		get = function() return Caterer.db.profile.tradeWhat[itemType] end,
		set = function(v)
			Caterer.db.profile.tradeWhat[itemType] = v
			Caterer:TriggerEvent('Caterer_ITEMS_UPDATE')
		end,
		validate = Caterer.itemTable[itemType]
	}
	for _, v in pairs(classes) do
		local class = v
		if class ~= 'Rogue' and class ~= 'Warrior' or i ~= 2 then
			Caterer.options.args.filter.args.quantity.args[string.lower(class)].args[string.lower(name)] = {
				order = itemType,
				type = 'text',
				name = L[name],
				desc = L[string.format("Set quantity for %s.", string.lower(name))],
				get = function() return Caterer.db.profile.tradeCount[string.upper(class)][itemType] end,
				set = function(v)
					Caterer.db.profile.tradeCount[string.upper(class)][itemType] = v
					Caterer:TriggerEvent('Caterer_CLASS_UPDATE')
				end,
				validate = {'0', '20', '40', '60'}
			}
		end
	end
end

StaticPopupDialogs['CATERER_CONFIRM_CLEAR'] = {
	text = L["Do you really want to clear list of exceptions?"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		Caterer.db.profile.exceptionList = {}
		Caterer:TriggerEvent('Caterer_LIST_UPDATE')
		Caterer:Print(L["The list has been successfully cleared."])
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = false,
	preferredIndex = 3
}

StaticPopupDialogs['CATERER_CONFIRM_RESET'] = {
	text = L["Do you really want to reset the settings to their default values?"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		Caterer:ResetDB('profile')
		Caterer:TriggerEvent('Caterer_RESETDB')
		Caterer:Print(L["All settings are reset to default value."])
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = false,
	preferredIndex = 3
}

function Caterer:AddPlayer(str)
	local _, _, name, food, water = string.find(str, '(%a+) (%d+) (%d+)')
	if not (name or food or water) or math.mod(food, 20) ~= 0 or math.mod(water, 20) ~= 0 then
		return self:Print(string.format(L["Expected string: '<%s> <%s> <%s>'. Note: the number must be a multiple of 20."], L["player name"], L["amount of food"], L["amount of water"]))
	elseif food + water > 120 then
		return self:Print(L["The total number of items should not exceed 120."])
	elseif food + water == 0 then
		return self:Print(L["The quantity for both items can not be zero."])
	end
	
	local type
	if self.db.profile.exceptionList[name] then
		type = '|cffDAA520'..L["edited"]..'|r'
	else
		type = '|cff00FF00'..L["added"]..'|r'
	end
	self.db.profile.exceptionList[name] = {}
	table.insert(self.db.profile.exceptionList[name], food)
	table.insert(self.db.profile.exceptionList[name], water)
	self:Print(string.format(L["%s was successfully %s."], L["Player"]..' <|cffbfffff'..name..'|r> ', type))
	self:TriggerEvent('Caterer_LIST_UPDATE')
end

function Caterer:RemovePlayer(name)
	if not self.db.profile.exceptionList[name] then
		return self:Print(L["This player is not listed."])
	end
	
	self.db.profile.exceptionList[name] = nil
	self:Print(string.format(L["%s was successfully %s."], L["Player"]..' <|cffbfffff'..name..'|r> ', '|cffFF0000'..L["removed"]..'|r'))
end

function Caterer:PrintList()
	if not next(self.db.profile.exceptionList) then
		return self:Print(L["The list is empty."])
	end
	
	self:Print(L["List of exceptions"]..':')
	ChatFrame1:AddMessage(string.format('[|cffbfffff%s|r] = {%s, %s}', L["player name"], L["Food"], L["Water"]))
	for k, v in pairs(self.db.profile.exceptionList) do
		ChatFrame1:AddMessage('[|cffbfffff'..k..'|r] = {'..v[1]..', '..v[2]..'}')
	end
end