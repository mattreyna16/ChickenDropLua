function love.load()
  bubble = love.graphics.newImage("bubble.png")
  pickup = love.graphics.newImage("pickup.png")
  backgroundImage = love.graphics.newImage("bg.png")

  -- Create a variable to track bubble speed
  bubbleSpeed = 80 

  math.randomseed(os.time())
  math.random(); math.random(); math.random()
  startx = {math.random(0, love.graphics.getWidth() - bubble:getWidth()), 
            math.random(0, love.graphics.getWidth() - bubble:getWidth()),  
            math.random(0, love.graphics.getWidth() - bubble:getWidth()),  
            math.random(0, love.graphics.getWidth() - bubble:getWidth()), 
            math.random(0, love.graphics.getWidth() - bubble:getWidth())}
  starty = {0 - math.random(bubble:getHeight(), bubble:getHeight() * 2),
            0 - math.random(bubble:getHeight(), bubble:getHeight() * 2),
            0 - math.random(bubble:getHeight(), bubble:getHeight() * 2),
            0 - math.random(bubble:getHeight(), bubble:getHeight() * 2),
            0 - math.random(bubble:getHeight(), bubble:getHeight() * 2)}
  pickupx = math.random(0, love.graphics.getWidth() - pickup:getWidth())
  pickupy = 0 - math.random(pickup:getHeight())
end

-------------------------------------------------
--MOUSE PRESS
--1 = left, 2 = right, 3 = middle wheel
-------------------------------------------------
function love.mousepressed(x, y, button, istouch)
  if button == 1 then
    --print("left mouse clicked")
    for i, v in ipairs(startx) do
      --if the mouse x and y is within the boundary of a bubble
      if x >= startx[i] and x <= startx[i] + bubble:getWidth() and y >= starty[i] and y <= starty[i] + bubble:getHeight() then
        --print("in bounds")
        math.randomseed(os.time())
        math.random(); math.random(); math.random()
        --reset its y value (go back to the top)
        starty[i] = math.random(bubble:getHeight(), bubble:getHeight() * 2) * -1
      end
    end

    --if the mouse x and y is within the boundary of a pickup
    if x >= pickupx and x <= pickupx + pickup:getWidth() and y >= pickupy and y <= pickupy + pickup:getHeight() then
      --print("in bounds")
      math.randomseed(os.time())
      math.random(); math.random(); math.random()
      
      -- Increase speed on pickup clicked
      bubbleSpeed = bubbleSpeed + 20
      
      --reset its y value (go back to the top)
      pickupy = math.random(pickup:getHeight(), pickup:getHeight() * 2) * -1
    end
  end
end

-------------------------------------------------
--UPDATE
-------------------------------------------------
function love.update(dt)
  for i, v in ipairs(starty) do
    --if chicken hits the bottom of the screen, lua quits (we lose)
    if starty[i] + bubble:getHeight() >= love.graphics.getHeight() then
      --print("over the edge")
      love.event.quit()
    end
    --chickens move down using the new speed variable
    starty[i] = starty[i] + bubbleSpeed * dt
  end
  -- also chenging the pickup speed when you pick it up and not just the normal bubbles
  pickupy = pickupy + bubbleSpeed * dt
end

-------------------------------------------------
--DRAW
-------------------------------------------------
function love.draw()
  love.graphics.draw(backgroundImage, 0, 0)
  --draw each chicken at their respective x and y
  for i, v in ipairs(startx) do
    love.graphics.draw(bubble, startx[i], starty[i])
  end
  love.graphics.draw(pickup, pickupx, pickupy)
end