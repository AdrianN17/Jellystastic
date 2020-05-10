local colisionesEnemigo = Class{}

function colisionesEnemigo:init()
    self.preSolve = {
        {
            callback = function(coll,target,this)

                local condicional1 = this["Es_colisionableAtaque"]
                local condicional2 = checkStringInTable(target.tag,this.objetivosEnemigos)

                if condicional1 and condicional2 then
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
                elseif not condicional1 and condicional2 then
                    coll:setEnabled(false)
                end
            end
        },
        {
            callback = function(coll,target,this)

                local condicional1 = this["Es_danoFisico"]
                local condicional2 = checkStringInTable(target.tag,this.objetivosEnemigos)

                if condicional1 and condicional2 then

                    if target.acciones and not target.acciones.invulnerable then

                        this.entidad:dano(target,2)

                        if target.cambiarEstado then
                            target:cambiarEstado("semizombie")
                        end

                        target.acciones.invulnerable = true

                        local timer = this.entidad.timer:after(1,function()
                            if target and target.acciones.invulnerable then
                                target.acciones.invulnerable=false
                            end
                        end)

                        if target.inmunidadTimerVariable then
                            target.cooldownInmunidadTimer = timer
                        end


                    end


                end
            end
        }

    }
end

return colisionesEnemigo