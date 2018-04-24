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
local Crayon = AceLibrary('Crayon-2.0')

--[[---------------------------------------------------------------------------------
	Initialization
------------------------------------------------------------------------------------]]

function CatererFu:OnInitialize()
	self:RegisterDB('CatererFuDB')
	self:RegisterDefaults('profile', {hiddenCategory = {}})

	self.title = 'Caterer '..GetAddOnMetadata('Caterer', 'Version')
	self.titleWhenTooltipDetached = true
	self.defaultMinimapPosition = 180
	self.hideWithoutStandby = true
	self.clickableTooltip = true

	self.OnMenuRequest = Caterer.options
	local args = AceLibrary('FuBarPlugin-2.0'):GetAceOptionsDataTable(self)
	for k, v in pairs(args) do
		if not self.OnMenuRequest.args[k] then
			self.OnMenuRequest.args[k] = v
		end
	end

	-- fix Shaman class color
	RAID_CLASS_COLORS['SHAMAN'].r = .0
	RAID_CLASS_COLORS['SHAMAN'].g = .44
	RAID_CLASS_COLORS['SHAMAN'].b = .87
end

function CatererFu:OnEnable()
	self:RegisterEvent('BAG_UPDATE', 'OnTextUpdate')
	self:RegisterEvent('Caterer_ITEMS_UPDATE', 'OnTextUpdate')
	self:RegisterEvent('Caterer_OPTIONS_UPDATE', 'OnDataUpdate')
	self:RegisterEvent('Caterer_LIST_UPDATE', 'OnDataUpdate')
	self:RegisterEvent('Caterer_RESETDB', 'OnDataUpdate')
end

function CatererFu:OnTextUpdate()
	if self:IsTooltipDetached() then self:UpdateTooltip() end
	local foodCount = Caterer:GetNumItems(Caterer.db.profile.tradeWhat[1])
	local waterCount = Caterer:GetNumItems(Caterer.db.profile.tradeWhat[2])
	local food = string.format('|cff%s%d|r', Crayon:GetThresholdHexColor(foodCount, 0, 100, 200, 300, 400), foodCount)
	local water = string.format('|cff%s%d|r', Crayon:GetThresholdHexColor(waterCount, 0, 100, 200, 300, 400), waterCount)
	self:SetText(L["Food"]..': '..food..' '..L["Water"]..': '..water)
end

