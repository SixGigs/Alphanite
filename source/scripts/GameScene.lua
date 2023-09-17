-- PlayDate & LDtk constants
local gfx <const> = playdate.graphics
local ldtk <const> = LDtk

TAGS = {
	Player = 1
}

-- Game scene globals for z index
Z_INDEXES = {
	Player = 100
}

-- Load the level
ldtk.load("levels/world.ldtk", false)

-- Create the game scene class
class('GameScene').extends()

-- Initialise the game scene class
function GameScene:init()
	self:goToLevel("Level_0")
	self.spawnX = 24 * 8
	self.spawnY = 10 * 8
	self.player = Player(self.spawnX, self.spawnY)
end

-- Go to the level specified
function GameScene:goToLevel(level_name)
	gfx.sprite.removeAll()

	for layer_name, layer in pairs(ldtk.get_layers(level_name)) do
		if layer.tiles then
			local tilemap = ldtk.create_tilemap(level_name, layer_name)
			local layerSprite = gfx.sprite.new()

			layerSprite:setTilemap(tilemap)
			layerSprite:setCenter(0, 0)
			layerSprite:moveTo(0, 0)
			layerSprite:setZIndex(layer.zIndex)
			gfx.setDrawOffset(-24, -24)
			layerSprite:add()

			local emptyTiles = ldtk.get_empty_tileIDs(level_name, "Solid", layer_name)
			if emptyTiles then
				gfx.sprite.addWallSprites(tilemap, emptyTiles)
			end
		end
	end
end