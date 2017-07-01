
local function C_InitialSpawn()
	local level = self:C_GetLevel()
	local xp = self:C_GetXP()
	corequery("SELECT * FROM level WHERE steamid = '"..ply:SteamID64().."' ", function(data)
		if data[1] != nil then
			ply:SetNWInt("C_XP", data[1].xp)
			ply:SetNWInt("C_LVL", data[1].level)
		else
			ply:SetNWInt("C_XP", 1)
			ply:SetNWInt("C_LVL", 1)
			mysql.query("INSERT INTO level (steamid, level, xp) VALUES ('"..ply:SteamID64().."', '"..level.."', '"..xp.."') ")
		end
	end)
end
hook.Add("PlayerInitialSpawn", "C_InitialSpawn",  C_InitialSpawn)

local meta = FindMetaTable("Player")
function meta:C_SaveLevel()
		local level = self:C_GetLevel()
		local xp = self:C_GetXP()
		corequery("UPDATE level SET level = '"..level.."', xp = '"..xp.."' WHERE steamid = '"..v:SteamID64().."' ")
end

function meta:C_LevelUp()
	local level = self:C_GetLevel()
	local xp = self:C_GetXP()

	if level >= TTT_C.MaxLevel then
		return
	end

	self:SetNWInt("C_LVL", level + 1)
	self:SetNWInt("C_XP", 0)

	hook.Run("C_PlayerLevelUP", self, self:GetNWInt("C_LVL"))
  BroadcastLua( "hook.Run( [[C_PlayerLevelUP]], ".. self ..", " .. self:GetNWInt("C_LVL") .. " )" )

end

function meta:C_AddXP(xp)
	if !IsValid(xp) then return end
	local level = self:C_GetLevel()
	local playerxp = self:C_GetXP()

	if playerxp + xp == TTT_C.MaxXP then
		self:C_LevelUp()
	elseif playerxp + xp > TTT_C.MaxXP then
		self:C_LevelUp()
		self:C_AddXP((playerxp + xp) - TTT_C.MaxXP)
	else
		self:SetNWInt("C_XP", playerxp + xp)
	end
	self:C_SaveLevel()
end

function meta:C_SetLevel(level)
	if !IsValid(level) then return end
	self:SetNWInt("C_LVL", level)
end

function meta:C_SetXP(xp)
	if !IsValid(xp) then return end
	self:SetNWInt("C_XP", xp)
end

function meta:C_ResetPlayer()
	self:SetNWInt("C_XP", 0)
	self:SetNWInt("C_LVL", 0)
end

local function C_XPOverTime()
	if #player.GetAll() > TTT_C.MinPlayers then
		for k,v in pairs(player.GetAll()) do
			if !v:Team() == TEAM_SPEC then
				v:C_AddXP(TTT_C.XPOverTimeXP)
			end
		end
	end
end
timer.Create("XPOverTime_Timer", TTT_C.XPOverTimeTime, 0, XPOverTime)
