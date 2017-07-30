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

local cLabel = {}
local cButton = {}
local cPanel = {}

function cPanel:Init()
	self:SetSize( 300, 500 )
	self:Center()
end

function cPanel:Paint( w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 255 ) )
end

function cPanel:SetTitle( text )
	print(text)
end

vgui.Register( "mainMenu", cPanel, "Panel" )

function GM:Initialize()

end

net.Receive( "popupHelp", function()
	local ply = net.ReadEntity()
	local helpFrame = vgui.Create( "DFrame" )
	helpFrame:SetPos( 0, 0 )
	helpFrame:SetSize( ScrW(), ScrH() )
	helpFrame:SetTitle( "Help" )
	helpFrame:SetVisible( true )
	helpFrame:SetDraggable( false )
	helpFrame:ShowCloseButton( true )
	helpFrame:MakePopup()
	local html = vgui.Create( "HTML", helpFrame )
	html:Dock( FILL )
	html:OpenURL( "https://github.com/Leeous/battlegrounds" )
end )

net.Receive( "popupTeamSelect", function()

	-- local mainMenu = vgui.Create( "mainMenu", nil )

	-- mainMenu.SetTitle("yay")

	local ply = net.ReadEntity()
	local teamSelector = vgui.Create( "DFrame" )
	teamSelector:SetSize( ScrW() * 0.25, ScrH() * 0.50 )
	teamSelector:SetTitle( "Select your team" )
	teamSelector:SetVisible( true )
	teamSelector:SetDraggable( false )
	teamSelector:ShowCloseButton( true )
	teamSelector:MakePopup()
	teamSelector:Center()

	teamSelector.Paint = function()
	surface.SetDrawColor( 50, 50, 50, 255 )
	surface.DrawRect( 0, 0, teamSelector:GetWide(), teamSelector:GetTall() )
	surface.SetDrawColor( 50, 50, 50, 255 )
	surface.DrawOutlinedRect( 0, 0, teamSelector:GetWide(), teamSelector:GetTall() )
	end

	-- local playerList = vgui.Create( "DListView", teamSelector )
	-- playerList:SetPos(300, 50)
	-- playerList:SetSize(ScrW() * 0.30, ScrH() * 0.42)
	-- playerList:SetMultiSelect( false )
	-- playerList:AddColumn( "Name" )
	-- playerList:AddColumn( "Team" )

	-- Change teams
	local changeTeamPlayers = vgui.Create( "DButton", teamSelector )
	changeTeamPlayers:SetText( "Players" )
	changeTeamPlayers:SetPos( 25, 50 )
	changeTeamPlayers:SetSize( teamSelector:GetWide() - 50, 50 )
	changeTeamPlayers.Paint = function()
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawRect( 0, 0, changeTeamPlayers:GetWide(), changeTeamPlayers:GetTall() )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawOutlinedRect( 0, 0, changeTeamPlayers:GetWide(), changeTeamPlayers:GetTall() )
	end
	changeTeamPlayers.DoClick = function()
			changeTeam(1)
			teamSelector:Close()
	end
	local changeTeamSpectators = vgui.Create( "DButton", teamSelector )
	changeTeamSpectators:SetText( "Spectators" )		
	changeTeamSpectators:SetPos( 25, 100 )
	changeTeamSpectators:SetSize( teamSelector:GetWide() - 50, 50 )
	changeTeamSpectators.Paint = function()
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawRect( 0, 0, changeTeamSpectators:GetWide(), changeTeamSpectators:GetTall() )
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawOutlinedRect( 0, 0, changeTeamSpectators:GetWide(), changeTeamSpectators:GetTall() )
	end
	changeTeamSpectators.DoClick = function()
			changeTeam(2)
			teamSelector:Close()
	end

	-- Labels

	local label1 = vgui.Create( "DLabel", teamSelector )
	label1:SetPos( 10, 25 )
	label1:SetSize( 90, 30 )
	label1:SetFont( "Basic" )
	label1:SetText( "Choose a team:" )

	local labelCredit = vgui.Create("DLabel", teamSelector)
	labelCredit:SetPos( 10, teamSelector:GetTall() - 30 )
	labelCredit:SetSize( 200, 30 )
	labelCredit:SetFont( "Credit" )
	labelCredit:SetText( "Created with ♥ by Leeous" )
end ) 

function changeTeam(teamNum)
	sound.Play( "garrysmod/balloon_pop_cute.wav", LocalPlayer():GetPos(), 75, 100, 1 )
	net.Start( "changeTeam" )
	net.WriteEntity(LocalPlayer())
	net.WriteUInt(teamNum, 1)
	net.SendToServer()
end

net.Receive( "messageClient", function()
	local str = net.ReadString()
	chat.AddText(str)
end )