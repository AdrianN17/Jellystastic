local colisionesBala = Class{}

function colisionesBala:init()

    self.preSolve = {
        {
            parametroObj = {
                {"Es_tierra",true},
                {"Es_pasable", true}
            },
            callback = function(coll,target,this)

                coll:setEnabled(false)

            end
        },
        {
            parametroObj = {
                {"Es_tierra",true},
                {"Es_pasable",nil},
                {"Es_liquido",nil}
            },
            callback = function(coll,target,this)

                coll:setEnabled(false)

                if this.crearExplosion then
                    this:crearExplosion(coll)
                end

                this:remove()
            end
        },
        {
            check = {
                {target ="tag",this = "balasEnemigos"}
            },
            callback = function(coll,target,this)

                if this.crearExplosion then
                    this:crearExplosion(coll)
                end

                target:remove()
                this:remove()
            end
        },
        {
            check = {
                {target = "tag",this = "objetivosEnemigos"}
            },

            callback = function(coll,target,this)

                coll:setEnabled(false)

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

                this.entidad:dano(target,this.dano)
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

        }
    }

end

return colisionesBala