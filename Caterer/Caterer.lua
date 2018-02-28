--[[---------------------------------------------------------------------------------
	Caterer
	written by Pik/Silvermoon (original author), continued Lichery 
	code based on FreeRefills code by Kyahx with a shout out to Maia.
	inspired by Arcanum, Trade Dispenser, Vending Machine.
------------------------------------------------------------------------------------]]

Caterer = AceLibrary('AceAddon-2.0'):new('AceConsole-2.0', 'AceEvent-2.0', 'AceDB-2.0')

--[[---------------------------------------------------------------------------------
	Locals
------------------------------------------------------------------------------------]]

local L = AceLibrary('AceLocale-2.2'):new('Caterer')
local target, linkForPrint, whisperMode, whisperCount, NPCClass
local defaults = {
	exceptionList = {},
	blackList = {},
	whisperRequest = false,
	-- {food, water}
	tradeWhat = {'22895', '8079'},
	tradeCount = {
		['DRUID']   = {'0' , '60'},
		['HUNTER']  = {'60', '20'},
		['PALADIN'] = {'40', '40'},
		['PRIEST']  = {'0' , '60'},
		['ROGUE']   = {'60',  nil},
		['SHAMAN']  = {'0' , '60'},
		['WARLOCK'] = {'60', '40'},
		['WARRIOR'] = {'60',  nil}
	},
	tradeFilter = {
		friends = true,
		group = true,
		guild = true,
		other = false
	},
	tooltip = {
		classes = false,
		exceptionList = false
	}
}

Caterer.itemTable = {
	[1] = { -- food table
		['22895'] = L["Conjured Cinnamon Roll"],
		['8076'] = L["Conjured Sweet Roll"]
	},
	[2] = { -- water table
		['8079'] = L["Conjured Crystal Water"],
		['8078'] = L["Conjured Sparkling Water"]
	}
}

--[[---------------------------------------------------------------------------------
	Initialization
------------------------------------------------------------------------------------]]

function Caterer:OnInitialize()
	-- Called when the addon is loaded
	self:RegisterDB('CatererDB')
	self:RegisterDefaults('profile', defaults)
	self:RegisterChatCommand({'/caterer', '/cater', '/cat'}, self.options)
	
	-- Popup Box if player class not mage
	StaticPopupDialogs['CATERER_NOT_MAGE'] = {
		text = string.format(L["Attention! Addon %s is not designed for your class. It must be disabled."], '|cff69CCF0Caterer|r'),
		button1 = DISABLE,
		OnAccept = function()
			self:ToggleActive(false)
			local frame = FuBarPluginCatererFrameMinimapButton or FuBarPluginCatererFrame
			if frame then frame:Hide() end
		end,
		timeout = 0,
		showAlert = 1,
		whileDead = true,
		hideOnEscape = false,
		preferredIndex = 3
	}
	local _, class = UnitClass('player')
	if class ~= 'MAGE' then
		if not self:IsActive() then return end
		StaticPopup_Show('CATERER_NOT_MAGE')
	else
		self:ToggleActive(true)
		ChatFrame1:AddMessage('Caterer '..GetAddOnMetadata('Caterer', 'Version')..' '..L["loaded"]..'.', .41, .80, .94)
	end
end

function Caterer:OnEnable()
	-- Called when the addon is enabled
	self:RegisterEvent('TRADE_SHOW')
	self:RegisterEvent('TRADE_ACCEPT_UPDATE')
	self:RegisterEvent('CHAT_MSG_WHISPER')
end

--[[---------------------------------------------------------------------------------
	Event Handlers
------------------------------------------------------------------------------------]]

function Caterer:TRADE_SHOW()
	if self:IsEventRegistered('UI_ERROR_MESSAGE') then self:UnregisterEvent('UI_ERROR_MESSAGE') end
	_, NPCClass = UnitClass('NPC')
	local performTrade = self:CheckTheTrade()
	if not performTrade then return end
	
	local count = self.db.profile.tradeCount[NPCClass]
	local item = self.db.profile.tradeWhat
	if whisperMode then
		count = whisperCount
	elseif self.db.profile.exceptionList[string.lower(UnitName('NPC'))] then
		count = self.db.profile.exceptionList[string.lower(UnitName('NPC'))]
	end
	for itemType in pairs(self.itemTable) do
		if not count[itemType] then break end
		self:DoTheTrade(tonumber(item[itemType]), tonumber(count[itemType]), itemType)
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
	local _, _, prefix, foodCount, waterCount = string.find(arg1, '(#cat) (.+) (.+)')
	if not prefix then return end

	foodCount = tonumber(foodCount)
	waterCount = tonumber(waterCount)
	if not self.db.profile.whisperRequest then
		return SendChatMessage('[Caterer] '..L["Service is temporarily disabled."], 'WHISPER', nil, arg2)
	elseif not (foodCount and waterCount) or math.mod(foodCount, 20) ~= 0 or math.mod(waterCount, 20) ~= 0 then
		return SendChatMessage(string.format('[Caterer] '..L["Expected string: '<%s> <%s> <%s>'. Note: the number must be a multiple of 20."], '#cat', L["amount of food"], L["amount of water"]), 'WHISPER', nil, arg2)
	elseif foodCount + waterCount > 120 then
		return SendChatMessage('[Caterer] '..L["The total number of items should not exceed 120."], 'WHISPER', nil, arg2)
	elseif foodCount + waterCount == 0 then
		return SendChatMessage('[Caterer] '..L["The quantity for both items can not be zero."], 'WHISPER', nil, arg2)
	end
	
	TargetByName(arg2, true)
	target = UnitName('target')
	whisperCount = {}
	if target == arg2 then
		whisperMode = true
		whisperCount = {foodCount, waterCount}
		self:RegisterEvent('UI_ERROR_MESSAGE') -- check if target to trade is too far
		InitiateTrade('target')
	end
