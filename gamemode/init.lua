util.AddNetworkString( "popupHelp" )

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function GM:ShowHelp( ply )
	net.Start( "popupHelp" )
	net.WriteEntity(ply)
	net.Send(ply)
end