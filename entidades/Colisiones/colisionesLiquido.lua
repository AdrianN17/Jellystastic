local colisionesLiquido = Class{}

function colisionesLiquido:init()

    --[[self.preSolve = {
        {
            parametroFunction = function(coll,target,this)
                local tag = checkStringInTable(target.tag,{"bala","baba","meteorito"})
                return target.fixture:getBody():getType() == "dynamic" and not tag
            end,
            callback = function(coll,target,this)
 
                if not target.tocandoAgua then
                    target.tocandoAgua=false
                end

                this:buoyancy(this.densidad,this.fixture,target.fixture,coll)
            end
        },
        {
            parametroObj = {
                {"tag","bala"}
            },
            callback = function(coll,target,this)
                coll:setEnabled(false)
            end
        },
        {
            parametroObj = {
                {"tag","baba"}
            },
            callback = function(coll,target,this)

                if not target.tocarLiquido then
                    target.tocarLiquido = true
                end

                this:buoyancy(this.densidad,this.fixture,target.fixture,coll)
            end
        },
        {
            parametroObj = {
                {"tag","meteorito"}
            },
            callback = function(coll,target,this)

                if not target.tocarLiquido then
                    target.tocarLiquido = true
                end

                this:buoyancy(this.densidad,this.fixture,target.fixture,coll)
            end
        }
    }]]

end

return colisionesLiquido