
C_Level = C_Level or {}
C_Level.Level = C_Level.Level or {}


C_Level.MaxXP = 100
C_Level.MaxLevel = 1000

C_Level.SaveLevelTime = 30


C_Level.XPOverTimeTime = 100 // in seconds
C_Level.MinPlayers = 0
C_Level.XPOverTimeXP = 5


// DO NOT EDIT BELOW HERE //

if SERVER then
  print("loading sadsdsadasdsdasdasdasd")
  include("levels/sv_base.lua")
  AddCSLuaFile("levels/cl_hud.lua")
end
if CLIENT then
  include("levels/cl_hud.lua")
end


local meta = FindMetaTable("Player")
function meta:C_GetLevel()
  return self:GetNWInt("C_LVL")
end

function meta:C_GetXP()
  return self:GetNWInt("C_XP")
end
