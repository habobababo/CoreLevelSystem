
ITEM.Name = 'Lifesteal'
ITEM.Price = 200
ITEM.Model = 'models/props_c17/SuitCase_Passenger_Physics.mdl'


function ITEM:OnEquip(ply, modifications)
	ply:SetNWBool("lifesteal", true)
end

function ITEM:OnHolster(ply)
	ply:SetNWBool("lifesteal", false)
end

local function Lifesteal(target, dmginfo)
	if !IsValid(target) then return end
	
	if dmginfo:GetAttacker():GetNWBool("lifesteal") then
		local attacker = dmginfo:GetAttacker()
		local dmg = 0
		if attacker:IsPlayer() then
			if !target:Alive() then return end
			dmg = dmginfo:GetDamage()
			local health = attacker:Health()
			if health > 150 then return end
			attacker:SetHealth(attacker:Health() + dmg * (attacker:GetNWInt("TTT_XP") / 1000))
		end
	end
	

end
hook.Add("EntityTakeDamage", "Vamp_EntityTakeDamage", Lifesteal)
