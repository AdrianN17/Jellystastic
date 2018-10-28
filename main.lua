local Gamestate = require "libs.gamestate"
local nivel1_1= require "gamestate.nivel1_1"
local nivel1_2= require "gamestate.nivel1_2"

function love.load()
	
	Gamestate.registerEvents()
	Gamestate.switch(nivel1_1)
end

--[[
-- controles
-- asdw para moverse
-- e para entrar a las puertas
-- click balas 1 normal 2 destruye
]]

-- hacer que cuando suelte no se mueve
function love.run()
if love.math then
	love.math.setRandomSeed(os.time())
end

if love.load then love.load(arg) end

-- We don't want the first frame's dt to include time taken by love.load.
if love.timer then love.timer.step() end

local dt = 0

-- Main loop time.
while true do
	-- Process events.
	local startT = love.timer.getTime()
	if love.event then
		love.event.pump()
		for name, a,b,c,d,e,f in love.event.poll() do
			if name == "quit" then
				if not love.quit or not love.quit() then
					return a
				end
			end
			love.handlers[name](a,b,c,d,e,f)
		end
	end

	-- Update dt, as we'll be passing it to update
	if love.timer then
		love.timer.step()
		dt = love.timer.getDelta()
	end

	-- Call update and draw
	if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled

	if love.graphics and love.graphics.isActive() then
		love.graphics.clear(love.graphics.getBackgroundColor())
		love.graphics.origin()
		if love.draw then love.draw() end
		love.graphics.present()
	end

	if love.timer then
		local endT = love.timer.getTime()
		love.timer.sleep( 1/60 - (endT - startT))
	end
end
 
end

--[[

falta colision en laterial, destruccion y ademas que cambie
crear ruta alterna en el 1_1

encapsular en una funcion el proceso de lectura de datos para entidades

]]