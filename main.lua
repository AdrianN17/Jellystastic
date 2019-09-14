local Gamestate = require "libs.gamestate"
local menu= require "gamestate.menu"

local Spritesheet=require "assets.img.imagedata"

function love.load()
	_G.spritesheet= Spritesheet
	Gamestate.registerEvents()
	Gamestate.switch(menu)
end

--[[local json = require "libs.json"
local http = require "socket.http"

function love.load()
	local dato=1

	--http://localhost/webservice/obtener_usuarios.php?dato=1

	json_data=http.request("http://localhost/webservice/obtener_usuarios.php?dato=" .. dato)
b
	--local encode = json:encode (t)
	--print (encode) 

	local decode = json:decode( json_data )

	print(decode.NOMBRE)




end
]]