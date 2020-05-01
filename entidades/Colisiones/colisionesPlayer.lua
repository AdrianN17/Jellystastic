local colisionesPlayer = Class{}

function colisionesPlayer:init()


    self.preSolve = {
        {
            parametroObj = {
                {"Es_pasable",true}
            },
            callback = function(coll,target,this)
                local _,y = coll:getNormal()

                if y>-0.01 then
                    coll:setEnabled( false )
                else
                    if this.acciones.pasarPlataformas  then

                        coll:setEnabled( false )
                    end
                end
            end
        },
        {
            comparacion = {
                {"tag",true}
            },
            callback = function(coll,target,this)
                coll:setEnabled( false )
            end
        }
    }

    self.endContact = {
        {
            parametroObj = {
                {"Es_pasable",true}
            },
            callback = function(coll,target,this)
                if this.acciones.pasarPlataformas then
                    this.acciones.pasarPlataformas=false
                end
            end
        }
    }

end



return colisionesPlayer