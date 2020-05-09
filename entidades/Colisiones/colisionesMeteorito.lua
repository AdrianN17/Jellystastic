local colisionesMeteorito = Class{}

function colisionesMeteorito:init()

    self.preSolve = {
        {
            callback = function(coll,target,this)

                local condicional1 = this["timerPosicionamiento"]
                local condicional2 = target["Es_tierra"]

                if not condicional1 and condicional2 then

                    this.timerPosicionamiento = this.entidad.timer:after(2, function()
                        if this and this.body and not this.body:isDestroyed() then
                            this:remove()
                        end
                    end)
                end

            end
        },
        {
            callback = function(coll,target,this)

                local condicional1 = checkStringInTable(target.tag,this.objetivosEnemigos)

                if condicional1 then
                    coll:setEnabled(false)

                    if target.acciones and not target.acciones.invulnerable then
                        this.entidad:dano(target,5)

                        if target.cambiarEstado then
                            target:cambiarEstado("canon")
                        end

                        target.acciones.invulnerable = true

                        this.entidad.timer:after(1,function()
                            if target then
                                target.acciones.invulnerable=false
                            end
                        end)

                    end
                end
            end
        }
    }

end


return colisionesMeteorito