---@class AP_EventManager
local AP_EventManager = AP_ModuleLoader:CreateModule("AP_EventManager")
_AP_EventManager = {}

---@type AP_Timers
local AP_Timers = AP_ModuleLoader:ImportModule("AP_Timers")

---@type AP_AlertWindow
local AP_AlertWindow = AP_ModuleLoader:ImportModule("AP_AlertWindow")

local defaults_realm = {
  chars = {},
  global = {},
  version = nil
}
local defaults_char = {
  info = {},
  debug = "off"
}

---Initialize
function AP_EventManager.Initialize()
  AP_Debug("AP_EventManager.Initialize")
  AP_EventManager:DatabaseSetup()
  AP_AlertWindow:ShowAlert()
end

function AP_EventManager:DatabaseSetup()
  local realmName = GetRealmName()
  local name = UnitName("player")
  local className, classFilename, classId = UnitClass("player")
  local raceName = UnitRace("player")
  local level = UnitLevel("player")
  local factionName = UnitFactionGroup("player")
  local locale = GetLocale()
  local charKey = name .. " of " .. realmName
  local realmKey = realmName .. " - " .. factionName
  local info = {
    realmName = realmName,
    name = name,
    level = level,
    className = className,
    classFilename = classFilename,
    classId = classId,
    raceName = raceName,
    factionName = factionName,
    locale = locale,
    characterKey = charKey,
    realmKey = realmKey
  }
  AchievementsPlus.info = info

  if not AchievementsPlusDB["realms"] then
    AchievementsPlusDB["realms"] = {}
  end
  if not AchievementsPlusDB["realms"][realmKey] then
    AchievementsPlusDB["realms"][realmKey] = defaults_realm
  end

  if not AchievementsPlusDB["chars"] then
    AchievementsPlusDB["chars"] = {}
  end
  if not AchievementsPlusDB["chars"][charKey] then
    AchievementsPlusDB["chars"][charKey] = defaults_char
  end

  AchievementsPlusDB["realms"][realmKey]["version"] = AchievementsPlus.addonVersion
  AchievementsPlusDB["realms"][realmKey]["chars"][charKey] = true
  AchievementsPlusDB["chars"][charKey].info = info
end
