GM.Name = "Battlegrounds"
GM.Author = "Leeous"
GM.Email = "contact@leeous.com"
GM.Website = "http://leeous.com"

-- For documentation on the settings and what they do, go to https://github.com/Leeous/battlegrounds/wiki/Settings-Documentation
Settings = {
	PlyWalkSpeed = 175,
	PlyRunSpeed = 275,
	PlyHealth = 100,
	RoundTime = 20,
	Emotes = true,
	AmmoPickup = true,
	GunPickup = true,
}

-- Setup the teams
team.SetUp( 1, "Players", Color( 125, 125, 125, 255 ) )
team.SetUp( 2, "Spectators", Color( 125, 125, 125, 255 ) )
