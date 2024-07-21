require "math"--default lua math
require "TextFuncs"--adds custom functions
require "MainMenu"--Menu Functions
require "IOFuncs"
utf8 = require("utf8")
function love.load()
    Exofont=love.graphics.newFont("Fonts/Exo2.ttf", 32)--loads fonts
    ExoSmall=love.graphics.newFont("Fonts/Exo2.ttf", 20)
    Exo24=love.graphics.newFont("Fonts/Exo2.ttf", 24)
    Exo24Bold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", 24)
    Exo20=love.graphics.newFont("Fonts/Exo2.ttf", 20)
    Exo20Bold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", 20)
    ExoSmaller=love.graphics.newFont("Fonts/Exo2.ttf", 16)
    ExoLarge=love.graphics.newFont("Fonts/Exo2.ttf", 120)
    SevenSegment=love.graphics.newFont("Fonts/SevenSegment.ttf",200)
    StateMachine=0--sets the state machine to 0 for the main menu, 1 for the settings, and 2 for the game
    BackdropImage=love.graphics.newImage('Selectscreenbackdrop.png')
    ImportBackdrop=love.graphics.newImage('ImportMenu.png')
    Paste="Paste Text Here"
    Title="Type Text Here"
    Input=""
    SetData={}
    Settings={1920,1080,2}
    SetToPreview=0
    ImportMenuOpen=false
    if LoadSettings(Settings) == 1 then--? If loading is successful 
        love.window.setMode(Settings[1],Settings[2],{msaa=Settings[3]})--! Scaling of various objects need to be correctly done so that resolution can eventually be changed
    end
end

function love.update(dt)
    dt = love.timer.getDelta()
    if love.keyboard.isDown("1") then --? allows game to be closed on 1 keyboard input for debugging
        love.event.quit()
    end
end
function love.draw()
    H=love.graphics.getPixelHeight()
    W=love.graphics.getPixelWidth()
    if StateMachine==0 then --main menu
        MouseX = love.mouse.getX()
        MouseY = love.mouse.getY()
        SetSelectionMenu()
        love.graphics.print(MouseX.."x"..MouseY,200,50)--? Debug for mouse position
    end
end