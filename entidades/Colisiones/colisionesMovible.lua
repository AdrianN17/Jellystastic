local colisionesMovible = Class{}

function colisionesMovible:init()

    self.preSolve = {
        {
            callback = function(coll,target,this)
                local condicional1 = target["Es_pasable"]

                if condicional1 then

                    local x,y = coll:getNormal()

                    if y>-0.01 then
                        coll:setEnabled( false )
                    else
                        if this.pasarPlataformas  then
                            coll:setEnabled( false )
                        end
                    end
                end
            end
        }
    }

end

return colisionesMovible