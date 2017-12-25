--[[---------------------------------------------------------------------------------
	Caterer
	written by Pik/Silvermoon (YES, I KNOW WHAT IT MEANS IN DUTCH), 
	code based on FreeRefills code by Kyahx with a shout out to Maia.
	inspired by Arcanum, Trade Dispenser, Vending Machine.
	
	To Do:
	+ Add filter to trade with defined individuals.
	+ Add a range check for the teade.
------------------------------------------------------------------------------------]]

--[[---------------------------------------------------------------------------------
	Localization
------------------------------------------------------------------------------------]]

local L = AceLibrary('AceLocale-2.2'):new('Caterer')

--[[---------------------------------------------------------------------------------
	Initialization
------------------------------------------------------------------------------------]]

local FOOD_RANK7 = L["Conjured Cinnamon Roll"]
local FOOD_RANK6 = L["Conjured Sweet Roll"]
local WATER_RANK7 = L["Conjured Crystal Water"]
local WATER_RANK6 = L["Conjured Sparkling Water"]
local linkForPrint, whisper, whisperCount

Caterer = AceLibrary('AceAddon-2.0'):new('AceConsole-2.0', 'AceEvent-2.0', 'AceDB-2.0', 'AceDebug-2.0')

Caterer.options = {
	handler = Caterer,
	type = 'group',
	args = {
		food = {
			type = 'text',
			name = L["Food"],
			desc = L["Set food for trades."],
			get = function() return Caterer.db.profile.tradewhat[1] end,
			set = function(v) Caterer.db.profile.tradewhat[1] = v end,
			validate = {['22895'] = FOOD_RANK7, ['8076'] = FOOD_RANK6},
			order = 1,
		},
		water = {
			type = 'text',
			name = L["Water"],
			desc = L["Set water for trades."],
			get = function() return Caterer.db.profile.tradewhat[2] end,
			set = function(v) Caterer.db.profile.tradewhat[2] = v end,
			validate = {['8079'] = WATER_RANK7, ['8078'] = WATER_RANK6},
			order = 2,
		},
		filter = {
			type = 'group',
			name = L["Filter"],
			desc = L["Filter options."],
			order = 3,
			args = {
				quantity = {
					type = 'group',
					name = L["Quantity"],
					desc = L["Quantity options."],
					order = 1,
					args = { 
						warlock = {
							type = 'group',
							name = L["Warlock"],
							desc = L["Set items quantity."],
							args = { 
								food = {
									type = 'text',
									name = L["Food"],
									desc = L["Set quantity for food."],
									get = function() return Caterer.db.profile.tradecount.WARLOCK[1] end,
									set = function(v) Caterer.db.profile.tradecount.WARLOCK[1] = v end,
									validate = {'0', '20', '40', '60'},
									order = 1,
								},
								water = {
									type = 'text',
									name = L["Water"],
									desc = L["Set quantity for water."],
									get = function() return Caterer.db.profile.tradecount.WARLOCK[2] end,
									set = function(v) Caterer.db.profile.tradecount.WARLOCK[2] = v end,
									validate = {'0', '20', '40', '60'},
									order = 2,
								},
							},
						},
						warrior = {
							type = 'group',
							name = L["Warrior"],
							desc = L["Set items quantity."],
							args = { 
								food = {
									type = 'text',
									name = L["Food"],
									desc = L["Set quantity for food."],
									get = function() return Caterer.db.profile.tradecount.WARRIOR[1] end,
									set = function(v) Caterer.db.profile.tradecount.WARRIOR[1] = v end,
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
									type = 'text',
									name = L["Food"],
									desc = L["Set quantity for food."],
									get = function() return Caterer.db.profile.tradecount.PRIEST[1] end,
									set = function(v) Caterer.db.profile.tradecount.PRIEST[1] = v end,
									validate = {'0', '20', '40', '60'},
									order = 1,
								},
								water = {
									type = 'text',
									name = L["Water"],
									desc = L["Set quantity for water."],
									get = function() return Caterer.db.profile.tradecount.PRIEST[2] end,
									set = function(v) Caterer.db.profile.tradecount.PRIEST[2] = v end,
									validate = {'0', '20', '40', '60'},
									order = 2,
								},
							},
						},
						rogue = {
							type = 'group',
							name = L["Rogue"],
							desc = L["Set items quantity."],
							args = { 
								food = {
									type = 'text',
									name = L["Food"],
									desc = L["Set quantity for food."],
									get = function() return Caterer.db.profile.tradecount.ROGUE[1] end,
									set = function(v) Caterer.db.profile.tradecount.ROGUE[1] = v end,
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
									type = 'text',
									name = L["Food"],
									desc = L["Set quantity for food."],
									get = function() return Caterer.db.profile.tradecount.HUNTER[1] end,
									set = function(v) Caterer.db.profile.tradecount.HUNTER[1] = v end,
									validate = {'0', '20', '40', '60'},
									order = 1,
								},
								water = {
									type = 'text',
									name = L["Water"],
									desc = L["Set quantity for water."],
									get = function() return Caterer.db.profile.tradecount.HUNTER[2] end,
									set = function(v) Caterer.db.profile.tradecount.HUNTER[2] = v end,
									validate = {'0', '20', '40', '60'},
									order = 2,
								},
							},
						},
						paladin = {
							type = 'group',
							name = L["Paladin"],
							desc = L["Set items quantity."],
							args = { 
								food = {
									type = 'text',
									name = L["Food"],
									desc = L["Set quantity for food."],
									get = function() return Caterer.db.profile.tradecount.PALADIN[1] end,
									set = function(v) Caterer.db.profile.tradecount.PALADIN[1] = v end,
									validate = {'0', '20', '40', '60'},
									order = 1,
								},
								water = {
									type = 'text',
									name = L["Water"],
									desc = L["Set quantity for water."],
									get = function() return Caterer.db.profile.tradecount.PALADIN[2] end,
									set = function(v) Caterer.db.profile.tradecount.PALADIN[2] = v end,
									validate = {'0', '20', '40', '60'},
									order = 2,
								},
							},
						},
						druid = {
							type = 'group',
							name = L["Druid"],
							desc = L["Set items quantity."],
							args = { 
								food = {
									type = 'text',
									name = L["Food"],
									desc = L["Set quantity for food."],
									get = function() return Caterer.db.profile.tradecount.DRUID[1] end,
									set = function(v) Caterer.db.profile.tradecount.DRUID[1] = v end,
									validate = {'0', '20', '40', '60'},
									order = 1,
								},
								water = {
									type = 'text',
									name = L["Water"],
									desc = L["Set quantity for water."],
									get = function() return Caterer.db.profile.tradecount.DRUID[2] end,
									set = function(v) Caterer.db.profile.tradecount.DRUID[2] = v end,
									validate = {'0', '20', '40', '60'},
									order = 2,
								},
							},
						},
					},
				},	
				trade = {
					type = 'group',
					name = L["Trade"],
					desc = L["Trade options."],
					args = {
						friends = {
							type = 'toggle',
							name = L["Friends"],
							desc = L["Toggle trade with friends."],
							get = function() return Caterer.db.profile.tradefilter.tradeWithFriend end,
							set = function(v) Caterer.db.profile.tradefilter.tradeWithFriend = v end,
							order = 1
						},
						group = {
							type = 'toggle',
							name = L["Group/Raid members"],
							desc = L["Toggle trade with group/raid members."],
							get = function() return Caterer.db.profile.tradefilter.tradeWithRaid end,
							set = function(v) Caterer.db.profile.tradefilter.tradeWithRaid = v end,
							order = 2
						},
						guild = {
							type = 'toggle',
							name = L["Guild members"],
							desc = L["Toggle trade with guild members."],
							get = function() return Caterer.db.profile.tradefilter.tradeWithGuild end,
							set = function(v) Caterer.db.profile.tradefilter.tradeWithGuild = v end,
							order = 3
						},
						other = {
							type = 'toggle',
							name = L["Other"],
							desc = L["Toggle trade with other players."],
							get = function() return Caterer.db.profile.tradefilter.tradeWithAnyone end,
							set = function(v) Caterer.db.profile.tradefilter.tradeWithAnyone = v end,
							order = 4
						}
					}
				}
			}
		},
		request = {
			type = 'toggle',
			name = L["Whisper requests"],
			desc = L["Toggle whisper requests."],
			get = function() return Caterer.db.profile.whisperrequest end,
			set = function(v) Caterer.db.profile.whisperrequest = v end,
			order = 4,
		},
	}
}

