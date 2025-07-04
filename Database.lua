---@class AP_Database
local AP_Database = AP_ModuleLoader:CreateModule("AP_Database")
_AP_Database = {}

function AP_Database:Initialize()
  local realmID, realmName, realmNormalizedRealmName = GetRealmID(), GetRealmName(), GetNormalizedRealmName()
  local name = UnitName("player")
  local className, classFilename, classId = UnitClass("player")
  local raceName, raceFile, raceID = UnitRace("player")
  local level = UnitLevel("player")
  local englishFaction, localizedFaction = UnitFactionGroup("player")
  local locale = GetLocale()
  local key = name .. " - " .. realmName
  local info = {
    realm = realmName,
    realmID = realmID,
    name = name,
    level = level,
    classFilename = classFilename,
    className = className,
    classId = classId,
    raceName = raceName,
    raceFile = raceFile,
    raceID = raceID,
    faction = localizedFaction,
    factionName = englishFaction,
    locale = locale
  }
  --[[
    if AchievementsClassicPlus.db.global.data.characters == nil then AchievementsClassicPlus.db.global.data.characters = {} end
    AchievementsClassicPlus.db.global.data.characters[key] = true
    AchievementsClassicPlus.db.global.data.locale = nil

    if AchievementsClassicPlus.db.global.characters[AchievementsClassicPlus.key] == nil then
      AchievementsClassicPlus.db.global.characters[AchievementsClassicPlus.key] = {
        info = info,
      }
    else
      AchievementsClassicPlus.db.global.characters[AchievementsClassicPlus.key].info = info
    end
    ]]
end

function _AP_Database.GetValue(key, character)
end

function _AP_Database.SetValue(key, value, character)
end

function _AP_Database.GetGlobalValue(key)
end

function _AP_Database.SetGlobalValue(key, value)
end

AP_Database:Initialize()
