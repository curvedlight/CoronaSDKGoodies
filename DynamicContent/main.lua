--   main.lua
--   Lets figure out Corona Dynamic Scaling
--   author :  Ken Cardita    Curved Light Solution LLC
--   version : ver 1.0  5/17/2012
--   email  :  Ken@CurvedLightSolutions.com

local oMsg,rMsg,pMsg,iMsg,devStr -- message storage for screen

-- calculate actual W/H
-- assume that config.lua Height/width are set to
-- portrait representation of the world - even if its a landscape app
local physicalW = math.round( (display.contentWidth  - display.screenOriginX*2) / display.contentScaleX)
if physicalW == 799 then physicalW = 800 end -- deal with slight rounding error
local physicalH = math.round( (display.contentHeight - display.screenOriginY*2) / display.contentScaleY)
if physicalH == 799 then physicalH = 800 end -- deal with slight rounding error
pMsg = "Physical Width: "..physicalW .. " Height: "..physicalH

--  this needs to match what is in config.lua
local configLuaWidth = 320
local configLuaHeight = 480
local  myConfigLuaCrossover = 1.5   -- make sure this matches Config.lua suffix
                                    -- ["-2x"] = 1.5,

local ratio   -- Relative X axis ratio of PhysicalX/configLuaX  i.e. what Corona uses to determine what Image to use

-- lets figure out the ratios - based on device orientation
if physicalH > physicalW then
    oMsg = "Device has PORTRAIT orientation"
    rMsg = "Ratio(X): "..physicalW/configLuaWidth .." Ratio(Y): ".. physicalH/configLuaHeight
    ratio   =  physicalW/configLuaWidth
 else
    oMsg = "Device has LANDSCAPE orientation"
    rMsg = "Ratio(X): ".. physicalW/configLuaHeight.. " Ratio(Y): ".. physicalH/configLuaWidth
    ratio   =  physicalW/configLuaHeight
end

-- lets place a dynamic resolution image at the virtual center of the screen
local myImage = display.newImageRect( "image.png", 100,100 )  --  notes: 100x100 is the actual base image resolution
myImage.x = display.contentCenterX
myImage.y = display.contentCenterY

-- Lets show what we are running on
-- Note: works on simulator not run on many devices so your mileage may vary
local model = system.getInfo("model")
if model == "iPhone" or  model == "iPad"  or  model == "iPhone Simulator" or  model == "iPad Simulator"  then
    devStr = "I'm an Apple device: ".. model
else
    devStr =  "I'm an Android device: " ..model
end

-- Lets guess if we will use the SMALL or LARGE Image
if ratio  >= myConfigLuaCrossover then
    iMsg= " Using the LARGE image"
else
    iMsg = "Using the SMALL/base image"
end

-- output the info

local label1 = display.newText( devStr, 20,  30, native.systemFontBold, 16 )
local label2 = display.newText( pMsg,   20,  60, native.systemFontBold, 16 )
local label3 = display.newText( oMsg,   20, 100, native.systemFontBold, 16 )
local label4 = display.newText( rMsg,   20, 130, native.systemFontBold, 16 )
local label6 = display.newText( iMsg,   20, 160, native.systemFontBold, 16 )


-- Utility to print X,Y coordinates of a tap for orientation sanity checking
local function mytap (event)
print ("TAP X ="..event.x, "TAP Y =".. event.y)
end
Runtime:addEventListener ("tap", mytap)