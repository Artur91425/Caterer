local L = AceLibrary("AceLocale-2.2"):new("Caterer")
local opts = {}

function Caterer:RegisterOptions()
	opts = {
		type = 'group',
		args = {
			food = {
				order = 2,
				type = 'text',
				name = L["Food"],
				desc = L["Set food for trades."],
				get = function() return self.db.profile.tradeWhat[1] end,
				set = function(v) self.db.profile.tradeWhat[1] = v end,
				validate = {['22895'] = L["Conjured Cinnamon Roll"], ['8076'] = L["Conjured Sweet Roll"]},
			},
			water = {
				order = 3,
				type = 'text',
				name = L["Water"],
				desc = L["Set water for trades."],
				get = function() return self.db.profile.tradeWhat[2] end,
				set = function(v) self.db.profile.tradeWhat[2] = v end,
				validate = {['8079'] = L["Conjured Crystal Water"], ['8078'] = L["Conjured Sparkling Water"]},
			},
			filter = {
				order = 4,
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
								name = L["Druid"],
								desc = L["Set items quantity."],
								args = { 
									food = {
										order = 1,
										type = 'text',
										name = L["Food"],
										desc = L["Set quantity for food."],
										get = function() return self.db.profile.tradeCount.DRUID[1] end,
										set = function(v) self.db.profile.tradeCount.DRUID[1] = v end,
										validate = {'0', '20', '40', '60'},
									},
									water = {
										order = 2,
										type = 'text',
										name = L["Water"],
										desc = L["Set quantity for water."],
										get = function() return self.db.profile.tradeCount.DRUID[2] end,
										set = function(v) self.db.profile.tradeCount.DRUID[2] = v end,
										validate = {'0', '20', '40', '60'},
									},
								},
							},
							hunter = {
								type = 'group',
								name = L["Hunter"],
								desc = L["Set items quantity."],
								args = { 
									food = {
										order = 1,
										type = 'text',
										name = L["Food"],
										desc = L["Set quantity for food."],
										get = function() return self.db.profile.tradeCount.HUNTER[1] end,
										set = function(v) self.db.profile.tradeCount.HUNTER[1] = v end,
										validate = {'0', '20', '40', '60'},
									},
									water = {
										order = 2,
										type = 'text',
										name = L["Water"],
										desc = L["Set quantity for water."],
										get = function() return self.db.profile.tradeCount.HUNTER[2] end,
										set = function(v) self.db.profile.tradeCount.HUNTER[2] = v end,
										validate = {'0', '20', '40', '60'},
									},
								},
							},
							paladin = {
								type = 'group',
								name = L["Paladin"],
								desc = L["Set items quantity."],
								args = { 
									food = {
										order = 1,
										type = 'text',
										name = L["Food"],
										desc = L["Set quantity for food."],
										get = function() return self.db.profile.tradeCount.PALADIN[1] end,
										set = function(v) self.db.profile.tradeCount.PALADIN[1] = v end,
										validate = {'0', '20', '40', '60'},
									},
									water = {
										order = 2,
										type = 'text',
										name = L["Water"],
										desc = L["Set quantity for water."],
										get = function() return self.db.profile.tradeCount.PALADIN[2] end,
										set = function(v) self.db.profile.tradeCount.PALADIN[2] = v end,
										validate = {'0', '20', '40', '60'},
									},
								},
							},
							priest = {
								type = 'group',
								name = L["Priest"],
								desc = L["Set items quantity."],
								args = { 
									food = {
										order = 1,
										type = 'text',
										name = L["Food"],
										desc = L["Set quantity for food."],
										get = function() return self.db.profile.tradeCount.PRIEST[1] end,
										set = function(v) self.db.profile.tradeCount.PRIEST[1] = v end,
										validate = {'0', '20', '40', '60'},
									},
									water = {
										order = 2,
										type = 'text',
										name = L["Water"],
										desc = L["Set quantity for water."],
										get = function() return self.db.profile.tradeCount.PRIEST[2] end,
										set = function(v) self.db.profile.tradeCount.PRIEST[2] = v end,
										validate = {'0', '20', '40', '60'},
									},
								},
							},
							rogue = {
								type = 'group',
								name = L["Rogue"],
								desc = L["Set items quantity."],
								args = { 
									food = {
										order = 1,
										type = 'text',
										name = L["Food"],
										desc = L["Set quantity for food."],
										get = function() return self.db.profile.tradeCount.ROGUE[1] end,
										set = function(v) self.db.profile.tradeCount.ROGUE[1] = v end,
										validate = {'0', '20', '40', '60'},
									},
								},
							},
							warlock = {
								type = 'group',
								name = L["Warlock"],
								desc = L["Set items quantity."],
								args = { 
									food = {
										order = 1,
										type = 'text',
										name = L["Food"],
										desc = L["Set quantity for food."],
										get = function() return self.db.profile.tradeCount.WARLOCK[1] end,
										set = function(v) self.db.profile.tradeCount.WARLOCK[1] = v end,
										validate = {'0', '20', '40', '60'},
									},
									water = {
										order = 2,
										type = 'text',
										name = L["Water"],
										desc = L["Set quantity for water."],
										get = function() return self.db.profile.tradeCount.WARLOCK[2] end,
										set = function(v) self.db.profile.tradeCount.WARLOCK[2] = v end,
										validate = {'0', '20', '40', '60'},
									},
								},
							},
							warrior = {
								type = 'group',
								name = L["Warrior"],
								desc = L["Set items quantity."],
								args = { 
									food = {
										order = 1,
										type = 'text',
										name = L["Food"],
										desc = L["Set quantity for food."],
										get = function() return self.db.profile.tradeCount.WARRIOR[1] end,
										set = function(v) self.db.profile.tradeCount.WARRIOR[1] = v end,
										validate = {'0', '20', '40', '60'},
									},
								},
							},
						},
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
								get = function() return self.db.profile.tradeFilter.tradeWithFriend end,
								set = function(v) self.db.profile.tradeFilter.tradeWithFriend = v end,
							},
							group = {
								order = 2,
								type = 'toggle',
								name = L["Group/Raid members"],
								desc = L["Toggle trade with group/raid members."],
								get = function() return self.db.profile.tradeFilter.tradeWithRaid end,
								set = function(v) self.db.profile.tradeFilter.tradeWithRaid = v end,
							},
							guild = {
								order = 3,
								type = 'toggle',
								name = L["Guild members"],
								desc = L["Toggle trade with guild members."],
								get = function() return self.db.profile.tradeFilter.tradeWithGuild end,
								set = function(v) self.db.profile.tradeFilter.tradeWithGuild = v end,
							},
							other = {
								order = 4,
								type = 'toggle',
								name = L["Other"],
								desc = L["Toggle trade with other players."],
								get = function() return self.db.profile.tradeFilter.tradeWithAnyone end,
								set = function(v) self.db.profile.tradeFilter.tradeWithAnyone = v end,
							},
						},
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
								name = L["Add"],
								desc = string.format(L["Add a player to the exclusion list.\n\nUsage: <%s> <%s> <%s>"], L["player name"], L["amount of food"], L["amount of water"]),
								usage = '<'..L["player name"]..'> <'..L["amount of food"]..'> <'..L["amount of water"]..'>',
								get = false,
								set = function(str) self:AddPlayer(str) end,
							},
							remove = {
								order = 2,
								type = 'text',
								name = L["Remove"],
								desc = string.format(L["Remove a player from the exclusion list.\n\nUsage: <%s>"], L["player name"]),
								usage = '<'..L["player name"]..'>',
								get = false,
								set = function(name) self:RemovePlayer(name) end,
							},
							print = {
								order = 3,
								type = 'execute',
								name = L["Print"],
								desc = L["Printing an exclusion list."],
								func = function() self:PrintList() end,
							},
							space = {
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
									self.db.profile.exceptionList = {}
									self:Print(L["The list has been successfully cleared."])
								end,
							},
						},
					},
				}
			},
			requests = {
				order = 5,
				type = 'toggle',
				name = L["Whisper requests"],
				desc = L["Toggle whisper requests."],
				get = function() return self.db.profile.whisperRequest end,
				set = function(v) self.db.profile.whisperRequest = v end,
			}
		}
	}	
	return opts
