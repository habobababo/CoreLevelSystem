
ITEM.Name = 'Regeneration'
ITEM.Price = 200
ITEM.Model = 'models/props_c17/SuitCase_Passenger_Physics.mdl'


function ITEM:OnEquip(ply, modifications)
	ply:SetNWBool("regen", true)
end

function ITEM:OnHolster(ply)
	ply:SetNWBool("regen", false)
end

local function regen()
	local heal 
	
	for k,v in pairs(player.GetAll()) do
		if v:GetNWBool("regen") then
			local level = v:GetNWInt("TTT_Level")
			heal = level / 100
			if heal < 1 then heal = 1 end
			if heal > 5 then heal = 5 end
			if v:Health() <= 150 then
				v:SetHealth(v:Health() + heal)
			end
		end
	end
	

end
timer.Create("regentimer", 30,0, function() regen() end)
