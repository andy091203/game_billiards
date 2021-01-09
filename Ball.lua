Ball=Class{}

function Ball:init(x, y, diameter) 
    self.r = 0
    self.image = love.graphics.newImage('pic/OIP.png')
    self.x = x  
    self.y = y
    self.diameter = diameter
    self.dy = 0
    self.dx = 0
end

function Ball:update(dt)
    offset = 5
    if self.x <= offset or self.x + self.diameter + offset >= VIRTUAL_WIDTH then
        self.dx = -self.dx
    end
    if self.y <= offset or self.y + self.diameter + offset >= VIRTUAL_HEIGHT then
        self.dy = -self.dy
    end

    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
    friction = 4
    dv = math.sqrt(self.dx ^ 2 + self.dy ^ 2)
    if dv < 0 then
        dv2 = math.min(dv + friction, 0)
    elseif dv > 0 then
        dv2 = math.max(dv - friction, 0)
    end
    if dv ~= 0 then
        self.dx = dv2 / dv * self.dx
        self.dy = dv2 / dv * self.dy
        self.r = (self.r + 0.3) % 3.1416
    end
end

function Ball:render()
    love.graphics.draw(self.image, self.x, self.y, self.r, self.diameter/self.image:getWidth(),
        self.diameter/self.image:getWidth(), self.image:getWidth() / 2, self.image:getHeight() / 2)
end
