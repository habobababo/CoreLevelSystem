
function ulx.c_levelup( calling_ply, target_plys, should_silent )

	for k,v in pairs( target_plys ) do
		v:C_LevelUp()
	end

	if should_silent then
		ulx.fancyLogAdmin( calling_ply, true, "#A gave #T a levelup", target_plys, entity )
	else
		ulx.fancyLogAdmin( calling_ply, "#A gave #T a levelup", target_plys, entity )
	end

end
local level = ulx.command( "Core_Level", "ulx levelup", ulx.c_levelup, "!levelup" )
level:addParam{ type = ULib.cmds.PlayersArg }
level:addParam{ type = ULib.cmds.BoolArg, invisible = true }
level:defaultAccess( ULib.ACCESS_ADMIN )
level:help( "" )

function ulx.c_resetlevel( calling_ply, target_plys, should_silent )

	for k,v in pairs( target_plys ) do
		v:C_ResetPlayer()
	end

	if should_silent then
		ulx.fancyLogAdmin( calling_ply, true, "#A set #T level to zero", target_plys, entity )
	else
		ulx.fancyLogAdmin( calling_ply, "#A set #T level to zero", target_plys, entity )
	end

end
local reset = ulx.command( "Core_Level", "ulx resetlevel", ulx.c_resetlevel, "!resetlevel" )
reset:addParam{ type = ULib.cmds.PlayersArg }
reset:addParam{ type = ULib.cmds.BoolArg, invisible = true }
reset:defaultAccess( ULib.ACCESS_ADMIN )
reset:help( "" )
