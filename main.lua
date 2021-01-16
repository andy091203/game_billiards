Class = require 'class'
push = require 'push'
require 'Ball'
background = love.graphics.newImage('pic/bg.png')
bg_width = background:getWidth()
bg_height = background:getHeight()
VIRTUAL_WIDTH = 1000
VIRTUAL_HEIGHT = 800
WINDOW_WIDTH = 1000
WINDOW_HEIGHT = 800

function love.load()
    love.graphics.setDefaultFilter('nearest','nearest')
    love.window.setTitle('Billiards')
    math.randomseed(os.time())
    smallFont = love.graphics.newFont('font.ttf', 8)
    mediumFont = love.graphics.newFont('flappy.ttf', 14)
    flappyFont = love.graphics.newFont('flappy.ttf', 28)
    hugeFont = love.graphics.newFont('flappy.ttf', 56)
    love.graphics.setFont(flappyFont)
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })
    ball = Ball(VIRTUAL_WIDTH / 2 - 10, 520, 40)
    gamestate = 0
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    -- `key` will be whatever key this callback detected as pressed
    if key == 'escape' then
        love.event.quit()
    end
    if key == 'f' then
        gamestate = 1
        ball.dx = math.random(-300, 300)
        ball.dy = math.random(-300, 300)
    end
end
function love.update(dt)
    if gamestate == 1 then
        ball:update(dt)
    end
end

function love.draw()
    -- begin drawing with push, in our virtual resolution
    push:start()

    love.graphics.clear(40/255, 45/255, 52/255, 255/255)
    
    -- render different things depending on which part of the game we're in
    love.graphics.draw(background, 0, 250, 0, VIRTUAL_WIDTH / bg_width, (VIRTUAL_HEIGHT - 250) / bg_height)
    ball:render()
    displayFPS()

    -- end our drawing to push
    push:finish()
end

function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(hugeFont)
    love.graphics.setColor(0, 255/255, 0, 255/255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
    love.graphics.setColor(255, 255, 255, 255)
end