function Caterer:OnInitialize()
	-- Called when the addon is loaded
	self.defaults = {
		-- {food, water}
		whisperrequest = false,
		tradewhat = {'22895', '8079'},
		tradecount = {
			['DRUID']   = {'0' , '60'},
			['HUNTER']  = {'60', '20'},
			['PALADIN'] = {'40', '40'},
			['PRIEST']  = {'0' , '60'},
			['ROGUE']   = {'60', nil },
			['WARLOCK'] = {'60', '40'},
			['WARRIOR'] = {'60', nil }
		},
		tradefilter = {
			tradeWithAnyone = false,
			tradeWithRaid = true,
			tradeWithGuild = true,
			tradeWithFriend = true,
		}
	}
	self:RegisterDB('CatererDB')
	self:RegisterDefaults('profile', self.defaults)
	self:RegisterChatCommand({'/caterer', '/cater'}, Caterer.options)
	
	local _, class = UnitClass('player')
	if class ~= 'MAGE' then
		self:ToggleActive(false)
	else
		self:ToggleActive(true)
		DEFAULT_CHAT_FRAME:AddMessage('Caterer '..GetAddOnMetadata('Caterer', 'Version')..L[" loaded."])
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
	local item = self.db.profile.tradewhat
	if whisper then
		count = whisperCount
	else
		count = self.db.profile.tradecount[tradeClass]
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
	if not self.db.profile.whisperrequest and prefix then
		return SendChatMessage(L["Service is temporarily disabled."], "WHISPER", nil, arg2)
	end
	
	if type(foodCount) ~= 'number' or type(waterCount) ~= 'number' or math.mod(foodCount, 20) ~= 0 or math.mod(waterCount, 20) ~= 0 then
		return SendChatMessage(L["Expected string: '#cat <amount of food> <amount of water>'. Note: the number must be a multiple of 20."], "WHISPER", nil, arg2)
	elseif foodCount + waterCount > 120 then
		return SendChatMessage(L["The total number of items should not exceed 120."], "WHISPER", nil, arg2)
	elseif foodCount == 0 and waterCount == 0 then
		return
	end
	
	TargetByName(arg2, true)
	if UnitName('target') == arg2 and foodCount and waterCount then
		whisper = true
		whisperCount = {foodCount, waterCount}
		InitiateTrade('target')
	end
