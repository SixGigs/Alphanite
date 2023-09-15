--CoreLibs
import 'CoreLibs/object'
import 'CoreLibs/graphics'
import 'CoreLibs/sprites'
import 'CoreLibs/timer'

-- Libraries
import 'scripts/libraries/AnimatedSprite'
import 'scripts/libraries/LDtk'

-- PlayDate constants
local pd <const> = playdate
local gfx <const> = playdate.graphics

-- Game update loop
function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
end