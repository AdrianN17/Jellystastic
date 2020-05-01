local colisionesEnemigo = Class{}

function colisionesEnemigo:init()
    self.preSolve = {
        {
            parametroSelf = {
                {"Es_colisionableAtaque",true}
            },
            check = {
                {target = "tag",this = "objetivosEnemigos"}
            },
            callback = function(coll,target,this)

                if this.automata.current == "seguir" then
                    coll:setEnabled(true)
                else
                    coll:setEnabled(false)
                end


                local x,_ = coll:getPositions()

                local dir = math.sign(x-this.ox)

                if target.direccion == dir and this.automata and this.automata.current=="seguir" then

                    if target.cambiarDeDireccion then
                        target:cambiarDeDireccion()
                    end

                    if target.voltear then
                        target:voltear()
                    end

                end
            end
        },
        {

            parametroSelf = {
                {"Es_danoFisico",true}
            },
            check = {
                {target = "tag",this = "objetivosEnemigos"}
            },
            callback = function(coll,target,this)
                if target.acciones and not target.acciones.invulnerable then
                    this.entidad:dano(target,2)

                    if target.cambiarEstado then
                        target:cambiarEstado("semizombie")
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

return colisionesEnemigo