end

--[[--------------------------------------------------------------------------------
	Shared Functions
-----------------------------------------------------------------------------------]]

function Caterer:CheckTheTrade()
	--Check to see whether or not we should execute the trade.
	local doTrade = false
	
	if self.db.profile.tradefilter.tradeWithAnyone then
		doTrade = true
	elseif self.db.profile.tradefilter.tradeWithRaid then
		if UnitInParty('NPC') or UnitInRaid('NPC') then
			doTrade = true
		end
	elseif self.db.profile.tradefilter.tradeWithGuild then
		if GetGuildInfo('NPC') == GetGuildInfo('player') then
			doTrade = true
		end
	elseif self.db.profile.tradefilter.tradeWithFriend then
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
		return SendChatMessage(L["I can't complete the trade right now. I'm out of "]..linkForPrint..'.')
	elseif not linkForPrint then
		CloseTrade()
		if itemType == 1 then
			return SendChatMessage(L["Trade is impossible, no "]..L["food."])
		else
			return SendChatMessage(L["Trade is impossible, no "]..L["water."])
		end
	end
	
	local stack = 20
	
	for k in pairs(slotArray) do
		local _, _, bag, slot = string.find(slotArray[k], 'bag: (%d+), slot: (%d+)')
		self:Debug(slotArray[k])
		PickupContainerItem(bag, slot)
		if CursorHasItem then
			local slot = TradeFrame_GetAvailableSlot()
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