end

function Caterer:UI_ERROR_MESSAGE(arg1)
	-- arg1 - Message received
	if arg1 == ERR_TRADE_TOO_FAR then
		whisperMode = false
		SendChatMessage('[Caterer] '..L["It is necessary to come closer."], 'WHISPER', nil, target)
	end
	self:UnregisterEvent('UI_ERROR_MESSAGE')
end

--[[--------------------------------------------------------------------------------
	Shared Functions
-----------------------------------------------------------------------------------]]

function Caterer:CheckTheTrade()
	-- Check to see whether or not we should execute the trade.
	if NPCClass == 'MAGE' then
		SendChatMessage('[Caterer] '..L["Make yourself your own water."]..' :)', 'WHISPER', nil, UnitName('NPC'))
		CloseTrade()
	end	
	for _, name in pairs(self.db.profile.blackList) do
		if name == string.lower(UnitName('NPC')) then
			SendChatMessage('[Caterer] '..L["You are on my blacklist."], 'WHISPER', nil, UnitName('NPC'))
			CloseTrade()
		end
	end

	local NPCInGroup, NPCInMyGuild, NPCInFriendList
	
	if UnitInParty('NPC') or UnitInRaid('NPC') then
		NPCInGroup = true
	end
	if IsInGuild() and GetGuildInfo('player') == GetGuildInfo('NPC') then
		NPCInMyGuild = true
	end
	for i = 1, GetNumFriends() do
		if UnitName('NPC') == GetFriendInfo(i) then
			NPCInFriendList = true
		end
	end
	
	if self.db.profile.tradeFilter.group and NPCInGroup then
		return true
	elseif self.db.profile.tradeFilter.guild and NPCInMyGuild then
		return true
	elseif self.db.profile.tradeFilter.friends and NPCInFriendList then
		return true
	elseif self.db.profile.tradeFilter.other then
		if NPCInGroup or NPCInMyGuild or NPCInFriendList then
			return false
		else
			return true
		end
	end
end

function Caterer:DoTheTrade(itemID, count, itemType)
	-- itemType: 1 - food, 2 - water
	if not TradeFrame:IsVisible() or count == 0 then return end
	linkForPrint = nil -- link clearing
	local itemCount, slotArray = self:GetNumItems(itemID)
	if itemCount < count and linkForPrint then
		CloseTrade() 
		return SendChatMessage(string.format(L["I can't complete the trade right now. I'm out of %s."], linkForPrint))
	elseif not linkForPrint then
		CloseTrade()
		linkForPrint = '|cffffffff|Hitem:'..itemID..':0:0:0:0:0:0:0:0|h['..self.itemTable[itemType][tostring(itemID)]..']|h|r'
		return SendChatMessage(string.format(L["Trade is impossible, no %s."], linkForPrint))
	end

	local stackSize = 20
	for _, v in pairs(slotArray) do
		local _, _, bag, slot, slotCount = string.find(v, 'bag: (%d), slot: (%d+), count: (%d+)')
		if tonumber(slotCount) == stackSize then
			PickupContainerItem(bag, slot)
			if not CursorHasItem then return self:Print('|cffff9966'..L["Had a problem picking things up!"]..'|r') end
			local tradeSlot = TradeFrame_GetAvailableSlot() -- Blizzard function
			ClickTradeButton(tradeSlot)
			count = count - stackSize
			if count == 0 then break end
		end
	end
	if whisperMode then whisperMode = false end
end

function Caterer:GetNumItems(itemID)
	local size, itemLink, slotID, itemCount
	local totalCount = 0
	local slotArray = {}
	
	for bag = 4, 0, -1 do
		size = GetContainerNumSlots(bag)
		if size then
			for slot = size, 1, -1 do
				itemLink = GetContainerItemLink(bag, slot)
				if itemLink then
					slotID = self:GetItemID(itemLink)
					if slotID == itemID then
						linkForPrint = itemLink
						_, itemCount = GetContainerItemInfo(bag, slot)
						totalCount = totalCount + itemCount
						table.insert(slotArray, 'bag: '..bag..', slot: '..slot..', count: '..itemCount)
					end
				end
			end
		end
	end
	return totalCount, slotArray
end

function Caterer:GetItemID(link)
	if not link then return end
	
	local _, _, itemID = string.find(link, 'item:(%d+):')
	return tonumber(itemID)
end

function Caterer:FirstToUpper(str) -- first character UPPER case
    return string.gsub(str, '^%l', string.upper)
end