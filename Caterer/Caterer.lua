--[[---------------------------------------------------------------------------------
	Caterer
	written by Pik/Silvermoon (YES, I KNOW WHAT IT MEANS IN DUTCH), 
	code based on FreeRefills code by Kyahx with a shout out to Maia.
	inspired by Arcanum, Trade Dispenser, Vending Machine.
------------------------------------------------------------------------------------]]

--[[---------------------------------------------------------------------------------
	Localization
------------------------------------------------------------------------------------]]

local L = AceLibrary('AceLocale-2.2'):new('Caterer')

--[[---------------------------------------------------------------------------------
	Initialization
------------------------------------------------------------------------------------]]

local target, linkForPrint, whisper, whisperCount

Caterer = AceLibrary('AceAddon-2.0'):new('AceConsole-2.0', 'AceEvent-2.0', 'AceDB-2.0', 'AceDebug-2.0')

Caterer.options = {
	handler = Caterer,
	type = 'group',
	args = {
		food = {
			order = 1,
			type = 'text',
			name = L["Food"],
			desc = L["Set food for trades."],
			get = function() return Caterer.db.profile.tradeWhat[1] end,
			set = function(v) Caterer.db.profile.tradeWhat[1] = v end,
			validate = {['22895'] = L["Conjured Cinnamon Roll"], ['8076'] = L["Conjured Sweet Roll"]},
		},
		water = {
			order = 2,
			type = 'text',
			name = L["Water"],
			desc = L["Set water for trades."],
			get = function() return Caterer.db.profile.tradeWhat[2] end,
			set = function(v) Caterer.db.profile.tradeWhat[2] = v end,
			validate = {['8079'] = L["Conjured Crystal Water"], ['8078'] = L["Conjured Sparkling Water"]},
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
									get = function() return Caterer.db.profile.tradeCount.WARLOCK[1] end,
									set = function(v) Caterer.db.profile.tradeCount.WARLOCK[1] = v end,
									validate = {'0', '20', '40', '60'},
								},
								water = {
									order = 2,
									type = 'text',
									name = L["Water"],
									desc = L["Set quantity for water."],
									get = function() return Caterer.db.profile.tradeCount.WARLOCK[2] end,
									set = function(v) Caterer.db.profile.tradeCount.WARLOCK[2] = v end,
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
									get = function() return Caterer.db.profile.tradeCount.WARRIOR[1] end,
									set = function(v) Caterer.db.profile.tradeCount.WARRIOR[1] = v end,
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
									get = function() return Caterer.db.profile.tradeCount.PRIEST[1] end,
									set = function(v) Caterer.db.profile.tradeCount.PRIEST[1] = v end,
									validate = {'0', '20', '40', '60'},
								},
								water = {
									order = 2,
									type = 'text',
									name = L["Water"],
									desc = L["Set quantity for water."],
									get = function() return Caterer.db.profile.tradeCount.PRIEST[2] end,
									set = function(v) Caterer.db.profile.tradeCount.PRIEST[2] = v end,
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
									get = function() return Caterer.db.profile.tradeCount.ROGUE[1] end,
									set = function(v) Caterer.db.profile.tradeCount.ROGUE[1] = v end,
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
									get = function() return Caterer.db.profile.tradeCount.HUNTER[1] end,
									set = function(v) Caterer.db.profile.tradeCount.HUNTER[1] = v end,
									validate = {'0', '20', '40', '60'},
								},
								water = {
									order = 2,
									type = 'text',
									name = L["Water"],
									desc = L["Set quantity for water."],
									get = function() return Caterer.db.profile.tradeCount.HUNTER[2] end,
									set = function(v) Caterer.db.profile.tradeCount.HUNTER[2] = v end,
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
									get = function() return Caterer.db.profile.tradeCount.PALADIN[1] end,
									set = function(v) Caterer.db.profile.tradeCount.PALADIN[1] = v end,
									validate = {'0', '20', '40', '60'},
								},
								water = {
									order = 2,
									type = 'text',
									name = L["Water"],
									desc = L["Set quantity for water."],
									get = function() return Caterer.db.profile.tradeCount.PALADIN[2] end,
									set = function(v) Caterer.db.profile.tradeCount.PALADIN[2] = v end,
									validate = {'0', '20', '40', '60'},
								},
							},
						},
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
									get = function() return Caterer.db.profile.tradeCount.DRUID[1] end,
									set = function(v) Caterer.db.profile.tradeCount.DRUID[1] = v end,
									validate = {'0', '20', '40', '60'},
								},
								water = {
									order = 2,
									type = 'text',
									name = L["Water"],
									desc = L["Set quantity for water."],
									get = function() return Caterer.db.profile.tradeCount.DRUID[2] end,
									set = function(v) Caterer.db.profile.tradeCount.DRUID[2] = v end,
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
							get = function() return Caterer.db.profile.tradeFilter.tradeWithFriend end,
							set = function(v) Caterer.db.profile.tradeFilter.tradeWithFriend = v end,
						},
						group = {
							order = 2,
							type = 'toggle',
							name = L["Group/Raid members"],
							desc = L["Toggle trade with group/raid members."],
							get = function() return Caterer.db.profile.tradeFilter.tradeWithRaid end,
							set = function(v) Caterer.db.profile.tradeFilter.tradeWithRaid = v end,
						},
						guild = {
							order = 3,
							type = 'toggle',
							name = L["Guild members"],
							desc = L["Toggle trade with guild members."],
							get = function() return Caterer.db.profile.tradeFilter.tradeWithGuild end,
							set = function(v) Caterer.db.profile.tradeFilter.tradeWithGuild = v end,
						},
						other = {
							order = 4,
							type = 'toggle',
							name = L["Other"],
							desc = L["Toggle trade with other players."],
							get = function() return Caterer.db.profile.tradeFilter.tradeWithAnyone end,
							set = function(v) Caterer.db.profile.tradeFilter.tradeWithAnyone = v end,
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
							set = function(str)
								local _, _, playerName, food, water = string.find(str, '(.+) (%d+) (%d+)')
								if not food or not water or math.mod(food, 20) ~= 0 or math.mod(water, 20) ~= 0 then
									return Caterer:Print(string.format(L["Expected string: '<%s> <%s> <%s>'. Note: the number must be a multiple of 20."], L["player name"], L["amount of food"], L["amount of water"]))
								elseif food + water > 120 then
									return Caterer:Print(L["The total number of items should not exceed 120."])
								end
								local type
								if Caterer.db.profile.exceptionList[playerName] then
									type = L["edited"]
								else
									type = L["added"]
								end
								Caterer.db.profile.exceptionList[playerName] = {}
								table.insert(Caterer.db.profile.exceptionList[playerName], food)
								table.insert(Caterer.db.profile.exceptionList[playerName], water)
								Caterer:Print(L["Player"]..' <'..playerName..'> '..string.format(L["was successfully %s."], type))
							end,
						},
						remove = {
							order = 2,
							type = 'text',
							name = L["Remove"],
							desc = string.format(L["Remove a player from the exclusion list.\n\nUsage: <%s>"], L["player name"]),
							usage = '<'..L["player name"]..'>',
							get = false,
							set = function(name)
								if not Caterer.db.profile.exceptionList[name] then
									return Caterer:Print(L["This player is not listed."])
								end
								Caterer.db.profile.exceptionList[name] = nil
								Caterer:Print(L["Player"]..' <'..name..'> '..string.format(L["was successfully %s."], L["removed"]))
							end,
						},
						print = {
							order = 3,
							type = 'execute',
							name = L["Print"],
							desc = L["Printing an exclusion list."],
							func = function()
								if not next(Caterer.db.profile.exceptionList) then
									Caterer:Print(L["The list is empty."])
								else
									Caterer:Print(L["List of exceptions"]..":")
									DEFAULT_CHAT_FRAME:AddMessage(string.format('[|c00bfffff%s|r] = {%s, %s}', L["player name"], L["Food"], L["Water"]))
									for k, v in pairs(Caterer.db.profile.exceptionList) do
										DEFAULT_CHAT_FRAME:AddMessage('[|c00bfffff'..k..'|r] = {'..v[1]..', '..v[2]..'}')
									end
								end
							end,
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
								Caterer.db.profile.exceptionList = {}
								Caterer:Print(L["The list has been successfully cleared."])
							end,
						},
					},
				},
			}
		},
		requests = {
			order = 4,
			type = 'toggle',
			name = L["Whisper requests"],
			desc = L["Toggle whisper requests."],
			get = function() return Caterer.db.profile.whisperRequest end,
			set = function(v) Caterer.db.profile.whisperRequest = v end,
		}
	}
}

