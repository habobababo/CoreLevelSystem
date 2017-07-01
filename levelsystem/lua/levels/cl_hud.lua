
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

hook.Add( "HUDPaint", "C_DrawLevel", function()
	local lp = LocalPlayer() or ""
	if lp == "" then return end

	local level = lp:C_GetLevel() or ""
	local xp = lp:C_GetXP() or ""

	if LocalPlayer():Alive() then
			drawBlur( ScrW() - 80 , 80, 80, 32, 3, 6, 255 )
			draw.RoundedBox(0,  ScrW() - 80 , 80, 80, 32, Color(100, 100, 100,160))
			draw.RoundedBox(0,  ScrW() - 80 , 80, xp * 0.80, 32, Color(255, 255, 255,255))
			draw.SimpleText("LVL: " ..level, "Trebuchet24", ScrW() - 70 , 84,  Color(0,0,0,255))
	end
end)
