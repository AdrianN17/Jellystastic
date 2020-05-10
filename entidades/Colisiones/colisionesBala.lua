local colisionesBala = Class{}

function colisionesBala:init()

    self.preSolve = {
        {
            callback = function(coll,target,this)

                local condicional1 = target["Es_tierra"]
                local condicional2 = target["Es_pasable"]

                if condicional1 and condicional2 then
                    coll:setEnabled(false)
                end
            end
        },
        {
            callback = function(coll,target,this)

                local condicional1 = target["Es_tierra"]
                local condicional2 = target["Es_pasable"]

                if condicional1 and not condicional2 then

                    coll:setEnabled(false)

                    if this.crearExplosion then
                        this:crearExplosion(coll)
                    end

                    this:remove()

                end
            end
        },
        {
            callback = function(coll,target,this)

                local condicional1 = checkStringInTable(target.tag,this.balasEnemigos)

                if condicional1 then
                    if this.crearExplosion then
                        this:crearExplosion(coll)
                    end

                    target:remove()
                    this:remove()
                end
            end
        },
        {
            callback = function(coll,target,this)

                local condicional1 = checkStringInTable(target.tag,this.objetivosEnemigos)

                if condicional1 then
                    coll:setEnabled(false)

                    this.entidad:dano(target,this.dano)
                    

                    if this.crearExplosion then
                        this:crearExplosion(coll)

                        if target.cambiarEstado then
                            target:cambiarEstado("canon")
                        end

                    else
                        if target.cambiarEstado then
                            target:cambiarEstado("agujereado")
                        end
                    end

                    this:remove()

                    local x,y = coll:getPositions()

                    if not target.Es_ingirableBala and target.direccion == math.sign(x-this.ox) and not target.objPresa then
                        if target.cambiarDeDireccion then
                            target:cambiarDeDireccion()
                        end

                        if target.voltear then
                            target:voltear()
                        end
                    end
                end
            end

        }
    }

end

return colisionesBala