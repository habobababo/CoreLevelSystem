
local function C_InitialSpawn(ply)
	local level = 1
	local xp = 0
	ply.C_Init = false
	corequery( "SELECT * FROM level WHERE steamid = '" .. ply:SteamID64() .. "' ", function(data)
		if data[1] != nil then
			ply:SetNWInt("C_XP", tonumber(data[1].xp))
			ply:SetNWInt("C_LVL", tonumber(data[1].level))
			ply.C_Init = true
		else
			ply:SetNWInt("C_XP", 1)
			ply:SetNWInt("C_LVL", 1)
			corequery( "INSERT INTO level (steamid, level, xp) VALUES ('" .. ply:SteamID64() .. "', " .. level .. ", " .. xp .. ") ")
			ply.C_Init = true
		end
	end)
end
hook.Add("PlayerInitialSpawn", "C_InitialSpawn",  C_InitialSpawn)

local meta = FindMetaTable("Player")
function meta:C_SaveLevel()
		local level = self:C_GetLevel()
		local xp = self:C_GetXP()
		corequery( "UPDATE level SET level = " .. level .. ", xp = " .. xp .. " WHERE steamid = '" .. self:SteamID64() .. "' ")
end

function meta:C_LevelUp()
	local level = self:C_GetLevel()
	if !self.C_Init then return end
	if level >= C_Level.MaxLevel then
		return
	end
	self:SetNWInt("C_LVL", level + 1)
	self:SetNWInt("C_XP", 0)
	self:PS2_AddStandardPoints(200, "+200 Points for LevelUp.")
	self:EmitSound( "core/levelup.wav" )
	hook.Run("C_PlayerLevelUP", self, self:GetNWInt("C_LVL"))
	self:C_SaveLevel()
	for k,v in pairs(player.GetAll()) do
		v:PlayerMsg(Color(230, 210, 40),"[SURF] ",Color(255,100,100), self:Nick(), Color(255,255,255), " has a levelup!")
	end
end

function meta:C_AddXP(xp)
	if !self.C_Init then return end
	local playerxp = self:C_GetXP()
	if playerxp + xp == C_Level.MaxXP then
		self:C_LevelUp()
	elseif playerxp + xp > C_Level.MaxXP then
		self:C_LevelUp()
		self:C_AddXP((playerxp + xp) - C_Level.MaxXP)
	else
		self:SetNWInt("C_XP", playerxp + xp)
	end
	self:C_SaveLevel()
end

function meta:C_SetLevel(level)
	if !IsValid(level) then return end
	self:SetNWInt("C_LVL", level)
	self:C_SaveLevel()
end

function meta:C_SetXP(xp)
	if !IsValid(xp) then return end
	self:SetNWInt("C_XP", xp)
end

function meta:C_ResetPlayer()
	self:SetNWInt("C_XP", 0)
	self:SetNWInt("C_LVL", 0)
end
