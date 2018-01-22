local L = AceLibrary('AceLocale-2.2'):new('Caterer')
local BC = AceLibrary('Babble-Class-2.2')

Caterer.options = {
	type = 'group',
	args = {
		food = {
			order = 1,
			type = 'text',
			name = L["Food"],
			desc = L["Set food for trades."],
			get = function() return Caterer.db.profile.tradeWhat[1] end,
			set = function(v) Caterer.db.profile.tradeWhat[1] = v end,
			validate = {['22895'] = L["Conjured Cinnamon Roll"], ['8076'] = L["Conjured Sweet Roll"]}
		},
		water = {
			order = 2,
			type = 'text',
			name = L["Water"],
			desc = L["Set water for trades."],
			get = function() return Caterer.db.profile.tradeWhat[2] end,
			set = function(v) Caterer.db.profile.tradeWhat[2] = v end,
			validate = {['8079'] = L["Conjured Crystal Water"], ['8078'] = L["Conjured Sparkling Water"]}
		},
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
						druid = {
							type = 'group',
							name = BC["Druid"],
							desc = L["Set items quantity."],
							args = { 
								food = {
									order = 1,
									type = 'text',
									name = L["Food"],
									desc = L["Set quantity for food."],
									get = function() return Caterer.db.profile.tradeCount.DRUID[1] end,
									set = function(v) Caterer.db.profile.tradeCount.DRUID[1] = v end,
									validate = {'0', '20', '40', '60'}
								},
								water = {
									order = 2,
									type = 'text',
									name = L["Water"],
									desc = L["Set quantity for water."],
									get = function() return Caterer.db.profile.tradeCount.DRUID[2] end,
									set = function(v) Caterer.db.profile.tradeCount.DRUID[2] = v end,
									validate = {'0', '20', '40', '60'}
								}
							}
						},
						hunter = {
							type = 'group',
							name = BC["Hunter"],
							desc = L["Set items quantity."],
							args = { 
								food = {
									order = 1,
									type = 'text',
									name = L["Food"],
									desc = L["Set quantity for food."],
									get = function() return Caterer.db.profile.tradeCount.HUNTER[1] end,
									set = function(v) Caterer.db.profile.tradeCount.HUNTER[1] = v end,
									validate = {'0', '20', '40', '60'}
								},
								water = {
									order = 2,
									type = 'text',
									name = L["Water"],
									desc = L["Set quantity for water."],
									get = function() return Caterer.db.profile.tradeCount.HUNTER[2] end,
									set = function(v) Caterer.db.profile.tradeCount.HUNTER[2] = v end,
									validate = {'0', '20', '40', '60'}
								}
							}
						},
						paladin = {
							type = 'group',
							name = BC["Paladin"],
							desc = L["Set items quantity."],
							args = { 
								food = {
									order = 1,
									type = 'text',
									name = L["Food"],
									desc = L["Set quantity for food."],
									get = function() return Caterer.db.profile.tradeCount.PALADIN[1] end,
									set = function(v) Caterer.db.profile.tradeCount.PALADIN[1] = v end,
									validate = {'0', '20', '40', '60'}
								},
								water = {
									order = 2,
									type = 'text',
									name = L["Water"],
									desc = L["Set quantity for water."],
									get = function() return Caterer.db.profile.tradeCount.PALADIN[2] end,
									set = function(v) Caterer.db.profile.tradeCount.PALADIN[2] = v end,
									validate = {'0', '20', '40', '60'}
								}
							}
						},
						priest = {
							type = 'group',
							name = BC["Priest"],
							desc = L["Set items quantity."],
							args = { 
								food = {
									order = 1,
									type = 'text',
									name = L["Food"],
									desc = L["Set quantity for food."],
									get = function() return Caterer.db.profile.tradeCount.PRIEST[1] end,
									set = function(v) Caterer.db.profile.tradeCount.PRIEST[1] = v end,
									validate = {'0', '20', '40', '60'}
								},
								water = {
									order = 2,
									type = 'text',
									name = L["Water"],
									desc = L["Set quantity for water."],
									get = function() return Caterer.db.profile.tradeCount.PRIEST[2] end,
									set = function(v) Caterer.db.profile.tradeCount.PRIEST[2] = v end,
									validate = {'0', '20', '40', '60'}
								}
							}
						},
						rogue = {
							type = 'group',
							name = BC["Rogue"],
							desc = L["Set items quantity."],
							args = { 
								food = {
									order = 1,
									type = 'text',
									name = L["Food"],
									desc = L["Set quantity for food."],
									get = function() return Caterer.db.profile.tradeCount.ROGUE[1] end,
									set = function(v) Caterer.db.profile.tradeCount.ROGUE[1] = v end,
									validate = {'0', '20', '40', '60'}
								}
							}
						},
						shaman = {
							type = 'group',
							name = BC["Shaman"],
							desc = L["Set items quantity."],
							args = { 
								food = {
									order = 1,
									type = 'text',
									name = L["Food"],
									desc = L["Set quantity for food."],
									get = function() return Caterer.db.profile.tradeCount.SHAMAN[1] end,
									set = function(v) Caterer.db.profile.tradeCount.SHAMAN[1] = v end,
									validate = {'0', '20', '40', '60'}
								},
								water = {
									order = 2,
									type = 'text',
									name = L["Water"],
									desc = L["Set quantity for water."],
									get = function() return Caterer.db.profile.tradeCount.SHAMAN[2] end,
									set = function(v) Caterer.db.profile.tradeCount.SHAMAN[2] = v end,
									validate = {'0', '20', '40', '60'}
								}
							}
						},
						warlock = {
							type = 'group',
							name = BC["Warlock"],
							desc = L["Set items quantity."],
							args = { 
								food = {
									order = 1,
									type = 'text',
									name = L["Food"],
									desc = L["Set quantity for food."],
									get = function() return Caterer.db.profile.tradeCount.WARLOCK[1] end,
									set = function(v) Caterer.db.profile.tradeCount.WARLOCK[1] = v end,
									validate = {'0', '20', '40', '60'}
								},
								water = {
									order = 2,
									type = 'text',
									name = L["Water"],
									desc = L["Set quantity for water."],
									get = function() return Caterer.db.profile.tradeCount.WARLOCK[2] end,
									set = function(v) Caterer.db.profile.tradeCount.WARLOCK[2] = v end,
									validate = {'0', '20', '40', '60'}
								}
							}
						},
						warrior = {
							type = 'group',
							name = BC["Warrior"],
							desc = L["Set items quantity."],
							args = { 
								food = {
									order = 1,
									type = 'text',
									name = L["Food"],
									desc = L["Set quantity for food."],
									get = function() return Caterer.db.profile.tradeCount.WARRIOR[1] end,
									set = function(v) Caterer.db.profile.tradeCount.WARRIOR[1] = v end,
									validate = {'0', '20', '40', '60'}
								}
							}
						},
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
							set = function(v) Caterer.db.profile.tooltip.classes = v end,
						}
					}
				},	
				trade = {
					order = 2,
					type = 'group',
					name = L["Trade"],
					desc = L["Trade options."],
					args = {
						friends = {
							order = 1,
							type = 'toggle',
							name = L["Friends"],
							desc = L["Toggle trade with friends."],
							get = function() return Caterer.db.profile.tradeFilter.friends end,
							set = function(v) Caterer.db.profile.tradeFilter.friends = v end,
						},
						group = {
							order = 2,
							type = 'toggle',
							name = L["Group/Raid members"],
							desc = L["Toggle trade with group/raid members."],
							get = function() return Caterer.db.profile.tradeFilter.group end,
							set = function(v) Caterer.db.profile.tradeFilter.group = v end,
						},
						guild = {
							order = 3,
							type = 'toggle',
							name = L["Guild members"],
							desc = L["Toggle trade with guild members."],
							get = function() return Caterer.db.profile.tradeFilter.guild end,
							set = function(v) Caterer.db.profile.tradeFilter.guild = v end,
						},
						other = {
							order = 4,
							type = 'toggle',
							name = L["Other"],
							desc = L["Toggle trade with other players."],
							get = function() return Caterer.db.profile.tradeFilter.other end,
							set = function(v) Caterer.db.profile.tradeFilter.other = v end,
						}
					}
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
							set = function(str) Caterer:AddPlayer(str) end,
						},
						remove = {
							order = 2,
							type = 'text',
							name = L["Remove"],
							desc = string.format(L["Remove a player from the exclusion list.\n\nUsage: <%s>"], L["player name"]),
							usage = '<'..L["player name"]..'>',
							get = false,
							set = function(name) Caterer:RemovePlayer(name) end,
						},
						print = {
							order = 3,
							type = 'execute',
							name = L["Print"],
							desc = L["Printing an exclusion list."],
							func = function() Caterer:PrintList() end,
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
								Dewdrop20Level3:Hide() -- hide, so as not to interfere
								StaticPopup_Show('CATERER_CONFIRM_CLEAR')
							end,
						},
						tooltip = {
							order = 6,
							type = 'toggle',
							name = L["Add to tooltip"],
							desc = L["Adds the list of exceptions to the tooltip."],
							get = function() return Caterer.db.profile.tooltip.exceptionList end,
							set = function(v) Caterer.db.profile.tooltip.exceptionList = v end,
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
			func = function() StaticPopup_Show('CATERER_CONFIRM_RESET') end,
		}
	}
}

StaticPopupDialogs['CATERER_CONFIRM_CLEAR'] = {
	text = L["Do you really want to clear list of exceptions?"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		Caterer.db.profile.exceptionList = {}
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
		Dewdrop20Level1:Hide() -- Hide Dewdrop menu (this needs for update settings on Dewdrop menu)
		Caterer:ResetDB('profile')
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