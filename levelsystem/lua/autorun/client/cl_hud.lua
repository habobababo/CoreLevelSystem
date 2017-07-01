
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

local level = "n/a"
local target = LocalPlayer()
if IsValid(target) then target.lock = false end
local xp = 0

hook.Add( "HUDPaint", "C_DrawLevel", function()
	local trace = LocalPlayer():GetEyeTrace().Entity

	if loading then
		level = LocalPlayer():C_GetLevel()
		xp = LocalPlayer():C_GetXP()
	end

	if !target.lock then
		if trace:IsPlayer() then
			target = trace
			target.lock = true
			timer.Simple(5, function() target.lock = false end)
			level = target:C_GetLevel()
		end
	end

	if LocalPlayer():Alive() then
			drawBlur( ScrW() - 110 , 80, 110, 32, 3, 6, 255 )
			draw.RoundedBox(0,  ScrW() - 73 , 80, 73, 32, Color(100, 100, 100,160))
			draw.RoundedBox(0,  ScrW() - 73 , 80, xp * 0.73, 32, Color(255, 255, 255,255))
			draw.RoundedBox(4,  ScrW() - 110 , 80, 37, 32, Color(255,100, 100,100))
			draw.SimpleText(level, "Trebuchet22", ScrW() - 70 , 84,  Color(0,0,0,255))
	end
end)
