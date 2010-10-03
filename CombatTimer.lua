local CombatTimerFrame = CreateFrame("Frame")
local LastTime = GetTime()
local SeparateFrame = nil

local function SpitItOut(self, event, addon)
	if event == "PLAYER_REGEN_DISABLED" then
	    LastTime = GetTime()
	elseif event == "PLAYER_REGEN_ENABLED"  then
		DEFAULT_CHAT_FRAME:AddMessage(format("%s %.2fs", "Last fight's duration:",GetTime()-LastTime))
		if SeparateFrame then
			SeparateFrame:AddMessage(format("%.2f",GetTime()-LastTime))
		end
	elseif event == "ADDON_LOADED" and addon == "CombatTimer" then
        for i=1,NUM_CHAT_WINDOWS do
			if _G["ChatFrame"..i]["name"] == "Combat Times" then
				SeparateFrame = _G["ChatFrame"..i]
			end
		end
    end
end

CombatTimerFrame:SetScript("OnEvent",SpitItOut)
CombatTimerFrame:RegisterEvent("ADDON_LOADED")
CombatTimerFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
CombatTimerFrame:RegisterEvent("PLAYER_REGEN_DISABLED")