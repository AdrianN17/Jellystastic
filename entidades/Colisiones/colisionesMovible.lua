local colisionesMovible = Class{}

function colisionesMovible:init()

    self.preSolve = {
        {
            parametroObj = {
                {"Es_pasable", true}
            },
            callback = function(coll,target,this)
                local x,y = coll:getNormal()

                if y>-0.01 then
                    coll:setEnabled( false )
                else
                    if this.pasarPlataformas  then
                        coll:setEnabled( false )
                    end
                end

            end
        }
    }

end

return colisionesMovible