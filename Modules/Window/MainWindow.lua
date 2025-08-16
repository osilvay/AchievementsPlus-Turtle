---@class AP_MainWindow
local AP_MainWindow = AP_ModuleLoader:CreateModule("AP_MainWindow")
_AP_MainWindow = {}

---@type AP_Categories
local AP_Categories = AP_ModuleLoader:ImportModule("AP_Categories")

local L = AchievementsPlus.L
local _G = getfenv(0)

function _AP_MainWindow.i18n(message)
  return L[message]
end

---Close main window
function _AP_MainWindow.closeMainWindow()
  PlaySoundFile("Interface\\Addons\\AchievementsPlus-Turtle\\Sounds\\CharacterSheetClose.ogg", "master")
  AchievementsPlusHeaderFrame:Hide()
end

---Close main window
function AP_MainWindow:CloseMainWindow()
  if AchievementsPlusHeaderFrame:IsShown() then
    _AP_MainWindow.closeMainWindow()
  end
end

---Show main window
function _AP_MainWindow.showMainWindow()
  PlaySoundFile("Interface\\Addons\\AchievementsPlus-Turtle\\Sounds\\CharacterSheetOpen.ogg", "master")
  AchievementsPlusHeaderFrameAddonName:SetText(string.format("%s |c%sv%s|r", AchievementsPlus.addonColoredName,
    AchievementsPlus.versionColor, AchievementsPlus.addonVersion))
  AchievementsPlusHeaderFrame:Show()
end

function AP_MainWindow:ShowMainWindow()
  if not AchievementsPlusHeaderFrame:IsShown() then
    _AP_MainWindow.showMainWindow()
  end
end
