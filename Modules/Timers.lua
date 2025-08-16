---@class AP_Timers
local AP_Timers = AP_ModuleLoader:CreateModule("AP_Timers")
_AP_Timers = {}

---@type AP_EventManager
local AP_EventManager = AP_ModuleLoader:ImportModule("AP_EventManager")

local metro = AceLibrary("Metrognome-2.0")

function AP_Timers:Initialize()
  DEFAULT_CHAT_FRAME:AddMessage("AP_Timers:Initialize()")
  if (not metro:MetroStatus("AchievementsPlusInitializerTimer")) then
    metro:RegisterMetro("AchievementsPlusInitializerTimer", AP_EventManager.Initialize, 3)
  end
  metro:Start("AchievementsPlusInitializerTimer", 1)
end

---Start metro
---@param metroToStart string
---@param executions number|nil
function AP_Timers:Start(metroToStart, executions)
  metro:Start(metroToStart, executions)
end

---Stoping metro
---@param metroToStop string
function AP_Timers:Stop(metroToStop)
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
    metro:RegisterMetro(metroToRegister, fn, interval)
  end
  if autostart and executions ~= nil then
    AP_Timers:Start(metroToRegister, executions)
  elseif autostart and executions == nil then
    AP_Timers:Start(metroToRegister)
  end
end

---Metro status
---@param registeredMetro string
function AP_Timers:Status(registeredMetro)
  local registered, rate, running, limit, elapsed = metro:Status(registeredMetro)
  AP_Debug("registered = " .. tostring(registered))
  AP_Debug("rate = " .. tostring(rate))
  AP_Debug("running = " .. tostring(running))
  AP_Debug("limit = " .. tostring(limit))
  AP_Debug("elapsed = " .. tostring(elapsed))
end

function _AP_Timers.Status(registeredMetro)
  AP_Timers:Status(registeredMetro)
end

--_AP_Timers.Status(_AP_EventManager.ProcessTimer)
AP_Timers:Initialize()