function CatererFu:OnTooltipUpdate()
	if not Caterer:IsActive() then return end
	
	Tablet:SetTitle(self.title)
	Tablet:SetTitleColor(.41, .80, .94)
	local cat1 = Tablet:AddCategory('columns', 2)
	cat1:AddLine('text', L["Food"]..':', 'text2', Caterer.itemTable[1][Caterer.db.profile.tradeWhat[1]], 'func', 'ToggleOptions', 'arg1', self, 'arg2', 'tradeWhat', 'arg3', 1)
	cat1:AddLine('text', L["Water"]..':', 'text2', Caterer.itemTable[2][Caterer.db.profile.tradeWhat[2]], 'func', 'ToggleOptions', 'arg1', self, 'arg2', 'tradeWhat', 'arg3', 2)
	if Caterer.db.profile.tooltip.classes then
		local cat2 = Tablet:AddCategory('columns', 3,
			'text', L["Class settings"],
			'func', 'ToggleOptions', 'arg1', self, 'arg2', 'category', 'arg3', 'classSettings',
			'textR', 1, 'textG', .823529, 'textB', 0,
			'showWithoutChildren', true,
			'checked', true, 'hasCheck', true,
			'checkIcon', self.db.profile.hiddenCategory['classSettings'] and 'Interface\\Buttons\\UI-PlusButton-Up' or 'Interface\\Buttons\\UI-MinusButton-Up'
		)
		if not self.db.profile.hiddenCategory['classSettings'] then
			cat2:AddLine('text', L["Class"], 'text2', L["Food"], 'text3', L["Water"], 'justify3', 'CENTER')
			for class, count in pairs(Caterer.db.profile.tradeCount) do
				local name = Caterer.options.args.filter.args.quantity.args[string.lower(class)].name
				local color = RAID_CLASS_COLORS[class]
				cat2:AddLine('text', name..':', 'textR', color.r, 'textG', color.g, 'textB', color.b, 'text2', count[1], 'text3', count[2] or L["nil"], 'justify3', 'CENTER')
			end
		end
	end
	local cat3 = Tablet:AddCategory('columns', 2)
	for name, v in pairs(Caterer.db.profile.tradeFilter) do
		cat3:AddLine('text', L["Trade with"..' '..name]..':',
			'text2', v and L["On"] or L["Off"],
			'text2R', v and 0 or 1,
			'text2G', v and 1 or 0,
			'text2B', 0,
			'func', 'ToggleOptions', 'arg1', self, 'arg2', 'tradeFilter', 'arg3', name
		)
	end
	local cat4 = Tablet:AddCategory('columns', 2)
	cat4:AddLine('text', L["Whisper requests"]..':',
		'text2', Caterer.db.profile.whisperRequest and L["On"] or L["Off"],
		'text2R', Caterer.db.profile.whisperRequest and 0 or 1,
		'text2G', Caterer.db.profile.whisperRequest and 1 or 0,
		'text2B', 0,
		'func', 'ToggleOptions', 'arg1', self, 'arg2', 'whisperRequest'
	)
	if Caterer.db.profile.tooltip.exceptionList then
		local cat5 = Tablet:AddCategory('columns', 3,
			'text', L["List of exceptions"],
			'func', 'ToggleOptions', 'arg1', self, 'arg2', 'category', 'arg3', 'exceptionList',
			'font', GameTooltipHeaderText,
			'textR', 1, 'textG', .823529, 'textB', 0,
			'showWithoutChildren', true,
			'checked', true, 'hasCheck', true,
			'checkIcon', self.db.profile.hiddenCategory['exceptionList'] and 'Interface\\Buttons\\UI-PlusButton-Up' or 'Interface\\Buttons\\UI-MinusButton-Up'
		)
		if not self.db.profile.hiddenCategory['exceptionList'] then
			if next(Caterer.db.profile.exceptionList) then
				cat5:AddLine('text', L["Player"], 'text2', L["Food"], 'text3', L["Water"], 'justify3', 'CENTER')
				for name, count in pairs(Caterer.db.profile.exceptionList) do
					cat5:AddLine('text', Caterer:FirstToUpper(name), 'textR', .75, 'textG', 1, 'textB', 1, 'text2', count[1], 'text3', count[2], 'justify3', 'CENTER', 'func', 'RemovePlayer', 'arg1', Caterer, 'arg2', name, 'arg3', 'exceptionList')
				end
			else
				cat5:AddLine('text', L["The list is empty."])
			end
		end
	end
	Tablet:SetHint('\n'..L["LeftClick to toggle addon.\nRightClick to open dropdown menu.\nLeftClick on the point tooltip to quickly manage the addon."])
end

function CatererFu:OnDataUpdate()
	if self:IsTooltipDetached() then self:UpdateTooltip() end
end

function CatererFu:OnClick()
	if Caterer:IsActive() then
		getglobal(this:GetName()..'Icon'):SetVertexColor(.3, .3, .3)
		Caterer:ToggleActive(false)
		ChatFrame1:AddMessage('|cff69CCF0Caterer |cffFF0000'..L["disabled"]..'|r.', .41, .80, .94)
		self:UpdateTooltip()
	else
		getglobal(this:GetName()..'Icon'):SetVertexColor(1, 1, 1)
		Caterer:ToggleActive(true)
		ChatFrame1:AddMessage('|cff69CCF0Caterer |cff00FF00'..L["enabled"]..'|r.', .41, .80, .94)
		self:UpdateTooltip()
    end
end

--[[--------------------------------------------------------------------------------
	Shared Functions
-----------------------------------------------------------------------------------]]

function CatererFu:ToggleOptions(arg2, arg3) -- arg1 = self
	local value, curKey, newKey
	if arg2 == 'category' then
		self.db.profile.hiddenCategory[arg3] = not self.db.profile.hiddenCategory[arg3]
		self:UpdateTooltip()
	elseif arg2 == 'tradeFilter' then
		value = Caterer.db.profile[arg2][arg3]
		Caterer.db.profile[arg2][arg3] = not value
	elseif arg2 == 'whisperRequest' then
		value = Caterer.db.profile[arg2]
		Caterer.db.profile[arg2] = not value
	elseif arg2 == 'tradeWhat' then
		curKey = Caterer.db.profile[arg2][arg3]
		newKey, value = next(Caterer.itemTable[arg3], curKey)
		if not newKey then
			newKey, value = next(Caterer.itemTable[arg3])
		end
		Caterer.db.profile[arg2][arg3] = newKey
		self:UpdateText()
	end
end