
C_Level = C_Level or {}

C_Level.MaxXP = 100
C_Level.MaxLevel = 1000
C_Level.SaveLevelTime = 30
C_Level.XPOverTimeTime = 100 // in seconds
C_Level.MinPlayers = 0
C_Level.XPOverTimeXP = 5


// DO NOT EDIT BELOW HERE //

if SERVER then
  resource.AddFile("sound/core/levelup.wav")
  include("levels/sv_main.lua")
  AddCSLuaFile("levels/cl_main.lua")
end
if CLIENT then
  include("levels/cl_main.lua")
end


local meta = FindMetaTable("Player")
function meta:C_GetLevel()
  return self:GetNWInt("C_LVL")
end

function meta:C_GetXP()
  return self:GetNWInt("C_XP")
end

function meta:C_XPLeft()
  return (C_Level.MaxXP - self:C_GetXP())
end
