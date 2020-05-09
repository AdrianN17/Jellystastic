local query = Class {}

function query:init()

end

function query:circle(world,ox,oy,radio)
    local list = {}
    for _,body in pairs(world:getBodies()) do
        local x,y = body:getX(),body:getY()

        if math.sqrt((ox - x)^2 + (oy - y)^2) <= radio then
            local fixture = body:getFixtures()[1]
            table.insert(list,fixture)
        end
    end

    return list
end

function query:rectangle(world,ox, oy, w, h)
    local list = {}

    for _,body in pairs(world:getBodies()) do
        local x,y = body:getX(),body:getY()

        if _ox >= x and ox <= x + w and oy >= y and oy <= y + h then
            local fixture = body:getFixtures()[1]
            table.insert(list,fixture)
        end
    end

    return list
end

return query