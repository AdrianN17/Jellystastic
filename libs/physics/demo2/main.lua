function love.load()
    lg = love.graphics
    rand = love.math.random 
    lg.setDefaultFilter("nearest", "nearest")
    lg.setLineStyle("rough")
    Physics = require("physics")
    Timer = require("timer")
    t = Timer()

    bg_color = {r = 0, g = 0, b = 0}

    world = Physics(0, 1300)

    world:addClass("Mouse", {"Wall"})
    world:addClass("Wall")
    mouse = world:addCircle(love.mouse.getX(), love.mouse.getY(), 30):setColor(1,0,0.8):setClass("Mouse"):setTag("my_rectangle"):setDrawMode("fill")
    wall  = world:addChain(true, {1, 1, 1, 599, 799, 599, 799, 1}):setClass("Wall")
    rect = world:addRectangle(300, 200, 100, 100)
    rect:setRestitution(0.3)
    top = rect:addShape("top_t", "polygon", {0, -100, 50, -50, -50, -50})
    top:setRestitution(0.7)
    other_rect = world:addRectangle(300, 100, 50, 50):setTag("other_rectangle")
    other_rect:setType("static")
    other_circ = world:addCircle(500, 400, 50):setTag("other_circle")
    other_circ:setType("static")
    other_circ:setSensor(true)
    other_circ2 = world:addCircle(50, 400, 50):setTag("other_circle2")
    other_circ2:setType("static")
    mousejoint = world:addJoint("mouse", mouse, love.mouse.getPosition())

    top:setEnter(function(s1, s2, c, i) 
        if s2:getClass() == "Wall" then
            if not t:is_timer('tween_bg_color') then bg_color = {r = rand(), g = rand(), b = rand()} end
            t:tween(0.2, bg_color, {r = 0, g = 0, b = 0}, 'linear', 'tween_bg_color')
        end
    end)

    mouse:setExit(function(s1, s2, c, i) 
        if s2:getCTag() == "other_rectangle" then 
            s1:getCollider():setColor(rand(), rand(), rand())
        end
    end)

    mouse:setEnter(function(s1, s2, c, i) 
        if s2:getCTag() == "other_circle" then 
            rect:getPShape("main"):setColor(rand(), rand(), rand())
        end
    end)

    mouse:setPresolve(function(s1, s2, c, i) 
        if s2:getCTag() == "other_circle2" then 
            bg_color = {r = rand(), g = rand(), b = rand()}
        end
    end)

    other_circ2:setPresolve(function(s1, s2, c, i) 
        c:setEnabled(false)
    end)
end

function love.update(dt) 
    t:update(dt)
    world:update(dt)
    mousejoint:setTarget(love.mouse.getPosition()) 

end

function love.draw() 
    world:draw() 
    lg.setBackgroundColor(bg_color.r, bg_color.g, bg_color.b)
end
