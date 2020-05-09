function love.load()
    lg = love.graphics
    rand = love.math.random 
    lg.setDefaultFilter("nearest", "nearest")
    lg.setLineStyle("rough")

    img_one = lg.newImage("assets/1.png")
    img_two = lg.newImage("assets/2.png")
    img_three = lg.newImage("assets/3.png")

    Physics = require("physics")

    world = Physics()

    world:addClass("Class1", {"Class1","Class2"})
    world:addClass("Class2")
    world:addClass("Class3", {"Class2"})
    world:addClass("Mouse", {"Wall"})
    world:addClass("Wall")
    world:addClass("Face")

    rect  = world:addRectangle(150, 150, 100, 100, 0.3):setClass("Class1"):setDrawMode("fill"):setColor(0.3, 1, 0):setAlpha(0.2)
    rect2 = world:addRectangle(250, 150, 50, 100, 0.3):setClass("Class1")
    circ  = world:addCircle(500, 100, 30):setClass("Class2"):setDrawMode("fill"):setColor(1, 0, 0):setAlpha(0.4)
    circ2 = world:addCircle(500, 400, 30):setClass("Class2")
    poly  = world:addPolygon( 300, 500, {-100, -100,  -50, -150,  50, -100,  -20, 10}):setClass("Class3")
    poly2 = world:addPolygon( 200, 400, {-50, 20,  -50, -120,  50, -80,  10, 50}):setClass("Class3"):setDrawMode("fill"):setColor(0, 0.4, 1):setAlpha(0.3)
    mouse = world:addCircle(love.mouse.getX(), love.mouse.getY(), 30):setColor(1,0,0.8):setClass("Mouse")
    wall  = world:addChain(true, {1, 1, 1, 599, 799, 599, 799, 1}):setClass("Wall")

    multi = world:addRectangle(400, 400, 20, 60):setClass("Face")
    multi:addShape("left_eye"    , "circle"   , -50, -50, 20          ):setColor(rand(), rand(), rand())
    multi:addShape("left_pupil"  , "circle"   , -60, -50,  5          ):setColor(rand(), rand(), rand()):setDrawMode("fill")
    multi:addShape("right_eye"   , "circle"   ,  50, -50, 20          ):setColor(rand(), rand(), rand())
    multi:addShape("right_pupil" , "circle"   ,  45, -50,  5          ):setColor(rand(), rand(), rand()):setDrawMode("fill")
    multi:addShape("mouth_left2" , "rectangle", -85,  35, 30, 10,  0.8):setColor(rand(), rand(), rand()):setDrawMode("fill")
    multi:addShape("mouth_left"  , "rectangle", -50,  60, 30, 10,  0.3):setColor(rand(), rand(), rand())
    multi:addShape("mouth"       , "rectangle",   0,  68, 40, 10      ):setColor(rand(), rand(), rand()):setDrawMode("fill")
    multi:addShape("mouth_right" , "rectangle",  50,  60, 30, 10, -0.3):setColor(rand(), rand(), rand())
    multi:addShape("mouth_right2", "rectangle",  85,  35, 30, 10, -0.8):setColor(rand(), rand(), rand()):setDrawMode("fill")
    multi:getPShape("main"):setColor(love.math.random(),love.math.random(),love.math.random()):setDrawMode("fill")

    mousejoint = world:addJoint("mouse", mouse, love.mouse.getPosition())
end

function love.update(dt) 
    world:update(dt)
    mousejoint:setTarget(love.mouse.getPosition()) 
end

function love.draw() 
    world:draw() 

    lg.draw(img_one, rect:getX(), rect:getY(), rect:getAngle(), 2, 2, img_one:getWidth()/2, img_one:getHeight()/2)
    lg.draw(img_one, rect2:getX(), rect2:getY(), rect2:getAngle(), 2, 2, img_one:getWidth()/2, img_one:getHeight()/2)
    lg.draw(img_two, circ:getX(), circ:getY(), circ:getAngle(), 1, 1, img_two:getWidth()/2, img_two:getHeight()/2)
    lg.draw(img_two, circ2:getX(), circ2:getY(), circ2:getAngle(), 1, 1, img_two:getWidth()/2, img_two:getHeight()/2)
    lg.draw(img_three, poly:getX(), poly:getY(), poly:getAngle(), 2, 2, 40, 60)
    lg.draw(img_three, poly2:getX(), poly2:getY(), poly2:getAngle(), 2, 2, 30, 50)
end