function Caterer:OnInitialize()
	-- Called when the addon is loaded
	self.defaults = {
		-- {food, water}
		exceptionList = {},
		whisperRequest = false,
		tradeWhat = {'22895', '8079'},
		tradeCount = {
			['DRUID']   = {'0' , '60'},
			['HUNTER']  = {'60', '20'},
			['PALADIN'] = {'40', '40'},
			['PRIEST']  = {'0' , '60'},
			['ROGUE']   = {'60', nil },
			['WARLOCK'] = {'60', '40'},
			['WARRIOR'] = {'60', nil }
		},
		tradeFilter = {
			tradeWithAnyone = false,
			tradeWithRaid = true,
			tradeWithGuild = true,
			tradeWithFriend = true,
		}
	}
	self:RegisterDB('CatererDB')
	self:RegisterDefaults('profile', self.defaults)
	self:RegisterChatCommand({'/caterer', '/cater'}, Caterer.options)
	
	--Popup Box if player class not mage
	StaticPopupDialogs["CATERER_NOT_MAGE"] = {
		text = L["Attention! Addon Caterer is not designed for your class. It must be disabled."],
		button1 = DISABLE,
		OnAccept = function()
			self:ToggleActive(false)
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = false,
		preferredIndex = 3
	}
	local _, class = UnitClass('player')
	if class ~= 'MAGE' then
		if not self:IsActive() then return end
		StaticPopup_Show ("CATERER_NOT_MAGE")
	else
		self:ToggleActive(true)
		DEFAULT_CHAT_FRAME:AddMessage('Caterer '..GetAddOnMetadata('Caterer', 'Version')..' '..L["loaded."])
	end
