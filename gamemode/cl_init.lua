include( "shared.lua" )

net.Receive( "popupHelp", function()
	local ply = net.ReadEntity()
	local helpFrame = vgui.Create( "DFrame" )
	helpFrame:SetPos( 0, 0 )
	helpFrame:SetSize( ScrW(), ScrH() )
	helpFrame:SetTitle( "Help" )
	helpFrame:SetVisible( true )
	helpFrame:SetDraggable( true )
	helpFrame:ShowCloseButton( true )
	helpFrame:MakePopup()
	local html = vgui.Create( "HTML", helpFrame )
	html:Dock( FILL )
	html:OpenURL( "https://github.com/Leeous/battlegrounds" )
end )