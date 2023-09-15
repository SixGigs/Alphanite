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

function Player:update()
	self:updateAnimation()

	self:handleState()
	self:handleMovementAndCollisions()
end

function Player:handleState()
	if self.currentState == "idle" then
		self:applyGravity()
		self:handleGroundInput()
	elseif self.currentState == "walk" then
		self:applyGravity()
		self:handleGroundInput()
	elseif self.currentState == "jump" then

	end
end

function Player:handleMovementAndCollisions()
	local _, _, collisions, length = self:moveWithCollisions(self.x + self.xVelocity, self.y + self.yVelocity)

	self.touchingGround = false
	for i=1, length do
		local collision = collisions[i]
		if collision.normal.y == -1 then
			self.touchingGround = true
		end
	end
end

-- Input Helper Functions
function Player:handleGroundInput()
	if pd.buttonIsPressed(pd.kButtonLeft) then
		self:changeToWalkState("left")
	elseif pd.buttonIsPressed(pd.kButtonRight) then
		self:changeToWalkState("right")
	else
		self:changeToIdleState()
	end
end