end

function Caterer:OnEnable()
	-- Called when the addon is enabled
	self:RegisterEvent('TRADE_SHOW')
	self:RegisterEvent('TRADE_ACCEPT_UPDATE')
	self:RegisterEvent('CHAT_MSG_WHISPER')
end

function Caterer:OnDisable()
	-- Called when the addon is disabled
	self:UnregisterAllEvents()
end

--[[---------------------------------------------------------------------------------
	Event Handlers
------------------------------------------------------------------------------------]]

function Caterer:TRADE_SHOW()
	local performTrade = self:CheckTheTrade()
	if not performTrade then return end
	
	local count
	local _, tradeClass = UnitClass('NPC')
	local item = self.db.profile.tradeWhat
	if whisper then
		count = whisperCount
	elseif self.db.profile.exceptionList[UnitName('NPC')] then
		count = self.db.profile.exceptionList[UnitName('NPC')]
	else
		count = self.db.profile.tradeCount[tradeClass]
	end
	for i = 1, 2 do
		if count[i] then
			self:DoTheTrade(tonumber(item[i]), tonumber(count[i]), i)
		end
	end
end

function Caterer:TRADE_ACCEPT_UPDATE(arg1, arg2)
	-- arg1 - Player has agreed to the trade (1) or not (0)
	-- arg2 - Target has agreed to the trade (1) or not (0)
	if arg2 then
		AcceptTrade()
	end
end

function Caterer:CHAT_MSG_WHISPER(arg1, arg2)
	-- arg1 - Message received
	-- arg2 - Author
	whisperCount = {}
	local _, _, prefix, foodCount, waterCount = string.find(arg1, '(.+) (.+) (.+)')
	foodCount = tonumber(foodCount)
	waterCount = tonumber(waterCount)
	if not prefix or prefix ~= '#cat' then return end
	if not self.db.profile.whisperRequest and prefix then
		return SendChatMessage(L["Service is temporarily disabled."], 'WHISPER', nil, arg2)
	end
	
	if type(foodCount) ~= 'number' or type(waterCount) ~= 'number' or math.mod(foodCount, 20) ~= 0 or math.mod(waterCount, 20) ~= 0 then
		return SendChatMessage(string.format(L["Expected string: '<%s> <%s> <%s>'. Note: the number must be a multiple of 20."], '#cat', L["amount of food"], L["amount of water"]), 'WHISPER', nil, arg2)
	elseif foodCount + waterCount > 120 then
		return SendChatMessage(L["The total number of items should not exceed 120."], 'WHISPER', nil, arg2)
	elseif foodCount == 0 and waterCount == 0 then
		return
	end
	
	TargetByName(arg2, true)
	target = UnitName('target')
	if target == arg2 and foodCount and waterCount then
		whisper = true
		whisperCount = {foodCount, waterCount}
		self:RegisterEvent('UI_ERROR_MESSAGE') -- check if target to trade is too far
		InitiateTrade('target')
	end
