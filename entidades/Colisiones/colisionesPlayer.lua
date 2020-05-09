local colisionesPlayer = Class{}

function colisionesPlayer:init()


    self.preSolve = {
        {
            callback = function(coll,target,this)
                local condicion1 = target["Es_pasable"]

                if condicion1 then
                    local x,y = coll:getNormal()

                    if y>-0.01 then
                        coll:setEnabled( false )
                    else
                        if this.acciones.pasarPlataformas  then

                            coll:setEnabled( false )
                        end
                    end
                end
            end
        },
        {
            callback = function(coll,target,this)
                local tag = target.tag == this.tag

                if tag then
                    coll:setEnabled( false )
                end
            end
        }
    }

    self.endContact = {
        {
            callback = function(coll,target,this)

                local condicion1 = this.acciones.pasarPlataformas
                local condicion2 = target["Es_pasable"]

                if condicion1 and condicion2 then
                    this.acciones.pasarPlataformas=false
                end
            end
        }
    }

end



return colisionesPlayer