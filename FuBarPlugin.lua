if not AchievementsPlus then return end

local dewdrop = AceLibrary("Dewdrop-2.0")
local tablet = AceLibrary("Tablet-2.0")

local L = AchievementsPlus.L

AchievementsPlusFu = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "FuBarPlugin-2.0")
AchievementsPlusFu:RegisterDB("AchievementsPlusDB")
AchievementsPlusFu.hasIcon = "Interface\\Addons\\AchievementsPlus-Turtle\\Images\\MiniMap\\achievementsplus"
AchievementsPlusFu.defaultMinimapPosition = 180
AchievementsPlusFu.clickableTooltip = true
AchievementsPlusFu.hideWithoutStandby = true

local fuMenu = {
}

function AchievementsPlusFu:OnClick()
  _AP_MainWindow.showMainWindow()
end

function AchievementsPlusFu:OnTooltipUpdate()
  local title = string.format("%s |c%sv%s|r", AchievementsPlus.addonColoredName, AchievementsPlus.versionColor, AchievementsPlus.addonVersion)
  tablet:SetTitle(title)
  local category = tablet:AddCategory(
    "columns", 2,
    "justify", "LEFT",
    "justify2", "RIGHT",
    "hideBlankLine", true,
    "showWithoutChildren", false,
    "child_textR", 1,
    "child_textG", 1,
    "child_textB", 1
  )
  category:AddLine()
  category:AddLine(
    "text", L["Debug"],
    "text2", AchievementsPlusFu:GetDebug(),
    "func", AchievementsPlusFu.changeDebugMode
  )
  tablet:SetHint(L["Click to open the AchievementsPlus frame."])
end

function AchievementsPlusFu:OnMenuRequest(level, value, x, valueN_1, valueN_2, valueN_3, valueN_4)
  AchievementsPlusFu.createDDMenu(level, value, true)
  if (level == 1) then
    dewdrop:AddLine()
  end
end

---Create Dropdown menu
---@param level string
---@param menu string
---@param skipfirst boolean
function AchievementsPlusFu.createDDMenu(level, menu, skipfirst)
  fuMenu = AchievementsPlusFu.getMenu()
  if (level == 1) then
    for k, v in ipairs(fuMenu["L1"]) do
      if (k == 1 and not skipfirst or k > 1) then
        if (type(v) == "table") then
          dewdrop:AddLine(unpack(v))
        end
      end
    end
  end
end

---Get addon status
function AchievementsPlusFu:GetDebug()
  if _AP_Database.GetCharValue("debug") == nil then _AP_Database.SetCharValue("debug", "off") end
  if _AP_Database.GetCharValue("debug") == "on" then
    return string.format("|c%s%s|r", AchievementsPlus.onColor, "on")
  end
  return string.format("|c%s%s|r", AchievementsPlus.offColor, "off")
end

---Change debug mode
function AchievementsPlusFu.changeDebugMode()
  if _AP_Database.GetCharValue("debug") == nil or _AP_Database.GetCharValue("debug") == "on" then
    _AP_Database.SetCharValue("debug", "off")
  elseif _AP_Database.GetCharValue("debug") == "off" then
    _AP_Database.SetCharValue("debug", "on")
  end
end

---Open main window
function AchievementsPlusFu.showMainWindow()
  AchievementsPlus:ShowMainWindow()
end

---Get menu data
---@return table
function AchievementsPlusFu.getMenu()
  return {
    ["L1"] = {
      {
        "text", string.format("%s |c%sv%s|r", AchievementsPlus.addonColoredName, AchievementsPlus.versionColor, AchievementsPlus.addonVersion),
        "isTitle", true
      },
      {},
      {
        "text", L["Debug"] .. " : " .. AchievementsPlusFu:GetDebug(),
        "notClickable", false,
        "func", AchievementsPlusFu.changeDebugMode,
        "arg1", "toggle",
        "arg2", "debug"
      },
    },
  }
end
