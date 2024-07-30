require "math"--default lua math
require "TextFuncs"--adds custom functions
require "MainMenu"--Menu Functions
require "IOFuncs"
require "CoreChanges"
require "SetEditing"
require "Loading"
utf8 = require("utf8")
function love.load()
    LoadFonts()
    LoadBackdrops()
    LoadSettings()
    StateMachine="Main Menu"
    Paste="Paste Text Here"
    Title="Type Text Here"
    Input=""
    SetData={}
    SetToPreview=0
end
function love.update(dt)
    dt = love.timer.getDelta()
    SetData = LoadSavedSetsIntoMemory()
    if love.keyboard.isDown("1") then --? allows game to be closed on 1 keyboard input for debugging
        love.event.quit()
    end
end
function love.draw()
    H=love.graphics.getPixelHeight()
    W=love.graphics.getPixelWidth()
    MouseX = love.mouse.getX()
    MouseY = love.mouse.getY()
    if StateMachine=="Main Menu" then
        Backdrop()
        SelectButton()
        CreateNewSetButton()
        ImportQuizletSetButton()
        ListofSets()
        SetPreview()
    end
    if StateMachine=="Import Menu" then
        ImportMenu()
    end
    if StateMachine=="Set Options" then
        SetOptionsMenu(SetToPreview)
    end
    love.graphics.print(MouseX.."x"..MouseY,200,50)--? Debug for mouse position
end