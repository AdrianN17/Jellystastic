local colisionesLiquido = Class{}

function colisionesLiquido:init()

    self.preSolve = {
        {
            callback = function(coll,target,this)
 
                local condicional1 = checkStringInTable(target.tag,{"bala","baba"})
                local condicional2 = target.fixture:getBody():getType()

                if not condicional1 and condicional2 == "dynamic" then
                    this:buoyancy(this.densidad,this.fixture,target.fixture,coll)
                end
            end
        },
        {

            callback = function(coll,target,this)
                local condicional1 = target.tag

                if condicional1 == "bala" then
                    coll:setEnabled(false)
                end
            end
        },
        {
            callback = function(coll,target,this)
                local condicional1 = target.tag

                if condicional1 == "baba" then

                    this:buoyancy(this.densidad,this.fixture,target.fixture,coll)

                    if not target.timerRemove and not target.body:isDestroyed() then
                        print("a")
                        target.timerRemove = target.entidad.timer:after(5,function()
                            target:remove()
                        end)
                    end
                end
            end
        }
    }

end

return colisionesLiquido