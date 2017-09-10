--[[
This whole script is all over the place. I'll clean it soonish.
]]--

include( "shared.lua" )

surface.CreateFont( "Basic", {
	font = "Trebuchet",
	extended = false,
	size = 13,
	weight = 50,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "Credit", {
	font = "Trebuchet",
	extended = false,
	size = 13,
	weight = 50,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = true,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

function GM:Initialize()

end

function GM:PlayerSpawn()

end

net.Receive( "messageClient", function()
	local str = net.ReadString()
	chat.AddText(str)
end )

concommand.Add("changeteam",function(ply, cmd, args)
	sound.Play( "garrysmod/balloon_pop_cute.wav", LocalPlayer():GetPos(), 75, 100, 1 )
	net.Start( "changeTeam" )
	local teamNum = args[1]
	net.WriteEntity(LocalPlayer())
	net.WriteUInt(teamNum, 1)
	net.SendToServer()
end)