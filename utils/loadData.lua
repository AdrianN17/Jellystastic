local loadData = Class{}

function loadData:init()

end

function loadData:guardarConfiguracion()
    local t = {teclas = _G.teclas, idioma = _G.idioma}
    love.filesystem.write("config.lua",serialize(t))
end 

function loadData:leerConfiguracion()
    if love.filesystem.getInfo("config.lua") then

        local t =love.filesystem.load("config.lua")()

        for i,k in pairs(t) do
            _G[i] = k
        end
    end
end

function loadData:limpiarConfiguracion()
    _G.teclas = {up = "w", down = "s", left="a", right = "d", get = "e", changeWeapon = "q", getBox = "g", pause ="p"}
    _G.idioma = 1

    self:guardarConfiguracion()

end

return loadData