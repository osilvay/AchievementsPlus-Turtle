---@class AP_CommonFunctions
local AP_CommonFunctions = AP_ModuleLoader:CreateModule("AP_CommonFunctions")

---Check if table contains value
---@param table table
---@param value any
---@return boolean
function AP_CommonFunctions:TableHasValue(table, value)
  for _, v in pairs(table) do
    if v == value then
      return true
    end
  end
  return false
end

---Check if table contains key
---@param table table
---@param key any
---@return boolean
function AP_CommonFunctions:TableHasKey(table, key)
  for k, _ in pairs(table) do
    if k == key then
      return true
    end
  end
  return false
end

---Get class color
---@param classFilename string
---@return number
---@return number
---@return number
---@return string
function GetClassColor(classFilename)
  local color = RAID_CLASS_COLORS[string.upper(classFilename)];
  if color then
    return color.r, color.g, color.b, color.colorStr;
  end
  return 1, 1, 1, "ffffffff";
end

---Get creature difficulty color
---@param level number
---@return string
function GetCreatureDifficultyColor(level)
  return GetRelativeDifficultyColor(UnitLevel("player"), level);
end

QuestDifficultyColors = {
  ["impossible"]    = "ffff3010",
  ["verydifficult"] = "ffff8040",
  ["difficult"]     = "ffffff00",
  ["standard"]      = "ff40c040",
  ["trivial"]       = "ff808080",
};

ItemQualityColors = {
  [0] = "ff9d9d9d",
  [1] = "ffffffff",
  [2] = "ff1eff00",
  [3] = "ff0070dd",
  [4] = "ffa335ee",
  [5] = "ffff8000",
  [6] = "ffe6cc80",
  [7] = "ffe6cc80",
  [8] = "ff00ccff"
}
