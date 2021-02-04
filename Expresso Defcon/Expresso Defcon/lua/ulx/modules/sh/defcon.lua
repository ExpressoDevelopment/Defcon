function ulx.defcon( calling_ply, defconvalue )

	SetGlobalInt("Defcon System", defconvalue )

	ulx.fancyLogAdmin( calling_ply, "#A set the current defcon to #s ", "DEFCON "..defconvalue )

	net.Start("DefconChange")
	net.WriteUInt(defconvalue,16)
	net.Broadcast()

end
local defcon = ulx.command( "Defcon System", "ulx defcon", ulx.defcon, "!defcon" )
-- defcon:addParam{ type=ULib.cmds.PlayersArg }
defcon:addParam{ type=ULib.cmds.NumArg, default=5, hint="Defcon Level", min=1, max=5, ULib.cmds.round }
defcon:defaultAccess( ULib.ACCESS_ADMIN )
defcon:help( "Sets serverwide defcon." )