
resource.AddFile("materials/core/logo32.png")

local function GetLevel(ply)
	if !TTT_C or !TTT_C.Level then return end
	
	local level = ply:GetNWInt("TTT_Level")
	local xp = ply:GetNWInt("TTT_XP")
	ply:SetNWBool("TTT_LEVEL_Loaded", false)
	
	timer.Simple(30, function()
		mysql.query("SELECT * FROM level WHERE steamid = '"..ply:SteamID64().."' ", function(data)
			if data[1] != nil then
				ply:ChatPrint("Level Loaded!")
				ply:SetNWBool("TTT_LEVEL_Loaded", true)
				ply:SetNWInt("TTT_XP", data[1].xp)
				ply:SetNWInt("TTT_Level", data[1].level)	
			else
				ply:SetNWInt("TTT_XP", 1)
				ply:SetNWInt("TTT_Level", 1)

				mysql.query("INSERT INTO level (steamid, level, xp) VALUES ('"..ply:SteamID64().."', '"..level.."', '"..xp.."') ")

			end
		end)
	end)	
end
hook.Add("PlayerAuthed", "GetLevel_Auth",  GetLevel)

local function LevelUp(ply)
	local level = ply:GetNWInt("TTT_Level")
	local xp = ply:GetNWInt("TTT_XP")
	
	if level >= TTT_C.MaxLevel then
		return ply:ChatPrint("Du hast das maximallevel erreicht!")
		
	end

	ply:SetNWInt("TTT_Level", level + 1)
	ply:SetNWInt("TTT_XP", 0)
	ply:ChatPrint("LevelUp!!!")

end

concommand.Add( "levelup", function( ply )
	LevelUp(ply) //DEBUG
end )

local function AddXP(ply, xp)
	local level = ply:GetNWInt("TTT_Level")
	local pxp = ply:GetNWInt("TTT_XP")
	
	ply:SetNWInt("TTT_XP", pxp + xp)
	
	if pxp >= TTT_C.MaxXP then
		LevelUp(ply)
	end
end

local function UpdateLevel()
	for k,v in pairs(player.GetAll()) do
		local level = v:GetNWInt("TTT_Level")
		local xp = v:GetNWInt("TTT_XP")
		if v:GetNWBool("TTT_LEVEL_Loaded") then
			mysql.query("UPDATE level SET level = '"..level.."', xp = '"..xp.."' WHERE steamid = '"..v:SteamID64().."' ")
		end
	end
end
timer.Create("UpdateLevel_Timer", TTT_C.SaveLevelTime, 0, UpdateLevel)

local function XPOverTime()
	if #player.GetAll() > TTT_C.MinPlayers then
		for k,v in pairs(player.GetAll()) do
			if !v:Team() == TEAM_SPEC then
				AddXP(v, TTT_C.XPOverTimeXP)
			end
		end
	end
end
timer.Create("XPOverTime_Timer", TTT_C.XPOverTimeTime, 0, XPOverTime)


local function OnKill(vic, inflictor, attacker)
	local HG = vic:LastHitGroup() // 1 == headshot
	// 0 inno 1 traitor 2 dete
	if attacker:GetRole() == 2 then
		if vic:GetRole() == 1 then
			if HG == 1 then
				AddXP(attacker, TTT_C.HeadShotDkillsT)
			else
				AddXP(attacker, TTT_C.DkillsT)
			end
		end
	elseif attacker:GetRole() == 1 then
		if vic:GetRole() == 2 then
			if HG == 1 then
				AddXP(attacker, TTT_C.HeadShotTkillsD)
			else
				AddXP(attacker, TTT_C.TkillsD)
			end
		end
	elseif attacker:GetRole() == 0 then
		if vic:GetRole() == 1 then
			if HG == 1 then
				AddXP(attacker, TTT_C.HeadShotIkillsT)
			else
				AddXP(attacker, TTT_C.IkillsT)
			end	
		end
	end
end
hook.Add("PlayerDeath", "OnKill_PlayerDeath", OnKill)

