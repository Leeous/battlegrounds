GM.Name = "Battlegrounds"
GM.Author = "Leeous"
GM.Email = "contact@leeous.com"
GM.Website = "http://leeous.com"

Settings = {
	DefaultWalkSpeed = 175,
	DefaultRunSpeed = 275,
	RoundTime = 20, -- Value in minutes
}

-- Setup the teams
team.SetUp( 1, "Players", Color( 125, 125, 125, 255 ) )
team.SetUp( 2, "Spectators", Color( 125, 125, 125, 255 ) )