end

function Caterer:UI_ERROR_MESSAGE(arg1)
	-- arg1 - Message received
	if arg1 == ERR_TRADE_TOO_FAR then
		return SendChatMessage(L["It is necessary to come closer."], 'WHISPER', nil, target)
	end
end

--[[--------------------------------------------------------------------------------
	Shared Functions
-----------------------------------------------------------------------------------]]

function Caterer:CheckTheTrade()
	--Check to see whether or not we should execute the trade.
	local doTrade = false
	
	if self.db.profile.tradeFilter.tradeWithAnyone then
		doTrade = true
	elseif self.db.profile.tradeFilter.tradeWithRaid then
		if UnitInParty('NPC') or UnitInRaid('NPC') then
			doTrade = true
		end
	elseif self.db.profile.tradeFilter.tradeWithGuild then
		if GetGuildInfo('NPC') == GetGuildInfo('player') then
			doTrade = true
		end
	elseif self.db.profile.tradeFilter.tradeWithFriend then
		for i = 1, GetNumFriends() do
			if UnitName('NPC') == GetFriendInfo(i) then
				doTrade = true
			end
		end
	end
	
	return doTrade
end

function Caterer:DoTheTrade(itemID, count, itemType)
	-- itemType: 1 - food, 2 - water
	if not TradeFrame:IsVisible() or count == 0 then return end
	linkForPrint = nil -- link clearing
	local itemCount, slotArray = self:CountItemInBags(itemID)
	if itemCount < count and linkForPrint then
		CloseTrade() 
		return SendChatMessage(L["I can't complete the trade right now. I'm out of"]..' '..linkForPrint..'.')
	elseif not linkForPrint then
		CloseTrade()
		if itemType == 1 then
			return SendChatMessage(string.format(L["Trade is impossible, no %s"], L["food."]))
		else
			return SendChatMessage(string.format(L["Trade is impossible, no %s"], L["water."]))
		end
	end
	
	local stack = 20
	
	for k in pairs(slotArray) do
		local _, _, bag, slot = string.find(slotArray[k], 'bag: (%d+), slot: (%d+)')
		self:Debug(slotArray[k])
		PickupContainerItem(bag, slot)
		if CursorHasItem then
			local slot = TradeFrame_GetAvailableSlot() -- blizzard function
			ClickTradeButton(slot)
			count = count - stack
		else
			return self:Debug('|cffff9966'..L["Had a problem picking things up!"]..'|r')
		end
		if count == 0 then break end
	end
	whisper = false -- Turn off the whisper mode after each trade
end

function Caterer:CountItemInBags(itemID)
	local stackSize = 20
	local totalCount = 0
	local slotArray = {}
	
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag)
		if size > 0 then
			for slot = size, 1, -1 do
				local itemLink = GetContainerItemLink(bag, slot)
				local slotID = self:ExtractItemID(itemLink)
				if slotID == itemID then
					linkForPrint = itemLink
					local _, itemCount = GetContainerItemInfo(bag, slot)
					if tonumber(itemCount) == stackSize then
						totalCount = totalCount + itemCount
						table.insert(slotArray, 'bag: '..bag..', slot: '..slot)
					end
				end
			end
		end
	end
	self:Debug(totalCount)
	return totalCount, slotArray
end

function Caterer:ExtractItemID(link)
	if not link then return end
	
	local _, _, itemID = string.find(link, 'item:(%d+):.*')
	return tonumber(itemID)
end