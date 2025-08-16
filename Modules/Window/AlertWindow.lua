---@class AP_AlertWindow
local AP_AlertWindow = AP_ModuleLoader:CreateModule("AP_AlertWindow")
_AP_AlertWindow = {}

local L = AchievementsPlus.L
local _G = getfenv(0)

function _AP_AlertWindow.i18n(message)
  return L[message]
end

---Show Alert window
function AP_AlertWindow:ShowAlert()
  local alert = CreateFrame("Frame", "AlertFrame", UIParent, "CustomAlertTemplate")
  alert:SetPoint("CENTER", UIParent, 0, 0)
  alert:Show()
end

function _AP_AlertWindow.ShowAlert(message)
  AP_AlertWindow:ShowAlert()
end
