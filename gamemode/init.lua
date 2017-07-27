util.AddNetworkString( "popupHelp" )
util.AddNetworkString( "popupTeamSelect" )
util.AddNetworkString( "changeTeam" )

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function GM:PlayerInitialSpawn( ply )
	ply:SetWalkSpeed( Settings.DefaultWalkSpeed )
	ply:SetRunSpeed( Settings.DefaultRunSpeed )
	net.Start( "popupTeamSelect" )
	net.WriteEntity(ply)
	net.Send(ply)
end

function GM:PlayerSpawn ( ply )
	ply:AllowFlashlight( true )
	ply:Give( "weapon_crowbar" )
	ply:SetModel( "models/player/Group02/male_06.mdl" )
	if ply:Team() != 1 then
		ply:KillSilent()
	end
end

function GM:PlayerDeathThink( ply )
	if ply:Team() != 1 then
		return false
	else
		ply:Spawn()
		return true
	end
end

function GM:ShowHelp( ply )
	net.Start( "popupHelp" )
	net.WriteEntity(ply)
	net.Send(ply)
end

function GM:ShowTeam( ply )
	net.Start( "popupTeamSelect" )
	net.WriteEntity(ply)
	net.Send(ply)
end

net.Receive( "changeTeam", function()
	local ply = net.ReadEntity()
	local teamNum = net.ReadUInt( 1 )
	ply:SetTeam( teamNum )
	if teamNum != 1 then
		ply:Spectate( 4 )
	else
		ply:Spawn()
	end
end )