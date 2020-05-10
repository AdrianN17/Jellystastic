local colisionesBaba = Class{}

function colisionesBaba:init()
    self.preSolve = {
        {
            callback = function(coll,target,this)

                local condicional1 = target["Es_tierra"]

                if condicional1 then
                    if not this.timerRemove and not this.body:isDestroyed() then
                        this.timerRemove = this.entidad.timer:after(5,function()
                            this:remove()
                        end)
                    end
                end
            end,
        },
        {
            callback = function(coll,target,this)

                local condicional1 = checkStringInTable(target.tag,this.balasEnemigos)

                if condicional1 then
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
                    
                    if target.cambiarEstado then
                        target:cambiarEstado("semizombie")
                    end

                    this:remove()

                    local x,y = coll:getPositions()

                    if target.direccion == math.sign(x-this.ox) and not target.objPresa then

                        if target.cambiarDeDireccion then
                            target:cambiarDeDireccion()
                        end

                        if target.voltear then
                            target:voltear()
                        end
                    end
                end
            end
        },
        {
            callback = function(coll,target,this)
                local condicional1 = target.tag

                if condicional1 == "meteorito" then
                    coll:setEnabled(false)
                    this:remove()
                end
            end
        }

    }
end

return colisionesBaba