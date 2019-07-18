resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

-- UI
ui_page "ui/index.html"
files {
	"ui/index.html",
	"ui/fonts/Circular-Bold.ttf",
	"ui/fonts/Circular-Book.ttf",
	"ui/assets/cursor.png",
	"ui/assets/close.png",
	"ui/front.js",
	"ui/script.js",
	"ui/style.css",
	'ui/debounce.min.js'
}

-- Client Scripts
client_scripts {
		"client.lua",
}
