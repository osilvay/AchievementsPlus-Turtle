local L = AchievementsPlus.L
local dewdrop = AceLibrary:GetInstance("Dewdrop-2.0")
local ddframe
local options = {
  type = 'group',
  args = {
    show = {
      type = 'execute',
      name = L['show'],
      desc = L["Open main window"],
      func = function()
        _AP_MainWindow.showMainWindow()
      end
    },
    config = {
      type = 'execute',
      name = L['settings'],
      desc = L["Open settings window"],
      func = function()
        AchievementsPlus:OpenDropdownMenu()
      end
    },
    debug = {
      type = "text",
      name = "debug",
      desc = L["Enable/Disable debug"],
      get = function()
        local debug = _AP_Database.GetCharValue("debug")
        if debug == "on" then
          return "|c" .. AchievementsPlus.onColor .. debug .. "|r"
        else
          return "|c" .. AchievementsPlus.offColor .. debug .. "|r"
        end
      end,
      set = function(v)
        _AP_Database.SetCharValue("debug", v)
      end,
      validate = { "off", "on" },
      order = -2,
    }
  }
}
AchievementsPlus:RegisterChatCommand({ "/AchievementsPlus", "/aplus" }, options, "ACHIEVEMENTSPLUS")

---Open dropdown menu
function AchievementsPlus:OpenDropdownMenu()
  if not ddframe then
    ddframe = CreateFrame("Frame", nil, UIParent)
    ddframe:SetWidth(2)
    ddframe:SetHeight(2)
    ddframe:SetPoint("BOTTOMLEFT", GetCursorPosition())
    ddframe:SetClampedToScreen(true)
    dewdrop:Register(ddframe, 'dontHook', true, 'children', AchievementsPlusFu.createDDMenu)
  end
  local x, y = GetCursorPosition()
  ddframe:SetPoint("BOTTOMLEFT", x / UIParent:GetScale(), y / UIParent:GetScale())
  dewdrop:Open(ddframe)
end
