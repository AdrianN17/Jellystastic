local colisionesLiquido = Class{}

function colisionesLiquido:init()

    self.preSolve = {
        {
            parametroObj = {
                {"Es_moverLiquido",true}
            },
            callback = function(coll,target,this)
                this:buoyancy(this.densidad,this.fixture,target.fixture,coll)
            end
        }
    }

end

return colisionesLiquido