GM.Name = "Battlegrounds"
GM.Author = "Leeous"
GM.Email = "contact@leeous.com"
GM.Website = "http://leeous.com"

Settings = {
	DefaultWalkSpeed = 175,
	DefaultRunSpeed = 275,
	RoundTime = 20, -- Value in minutes
}

function GM:Initialize()
end

-- Setup the teams
team.SetUp( 1, "Player", Color( 125, 125, 125, 255 ) )
team.SetUp( 2, "Spectator", Color( 125, 125, 125, 255 ) )
