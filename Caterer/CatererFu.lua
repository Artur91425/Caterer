--[[---------------------------------------------------------------------------------
	FuBar Plugin
------------------------------------------------------------------------------------]]

if not Caterer then return end

CatererFu = AceLibrary('AceAddon-2.0'):new('FuBarPlugin-2.0', 'AceDB-2.0', 'AceEvent-2.0')
CatererFu.hasIcon = 'Interface\\Icons\\Inv_drink_18'

--[[---------------------------------------------------------------------------------
	Locals
------------------------------------------------------------------------------------]]

local L = AceLibrary('AceLocale-2.2'):new('Caterer')
local Tablet = AceLibrary('Tablet-2.0')

--[[---------------------------------------------------------------------------------
	Initialization
------------------------------------------------------------------------------------]]

function CatererFu:OnInitialize()
	self:RegisterDB('CatererDB')

	self.name = 'Caterer '..GetAddOnMetadata('Caterer', 'Version')
	self.defaultMinimapPosition = 180
	self.hideWithoutStandby = true
	self.clickableTooltip = true
	self.cannotHideIcon = true

	self.OnMenuRequest = Caterer.options
	local args = AceLibrary('FuBarPlugin-2.0'):GetAceOptionsDataTable(self)
	for k, v in pairs(args) do
		if not self.OnMenuRequest.args[k] then
			self.OnMenuRequest.args[k] = v
		end
	end
	-- fix Shaman class color
	RAID_CLASS_COLORS['SHAMAN'].r = 0.0
	RAID_CLASS_COLORS['SHAMAN'].g = 0.44
	RAID_CLASS_COLORS['SHAMAN'].b = 0.87
end

function CatererFu:OnEnable()
	self:RegisterEvent('BAG_UPDATE', 'OnTextUpdate')
end

function CatererFu:OnTextUpdate()
	local foodCount = Caterer:GetNumItems(Caterer.db.profile.tradeWhat[1])
	local waterCount = Caterer:GetNumItems(Caterer.db.profile.tradeWhat[2])
	local food = string.format('|cff%s%d|r', AceLibrary('Crayon-2.0'):GetThresholdHexColorTrivial(foodCount, 0, 100, 200, 300, 400), foodCount)
	local water = string.format('|cff%s%d|r', AceLibrary('Crayon-2.0'):GetThresholdHexColor(waterCount, 0, 100, 200, 300, 400), waterCount)
	self:SetText(L["Food"]..': '..food..' '..L["Water"]..': '..water)
end

function CatererFu:OnTooltipUpdate()
	Tablet:SetTitle(self.name)
	Tablet:SetTitleColor(0.41, 0.80, 0.94)
	if Caterer.db.profile.tooltip.classes then
		local cat1 = Tablet:AddCategory('columns', 3, 'text', ' ')
			cat1:AddLine('text', L["Class"], 'text2', L["Food"], 'text3', L["Water"], 'justify3', 'CENTER')
		for class, v in pairs(Caterer.db.profile.tradeCount) do
			local name = Caterer.options.args.filter.args.quantity.args[string.lower(class)].name
			local color = RAID_CLASS_COLORS[class]
			cat1:AddLine('text', name..':', 'textR', color.r, 'textG', color.g, 'textB', color.b, 'text2', v[1], 'text3', v[2] or L["nil"], 'justify3', 'CENTER')
		end
	end
	local cat2 = Tablet:AddCategory('columns', 2)
	for k, v in pairs(Caterer.db.profile.tradeFilter) do
		cat2:AddLine('text', L["Trade with"..' '..k]..':', 'text2', self:GetStatus(v), 'func', self.ToggleOptions, 'arg1', self, 'arg2', 'tradeFilter', 'arg3', k)
	end
	local cat3 = Tablet:AddCategory('columns', 2)
	cat3:AddLine('text', L["Whisper requests"]..':', 'text2', self:GetStatus(Caterer.db.profile.whisperRequest), 'func', self.ToggleOptions, 'arg1', self, 'arg2', 'whisperRequest')
	if Caterer.db.profile.tooltip.exceptionList and next(Caterer.db.profile.exceptionList) then
		local cat4 = Tablet:AddCategory('columns', 3, 'text', L["List of exceptions"]..':', 'font', GameTooltipHeaderText, 'textR', 1, 'textG', 0.823529, 'textB', 0)
		cat4:AddLine('text', L["Player"], 'text2', L["Food"], 'text3', L["Water"], 'justify3', 'CENTER')
		for k, v in pairs(Caterer.db.profile.exceptionList) do
			cat4:AddLine('text', '|cffbfffff'..k..'|r', 'text2', v[1], 'text3', v[2], 'justify3', 'CENTER', 'func', Caterer.RemovePlayer, 'arg1', Caterer, 'arg2', k)
		end
	end
	Tablet:SetHint('\n'..L["LeftClick to toggle addon.\nRightClick to open dropdown menu.\nLeftClick on the point tooltip to quickly manage the addon."])
end

function CatererFu:OnClick()
	if Caterer:IsActive() then
		Caterer:ToggleActive(false)
		getglobal(this:GetName()..'Icon'):SetVertexColor(0.3, 0.3, 0.3)
	else
		Caterer:ToggleActive(true)
		getglobal(this:GetName()..'Icon'):SetVertexColor(1, 1, 1)
    end
end

--[[--------------------------------------------------------------------------------
	Shared Functions
-----------------------------------------------------------------------------------]]

function CatererFu:GetStatus(value)
	if value then
		return '|CFF00FF00'..L["On"]..'|r'
	else
		return '|CFFFF0000'..L["Off"]..'|r'
	end
end

function CatererFu:ToggleOptions(table, key)
	local value
	if table == 'tradeFilter' then
		value = Caterer.db.profile[table][key]
		Caterer.db.profile[table][key] = not value
		return Caterer.db.profile[table][key]
	elseif table == 'whisperRequest' then
		value = Caterer.db.profile[table]
		Caterer.db.profile[table] = not value
		return Caterer.db.profile[table]
	end
end