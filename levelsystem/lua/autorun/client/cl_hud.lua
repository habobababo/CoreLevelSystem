
local blur = Material( "pp/blurscreen" )
local function drawBlur( x, y, w, h, layers, density, alpha )
	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetMaterial( blur )

	for i = 1, layers do
		blur:SetFloat( "$blur", ( i / layers ) * density )
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		render.SetScissorRect( x, y, x + w, y + h, true )
			surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
		render.SetScissorRect( 0, 0, 0, 0, false )
	end
end

local loading = false
timer.Simple(20,function() loading = true end)

local level = "n/a"
local lock = 0
local target = LocalPlayer()
local xp = 0

hook.Add( "HUDPaint", "DrawLevel", function()
	local trace = LocalPlayer():GetEyeTrace().Entity
	
	if loading then
		level = LocalPlayer():GetNWInt("TTT_Level")
		xp = LocalPlayer():GetNWInt("TTT_XP")
	end
	
	if lock == 0 then
		if trace:IsPlayer() then
			lock = 1
			target = trace
			timer.Simple(5, function() lock = 0 end)
			level = target:GetNWInt("TTT_Level")
		end
	end


	
	
	if LocalPlayer():Alive() then
		if GAMEMODE.round_state != 1 then
			drawBlur( ScrW() - 110 , 80, 110, 32, 3, 6, 255 )
			draw.RoundedBox(0,  ScrW() - 73 , 80, 73, 32, Color(100, 100, 100,160))
			draw.RoundedBox(0,  ScrW() - 73 , 80, xp * 0.73, 32, Color(255, 255, 255,255))
			draw.RoundedBox(4,  ScrW() - 110 , 80, 37, 32, Color(255,100, 100,100))
			draw.SimpleText(level, "FontA22", ScrW() - 70 , 84,  Color(0,0,0,255))
			surface.SetMaterial( Material("materials/core/logo32.png") )
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect( ScrW() - 108, 80, 32, 32 )
				
		end
	end
	
	
end)