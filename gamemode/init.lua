-- Cache all network strings for later use
util.AddNetworkString( "popupHelp" )
util.AddNetworkString( "popupTeamSelect" )
util.AddNetworkString( "changeTeam" )
util.AddNetworkString( "messageClient" )

-- Sent client files to the client
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

-- Run shared Lua whatnots
include( "shared.lua" )

-- Setup default player loadout
function GM:PlayerInitialSpawn( ply )
	ply:SetWalkSpeed( Settings.PlyWalkSpeed )
	ply:SetRunSpeed( Settings.PlyRunSpeed )
	ply:SetHealth( Settings.PlyHealth )
	message_the_client(ply, "Team menu disabled for now - too messy. Use changeteam 1 in console.")
end

-- Ensure player spawns every time with the default loadout
function GM:PlayerSpawn ( ply )
	ply:AllowFlashlight( true )
	ply:Give( "weapon_crowbar" )
	ply:Give( "weapon_physcannon" )
	ply:Give( "weapon_shotgun" )
	ply:SetModel( "models/player/Group02/male_06.mdl" )
	if ply:Team() != 1 then
		ply:KillSilent()
	end
end
 
-- [this is going to be changed very soon ] --
function GM:PlayerDeathThink( ply )
	if ply:Team() != 1 then
		return false
	else
		ply:Spawn()
		return true
	end
end

-- Sent net message to client to run the help menu
function GM:ShowHelp( ply )
	net.Start( "popupHelp" )
	net.WriteEntity(ply)
	net.Send(ply)
end

-- This is used for the 'main menu'... for now
function GM:ShowTeam( ply )
	net.Start( "popupTeamSelect" )
	net.WriteEntity(ply)
	net.Send(ply)
end

-- Change the players team
net.Receive( "changeTeam", function()
	local ply = net.ReadEntity()
	local teamNum = net.ReadUInt( 1 )

	-- Check if player is already on that team.
	if ply:Team() == teamNum then
		message_the_client(ply, "You're already on that team.")
	else
		ply:SetTeam( teamNum )
		ply:Spawn()
	end
end )

-- Custom function, used whenever we need to alert the client of something
function message_the_client( ply, str )
	net.Start( "messageClient" )
	net.WriteString(str)
	net.Send(ply)
end

-- Create command line functions for server user
concommand.Add( "bg", function( ply, cmd, args )
	local command = args[1]
	local cHighlight = Color(33, 255, 0)
	local cText = Color(155, 155, 155)
	
	if args[1] == nil then
		MsgC( Color( 33, 255, 0 ), "[BG] " )
		MsgC( Color( 255, 255, 255 ), "This is the command line argument for Battlegrounds. Use \"bg help\" to display all possible commands.\n" )
	end

	if args[1] == "clear" then
		MsgC( Color( 33, 255, 0 ), "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" )
	end

	if command == "help" then
		MsgC( cHighlight, "\n[BG] ")
		MsgC( cText, "Listing all commands.\n")
		MsgC( Color(155, 155, 155), "[] = required. () = optional.\n")
		MsgC( cText,    "+-------------------------------+--------------------------+\n| bg help                       |     Shows this menu.     |\n+-------------------------------+--------------------------+\n| bg clear                      |   \"Clears\" the console.  |\n+-------------------------------+--------------------------+\n| bg changeteam [player] [team] | Changes a player's team. |\n+-------------------------------+--------------------------+\n")
	end

end )