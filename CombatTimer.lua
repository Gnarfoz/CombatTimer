local CombatTimerFrame = CreateFrame("Frame")
local LastTime = GetTime()
local SeparateFrame = nil
local text

if GetLocale() == "deDE" then
	text = "Kampfdauer:"
elseif GetLocale() == "zhCN" then
    text = "战斗耗时:"
elseif GetLocale() == "zhTW" then
    text = "戰鬥耗時:"
else
	text = "Fight duration:"
end

local function SpitItOut(self, event, addon)
	if event == "PLAYER_REGEN_DISABLED" then
	    LastTime = GetTime()
	elseif event == "PLAYER_REGEN_ENABLED"  then
		DEFAULT_CHAT_FRAME:AddMessage(format("%s %.2fs", text, GetTime()-LastTime))
		if SeparateFrame then
			SeparateFrame:AddMessage(format("%.2f", GetTime()-LastTime))
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
