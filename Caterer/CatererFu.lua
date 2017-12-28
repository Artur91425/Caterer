--[[---------------------------------------------------------------------------------
	FuBar Plugin
------------------------------------------------------------------------------------]]

if not Caterer then return end

CatererFu = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "FuBarPlugin-2.0")
CatererFu:RegisterDB("CatererDB")

CatererFu.name = "FuBar - CatererFu"
CatererFu.hasNoColor = true
CatererFu.hasIcon = "Interface\\Icons\\Inv_drink_18"
CatererFu.defaultMinimapPosition = 180
CatererFu.hideWithoutStandby = true
CatererFu.cannotDetachTooltip = true
CatererFu.cannotHideText = true
CatererFu.cannotHideIcon = true

CatererFu.OnMenuRequest = Caterer:RegisterOptions()
local args = AceLibrary('FuBarPlugin-2.0'):GetAceOptionsDataTable(CatererFu)
for k,v in pairs(args) do
	if not CatererFu.OnMenuRequest.args[k] then
		CatererFu.OnMenuRequest.args[k] = v
	end
end