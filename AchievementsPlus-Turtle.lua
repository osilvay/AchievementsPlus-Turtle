AchievementsPlus = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceHook-2.1", "AceConsole-2.0", "AceDB-2.0",
  "AceModuleCore-2.0", "AceDebug-2.0", "Metrognome-2.0")

AchievementsPlus.L = AceLibrary("AceLocale-2.2"):new("AchievementsPlus")

AchievementsPlus:RegisterDB("AchievementsPlusDB")
AchievementsPlus.errorColor = "FFFC6B6B"
AchievementsPlus.warnColor = "FFFFAD6E"
AchievementsPlus.infoColor = "FF86C9FC"
AchievementsPlus.debugColor = "FFFFFF67"
AchievementsPlus.logColor = "FFC1C1C1"
AchievementsPlus.timeColor = "FFB2FC86"
AchievementsPlus.onColor = "FF59EE49"
AchievementsPlus.offColor = "FFF44444"
AchievementsPlus.pausedColor = "FFFFE431"
AchievementsPlus.unknownColor = "FF919191"
AchievementsPlus.versionColor = "FF619191"
AchievementsPlus.textColor = "FFe1e1e1"
AchievementsPlus.addonColor = "FFF8FF6B"
AchievementsPlus.addonName = "AchievementsPlus"
AchievementsPlus.addonVersion = "0.0.1"
AchievementsPlus.addonColoredName = string.format("|c%sAchievements|r |c%sPlus|r", AchievementsPlus.addonColor, AchievementsPlus.addonColor)

function print(message)
  DEFAULT_CHAT_FRAME:AddMessage(message)
end

---Print
---@param message string
---@param withoutHeader? boolean
function AchievementsPlus:Print(message, withoutHeader)
  local finalMessage
  if withoutHeader then
    finalMessage = string.format("%s", message)
  else
    finalMessage = string.format("|c%sAP|r: %s", AchievementsPlus.addonColor, tostring(message))
  end

  DEFAULT_CHAT_FRAME:AddMessage(finalMessage)
end

function AP_Print(message)
  AchievementsPlus:Print(message)
end

---Error message
function AchievementsPlus:Error(message)
  AchievementsPlus:Print(string.format("|c%s[ERROR]|r %s", AchievementsPlus.errorColor, message))
end

function AP_Error(message)
  AchievementsPlus:Error(message)
end

---Warning message
function AchievementsPlus:Warning(message)
  if AchievementsPlus:IsDebugEnabled() then
    AchievementsPlus:Print(string.format("|c%s[WARNING]|r %s", AchievementsPlus.errorColor, message))
  end
end

function AP_Warning(message)
  AchievementsPlus:Warning(message)
end

---Info message
function AchievementsPlus:Info(message)
  if AchievementsPlus:IsDebugEnabled() then
    AchievementsPlus:Print(string.format("|c%s[INFO]|r %s", AchievementsPlus.errorColor, message))
  end
end

function AP_Info(message)
  AchievementsPlus:Info(message)
end

---Debug message
function AchievementsPlus:Debug(message)
  if AchievementsPlus:IsDebugEnabled() then
    if message == nil then message = 'nil' end
    AchievementsPlus:Print(string.format("|c%s[DEBUG]|r %s", AchievementsPlus.errorColor, message))
  end
end

function AP_Debug(message)
  AchievementsPlus:Debug(message)
end

---Log message
function AchievementsPlus:Log(message)
  if AchievementsPlus:IsDebugEnabled() then
    AchievementsPlus:Print(string.format("|c%s[LOG]|r %s", AchievementsPlus.errorColor, message))
  end
end

function AP_Log(message)
  AchievementsPlus:Log(message)
end

---Log message
function AchievementsPlus:Time(message)
  if AchievementsPlus:IsDebugEnabled() then
    AchievementsPlus:Print(string.format("|c%s[TIME]|r %d : %s ", AchievementsPlus.timeColor, GetServerTime(), message))
  end
end

function AP_Time(message)
  AchievementsPlus:Time(message)
end

function AchievementsPlus:Dump(message)
  if AchievementsPlus:IsDebugEnabled() then
    if message == nil then
      AchievementsPlus:Print(string.format("|c%s[DUMP]|r : %s ", AchievementsPlus.unknownColor, "nil"))
    end
    AchievementsPlus:Print(string.format("|c%s[DUMP]|r : ", AchievementsPlus.unknownColor))
    AchievementsPlus:ComposeDump(message, 0)
  end
end

function AP_Dump(message)
  AchievementsPlus:Dump(message)
end

---Compose dump
---@param o table
---@param iteration number
function AchievementsPlus:ComposeDump(o, iteration)
  if o == nil then
    AchievementsPlus:Print("nil", true)
  elseif type(o) == 'table' then
    AchievementsPlus:Print(string.rep(" ", iteration) .. '{', true)
    for k, v in pairs(o) do
      AchievementsPlus:Print(string.rep(" ", iteration) .. '[' .. k .. '] = ', true)
      AchievementsPlus:ComposeDump(v, iteration + 2)
    end
    AchievementsPlus:Print(string.rep(" ", iteration) .. '}', true)
  elseif type(o) == 'string' then
    AchievementsPlus:Print(string.rep(" ", iteration) .. '"' .. tostring(o) .. '"', true)
  else
    AchievementsPlus:Print(string.rep(" ", iteration) .. tostring(o), true)
  end
end

---Check debug enabled
function AchievementsPlus:IsDebugEnabled()
  if _AP_Database.GetCharValue("debug") ~= nil and _AP_Database.GetCharValue("debug") == "on" then
    return true
  end
  return false
end
