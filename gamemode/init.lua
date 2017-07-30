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
	ply:SetWalkSpeed( Settings.DefaultWalkSpeed )
	ply:SetRunSpeed( Settings.DefaultRunSpeed )
	net.Start( "popupTeamSelect" )
	net.WriteEntity(ply)
	net.Send(ply)
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