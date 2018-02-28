--[[---------------------------------------------------------------------------------
	Locals
------------------------------------------------------------------------------------]]

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

--[[---------------------------------------------------------------------------------
	Options table
------------------------------------------------------------------------------------]]

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
								Caterer:TriggerEvent('Caterer_OPTIONS_UPDATE')
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
				exceptionlist = {
					order = 3,
					type = 'group',
					name = L["List of exceptions"],
					desc = L["Exception list options."],
					args = {
						add = {
							order = 1,
							type = 'text',
							name = L["Add"]..'/'..L["Edit"],
							desc = string.format(L["%s a player."]..'\n\n'..L["Usage"]..': <%s> <%s> <%s>', L["Add"]..'/'..L["Edit"], L["player name"], L["amount of food"], L["amount of water"]),
							usage = '<'..L["player name"]..'> <'..L["amount of food"]..'> <'..L["amount of water"]..'>',
							get = false,
							set = function(str, list) Caterer:AddPlayer(str, 'exceptionList') end,
						},
						remove = {
							order = 2,
							type = 'text',
							name = L["Remove"],
							desc = string.format(L["Remove a player from the list."]..'\n\n'..L["Usage"]..': <%s>', L["player name"]),
							usage = '<'..L["player name"]..'>',
							get = false,
							set = function(name, list) Caterer:RemovePlayer(name, 'exceptionList') end,
						},
						print = {
							order = 3,
							type = 'execute',
							name = L["Print"],
							desc = L["Printing a list."],
							func = function(list) Caterer:PrintList('exceptionList') end,
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
								if next(Caterer.db.profile.exceptionList) then
									Dewdrop:Close(1) -- hide, so as not to interfere
									Caterer:ClearList('exceptionList')
								else
									Caterer:Print(L["Nothing to clean."]..' '..L["The list is empty."])
								end
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
				},
				blacklist = {
					order = 4,
					type = 'group',
					name = L["Blacklist"],
					desc = L["Blacklist options."],
					args = {
						add = {
							order = 1,
							type = 'text',
							name = L["Add"],
							desc = string.format(L["%s a player."]..'\n\n'..L["Usage"]..': <%s>', L["Add"], L["player name"]),
							usage = '<'..L["player name"]..'>',
							get = false,
							set = function(str) Caterer:AddPlayer(str, 'blackList') end,
						},
						remove = {
							order = 2,
							type = 'text',
							name = L["Remove"],
							desc = string.format(L["Remove a player from the list."]..'\n\n'..L["Usage"]..': <%s>', L["player name"]),
							usage = '<'..L["player name"]..'>',
							get = false,
							set = function(name) Caterer:RemovePlayer(name, 'blackList') end,
						},
						print = {
							order = 3,
							type = 'execute',
							name = L["Print"],
							desc = L["Printing a list."],
							func = function() Caterer:PrintList('blackList') end,
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
								if Caterer.db.profile.blackList[1] then
									Dewdrop:Close(1) -- hide, so as not to interfere
									Caterer:ClearList('blackList')
								else
									Caterer:Print(L["Nothing to clean."]..' '..L["The list is empty."])
								end
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
			set = function(v)
				Caterer.db.profile.whisperRequest = v
				Caterer:TriggerEvent('Caterer_OPTIONS_UPDATE')
			end,
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
		set = function(v)
			Caterer.db.profile.tradeFilter[trade] = v
			Caterer:TriggerEvent('Caterer_OPTIONS_UPDATE')
		end,
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

for i in pairs(Caterer.itemTable) do -- 1 - food, 2 - water
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
					Caterer:TriggerEvent('Caterer_OPTIONS_UPDATE')
				end,
				validate = {'0', '20', '40', '60'}
			}
		end
	end
end

--[[--------------------------------------------------------------------------------
	Shared Functions
-----------------------------------------------------------------------------------]]

function Caterer:AddPlayer(str, list)
	if list == 'exceptionList' then
		local _, _, name, food, water = string.find(str, '(%a+) (%d+) (%d+)')
		if not (name and food and water) or math.mod(food, 20) ~= 0 or math.mod(water, 20) ~= 0 then
			return self:Print(string.format(L["Expected string: '<%s> <%s> <%s>'. Note: the number must be a multiple of 20."], L["player name"], L["amount of food"], L["amount of water"]))
		elseif food + water > 120 then
			return self:Print(L["The total number of items should not exceed 120."])
		elseif food + water == 0 then
			return self:Print(L["The quantity for both items can not be zero."]..' '..L["If you want to ignore this player, then add it to the blacklist."])
		end
		
		local type
		if self.db.profile[list][string.lower(name)] then
			type = '|cffDAA520'..L["edited"]..'|r'
		else
			type = '|cff00FF00'..L["added"]..'|r'
		end
		self.db.profile[list][string.lower(name)] = {}
		table.insert(self.db.profile[list][string.lower(name)], food)
		table.insert(self.db.profile[list][string.lower(name)], water)
		self:Print(string.format(L["%s was successfully %s."], L["Player"]..' <|cffbfffff'..self:FirstToUpper(name)..'|r> ', type))
		self:TriggerEvent('Caterer_LIST_UPDATE')
	elseif list == 'blackList' then
		local _, _, name = string.find(str, '(%a+)')
		if not name then
			return self:Print(string.format(L["The name of the player is expected."]))
		end
		table.insert(self.db.profile[list], string.lower(name))
		self:Print(string.format(L["%s was successfully %s."], L["Player"]..' <|cffCD5C5C'..self:FirstToUpper(name)..'|r> ', '|cff00FF00'..L["added"]..'|r'))
	end
end

function Caterer:RemovePlayer(str, list)
	local _, _, name = string.find(str, '(%a+)')
	if not name then
		return self:Print(string.format(L["The name of the player is expected."]))
	elseif not self.db.profile[list][string.lower(name)] then
		return self:Print(L["This player is not listed."])
	end
	
	self.db.profile[list][string.lower(name)] = nil
	self:Print(string.format(L["%s was successfully %s."], L["Player"]..' <|cffbfffff'..self:FirstToUpper(name)..'|r> ', '|cffFF0000'..L["removed"]..'|r'))
end

function Caterer:PrintList(list)
	if not next(self.db.profile[list]) then
		return self:Print(L["The list is empty."])
	end
	
	if list == 'exceptionList' then
		self:Print(L["List of exceptions"]..':')
		ChatFrame1:AddMessage(string.format('[|cffbfffff%s|r] = {%s, %s}', L["player name"], L["Food"], L["Water"]))
		for name, count in pairs(self.db.profile[list]) do
			ChatFrame1:AddMessage('[|cffbfffff'..self:FirstToUpper(name)..'|r] = {'..count[1]..', '..count[2]..'}')
		end
	elseif list == 'blackList' then
		self:Print(L["Blacklist"]..':')
		for _, name in pairs(self.db.profile[list]) do
			ChatFrame1:AddMessage('|cffCD5C5C'..self:FirstToUpper(name))
		end
	end
end

function Caterer:ClearList(list)
	StaticPopup_Show('CATERER_CONFIRM_CLEAR')
	StaticPopupDialogs['CATERER_CONFIRM_CLEAR'] = {
		text = L["Do you really want to clear this list?"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			self.db.profile[list] = {}
			if list == 'exceptionList' then self:TriggerEvent('Caterer_LIST_UPDATE') end
			self:Print(L["The list has been successfully cleared."])
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = false,
		preferredIndex = 3
	}
end

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