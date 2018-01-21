--[[---------------------------------------------------------------------------------
	FuBar Plugin
------------------------------------------------------------------------------------]]

local L = AceLibrary('AceLocale-2.2'):new('Caterer')
local Tablet = AceLibrary('Tablet-2.0')

CatererFu = AceLibrary('AceAddon-2.0'):new('AceDB-2.0', 'FuBarPlugin-2.0')
CatererFu:RegisterDB('CatererDB')

CatererFu.title = 'FuBar - Caterer '..GetAddOnMetadata('Caterer', 'Version')
CatererFu.hasNoColor = true
CatererFu.hasIcon = 'Interface\\Icons\\Inv_drink_18'
CatererFu.defaultMinimapPosition = 180
CatererFu.hideWithoutStandby = true
CatererFu.cannotDetachTooltip = true
CatererFu.cannotHideText = true
CatererFu.cannotHideIcon = true

CatererFu.OnMenuRequest = Caterer.options
local args = AceLibrary('FuBarPlugin-2.0'):GetAceOptionsDataTable(CatererFu)
for k, v in pairs(args) do
	if not CatererFu.OnMenuRequest.args[k] then
		CatererFu.OnMenuRequest.args[k] = v
	end
end

-- fix Shaman class color
RAID_CLASS_COLORS['SHAMAN'].r = 0.0
RAID_CLASS_COLORS['SHAMAN'].g = 0.44
RAID_CLASS_COLORS['SHAMAN'].b = 0.87

function CatererFu:OnTooltipUpdate()
	Tablet:SetHint(L["LeftClick to disable addon."])
	local cat1 = Tablet:AddCategory('columns', 3, 'text', ' ')
		cat1:AddLine('text', L["Class"], 'text2', L["Food"], 'text3', L["Water"])
	for class, v in pairs(Caterer.db.profile.tradeCount) do
		local name = Caterer.options.args.filter.args.quantity.args[string.lower(class)].name
		cat1:AddLine('text', name..':', 'textR', RAID_CLASS_COLORS[class].r, 'textG', RAID_CLASS_COLORS[class].g, 'textB',  RAID_CLASS_COLORS[class].b, 'text2', v[1], 'text3', v[2] or L["nil"])
	end
	local cat2 = Tablet:AddCategory('columns', 2)
	for k, v in pairs(Caterer.db.profile.tradeFilter) do
		cat2:AddLine('text', L["Trade with"..' '..k]..':', 'text2', self:GetStatus(v))
	end
	local cat3 = Tablet:AddCategory('columns', 2)
	cat3:AddLine('text', L["Whisper requests"]..':', 'text2', self:GetStatus(Caterer.db.profile.whisperRequest))
end

function CatererFu:OnClick()
	if Caterer:IsActive() then
		Caterer:ToggleActive(false)
		getglobal(this:GetName()..'Icon'):SetVertexColor(0.5, 0.5, 0.5, 1)
	else
		Caterer:ToggleActive(true)
		getglobal(this:GetName()..'Icon'):SetVertexColor(1, 1, 1, 1)
    end
end

function CatererFu:GetStatus(value)
	if value then
		return '|CFF00FF00'..L["On"]..'|r'
	else
		return '|CFFFF0000'..L["Off"]..'|r'
	end
end