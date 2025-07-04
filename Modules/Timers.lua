---@class AP_Timers
local AP_Timers = AP_ModuleLoader:CreateModule("AP_Timers")
_AP_Timers = {}

---@type AP_EventManager
local AP_EventManager = AP_ModuleLoader:ImportModule("AP_EventManager")

local metro = AceLibrary("Metrognome-2.0")

_AP_Timers.InitializeTimer = "AchievementsPlusInitializeTimer"
_AP_Timers.IsMovingTimer = "AchievementsPlusIsMovingTimer"

---Initialize
function AP_Timers:Initialize()
  if (not metro:MetroStatus(_AP_Timers.InitializeTimer)) then
    metro:RegisterMetro(_AP_Timers.InitializeTimer, AP_EventManager.Initialize, 1)
  end
  metro:Start(_AP_Timers.InitializeTimer, 1)
end

---Start metro
---@param metroToStart string
---@param executions number|nil
function AP_Timers:Start(metroToStart, executions)
  if executions ~= nil then
    AP_Debug(string.format("Starting metro: %s with %s executions", metroToStart, tostring(executions)))
  end
  AP_Debug(string.format("Starting metro: %s", metroToStart))
  metro:Start(metroToStart, executions)
end

---Stoping metro
---@param metroToStop string
function AP_Timers:Stop(metroToStop)
  AP_Debug(string.format("Stoping metro: %s", metroToStop))
  metro:Stop(metroToStop)
end

---Register metro
---@param metroToRegister string
---@param interval number
---@param autostart boolean
---@param executions number|nil
---@param fn function
function AP_Timers:Register(metroToRegister, interval, autostart, executions, fn)
  if (not metro:MetroStatus(metroToRegister)) then
    AP_Debug(string.format("Registering metro: %s each %s seconds", metroToRegister, tostring(interval)))
    metro:RegisterMetro(metroToRegister, fn, interval)
  end
  if autostart then
    AP_Timers:Start(metroToRegister, executions)
  end
end

--AP_Timers:Initialize()
