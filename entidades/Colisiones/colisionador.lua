local colisionador = Class{}

function colisionador:init()

    self.listaColisiones = {
        player = require "entidades.Colisiones.colisionesPlayer"(),
        enemigo = require "entidades.Colisiones.colisionesEnemigo"(),
        meteorito = require "entidades.Colisiones.colisionesMeteorito"(),
        baba = require "entidades.Colisiones.colisionesBaba"(),
        bala = require "entidades.Colisiones.colisionesBala"(),
        movible = require "entidades.Colisiones.colisionesMovible"(),
        liquido = require "entidades.Colisiones.colisionesLiquido"()
    }

end

function colisionador:execute(nombreColisionador,tipoColision,coll,target,this)

    if target and this then
        self:llamar(coll,target,this,self.listaColisiones[nombreColisionador][tipoColision])
    end
end

function colisionador:llamar(coll,target,this,tabledata)

    for _,data in ipairs(tabledata) do
        local validador = false

        if data["parametroObj"] then
            validador = self:parametros(data["parametroObj"],target)
        end

        if data["parametroSelf"] then
            validador = self:parametros(data["parametroSelf"],this)
        end

        if data["comparacion"] then
            validador = self:comparacion(data["comparacion"],target,this)
        end

        if data["check"] then 
            validador = self:check(data["check"],target,this)
        end

        if data["parametroFunction"] then
            validador = data["parametroFunction"](coll,target,this)
        end

        if validador then
            data["callback"](coll,target,this)
        end


    end

end

function colisionador:parametros(dataValues,obj)
    local validador = false

    for _,data in ipairs(dataValues) do
        validador = obj[data[1]] == data[2]
    end

    return validador

end


function colisionador:comparacion(dataValues,target,this)
    local validador = false

    for _, data in ipairs(dataValues) do

        validador = (target[data[1]] == this[data[1]]) == data[2]

    end

    return validador
end

function colisionador:check(dataValues,target,this)
    local validador = false

    for _, data in ipairs(dataValues) do

        if type(target[data.target]) == "string" and type(this[data.this]) == "table" then

            validador = checkStringInTable(target[data.target],this[data.this])

        elseif type(target[data.target]) == "table" and type(this[data.this]) == "string" then
            validador = checkStringInTable(this[data.this],target[data.target])
        end

    end

    return validador
end




return colisionador