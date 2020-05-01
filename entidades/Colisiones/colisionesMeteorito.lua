local colisionesMeteorito = Class{}

function colisionesMeteorito:init()

    self.preSolve = {
        {
            parametroObj = {
                {"Es_tierra",true}
            },
            parametroSelf = {
                {"timerPosicionamiento",nil}
            },
            callback = function(coll,target,this)

                this.timerPosicionamiento = this.entidad.timer:after(1, function()
                    if this and this.body and not this.body:isDestroyed() then
                        this.body:setPosition(this.oxInicial,this.oyInicial)
                        this.body:setLinearVelocity(0,0)
                        this.hp = this.maxHp
                        this.timerPosicionamiento = nil
                    end
                end)

            end
        },
        {
            check = {
                {target = "tag",this = "objetivosEnemigos"}
            },
            callback = function(coll,target,this)

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
        }
    }

end


return colisionesMeteorito