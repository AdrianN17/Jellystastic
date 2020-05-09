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

        data["callback"](coll,target,this)

    end

end

return colisionador