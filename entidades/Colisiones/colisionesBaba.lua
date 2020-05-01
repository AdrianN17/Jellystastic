local colisionesBaba = Class{}

function colisionesBaba:init()
    self.preSolve = {
        {
            modalidad ="parametros",
            parametroObj = {
                {"Es_tierra",true}
            },
            callback = function(coll,target,this)
                if not this.timerRemove and not this.body:isDestroyed() then
                    this.timerRemove = this.entidad.timer:after(5,function()
                        this:remove()
                    end)
                end
            end,
        },
        {
            check = {
                {target ="tag",this = "balasEnemigos"}
            },
            callback = function(coll,target,this)

                target:remove()
                this:remove()

            end
        },
        {
            check = {
                {target ="tag",this = "objetivosEnemigos"}
            },
            callback = function(coll,target,this)

                coll:setEnabled(false)

                this.entidad:dano(target,this.dano)
                this:remove()

                if target.cambiarEstado then
                    target:cambiarEstado("semizombie")
                end


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
        }

    }
end

return colisionesBaba