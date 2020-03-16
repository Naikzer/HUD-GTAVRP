-- Manifest Version
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

-- Functions exported
-- Use: exports.target:Target(Distance, Ped)
export "Target"				

-- Client Scripts
client_scripts {
	'client.lua',
}

-- Server Scripts
server_scripts {
	'@mysql-async/lib/MySQL.lua',     	-- MySQL init
}
