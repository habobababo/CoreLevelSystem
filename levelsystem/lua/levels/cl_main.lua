
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
			drawBlur( 0 , ScrH() - 175, 150, 30, 3, 6, 255 )
			draw.RoundedBox(0,  0 , ScrH() - 175, 150, 30, Color(0, 0, 0,100))
			draw.RoundedBox(0,  4 , ScrH() - 172, 142, 24, Color(0, 0, 0,100))
			draw.RoundedBox(0,  4 , ScrH() - 172, xp * 1.42, 24, Color(0, 180, 180,100))

			draw.SimpleText("LVL: " ..level, "Trebuchet24", 10 , ScrH() - 172 + 1,  Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
			draw.SimpleText(xp.."/"..C_Level.MaxXP, "Trebuchet24", 145 , ScrH() - 172 + 1,  Color(255,255,255,100), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
	end

end)
