---@class AP_EventManager
local AP_EventManager = AP_ModuleLoader:CreateModule("AP_EventManager")
_AP_EventManager = {}

---@type AP_Timers
local AP_Timers = AP_ModuleLoader:ImportModule("AP_Timers")

---Initialize
function AP_EventManager.Initialize()
  AP_Debug("Event manager initialized")
  AP_Timers:Register(_AP_Timers.IsMovingTimer, 0.2, false, nil, _AP_MainWindow.isMoving)
end