end

function Caterer:AddPlayer(str)
	local _, _, playerName, food, water = string.find(str, '(.+) (%d+) (%d+)')
	if not food or not water or math.mod(food, 20) ~= 0 or math.mod(water, 20) ~= 0 then
		return self:Print(string.format(L["Expected string: '<%s> <%s> <%s>'. Note: the number must be a multiple of 20."], L["player name"], L["amount of food"], L["amount of water"]))
		elseif food + water > 120 then
		return self:Print(L["The total number of items should not exceed 120."])
	end
	local type
	if self.db.profile.exceptionList[playerName] then
		type = L["edited"]
		else
		type = L["added"]
	end
	self.db.profile.exceptionList[playerName] = {}
	table.insert(self.db.profile.exceptionList[playerName], food)
	table.insert(self.db.profile.exceptionList[playerName], water)
	self:Print(L["Player"]..' <'..playerName..'> '..string.format(L["was successfully %s."], type))
end

function Caterer:RemovePlayer(name)
	if not self.db.profile.exceptionList[name] then
		return self:Print(L["This player is not listed."])
	end
	self.db.profile.exceptionList[name] = nil
	self:Print(L["Player"]..' <'..name..'> '..string.format(L["was successfully %s."], L["removed"]))
end

function Caterer:PrintList()
	if not next(self.db.profile.exceptionList) then
		self:Print(L["The list is empty."])
		else
		self:Print(L["List of exceptions"]..":")
		DEFAULT_CHAT_FRAME:AddMessage(string.format('[|c00bfffff%s|r] = {%s, %s}', L["player name"], L["Food"], L["Water"]))
		for k, v in pairs(self.db.profile.exceptionList) do
			DEFAULT_CHAT_FRAME:AddMessage('[|c00bfffff'..k..'|r] = {'..v[1]..', '..v[2]..'}')
		end
	end
end