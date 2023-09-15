local pd <const> = playdate
local gfx <const> = playdate.graphics

class('Player').extends()

function Player:init(x, y)
    -- State Machine
    local playerImageTable = gfx.imagetable.new("images/player-table-32-32")
    Player.super.init(self, playerImageTable)

    self:addState("idle", 1, 1)
    self:addState("walk", 1, 4, {tickStep = 4})
    self:addState("jump", 5, 5)
    self:playAnimation()

    -- Sprite Properties
    self:move(x, y)
    self:setZIndex(Z_INDEXES.Player)
    self:setTag(TAGS.Player)
    self:setCollideRect(8, 2, 16, 30)

    -- Physics Properties
    self.xVelocity = 0
    self.yVelocity = 0
    self.gravity = 1.0
    self.maxSpeed = 2.0

    -- Player state
    self.touchingGround = false
end

function Player:collisionResponse()
    return gfx.sprite.kCollisisonTypeSlide
end