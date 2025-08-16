_AP_Database = {}

function _AP_Database:Initialize()
end

--- Get character database value
---@param key string
---@return any
function _AP_Database.GetCharValue(key)
  if not AchievementsPlus or not AchievementsPlus.info then return end
  return AchievementsPlusDB["chars"][AchievementsPlus.info.characterKey][key]
end

--- Set character database value
---@param key string
---@param value any|nil
function _AP_Database.SetCharValue(key, value)
  if not AchievementsPlus or not AchievementsPlus.info then return end
  AchievementsPlusDB["chars"][AchievementsPlus.info.characterKey][key] = value
end

--- Get global database value
---@param key string
---@return any|nil
function _AP_Database.GetGlobalValue(key)
end

--- Set global database value
---@param key string
---@param value any
function _AP_Database.SetGlobalValue(key, value)
end

_AP_Database:Initialize()
