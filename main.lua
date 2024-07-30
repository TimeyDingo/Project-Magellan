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
    Input=""
    Paste=""
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
        ImportMenuBackdrop()
        ImportMenuTitle()
        ImportMenuSetPastingAndPreview()
        ButtonStyle1Mod3(1691, 88, 50, 50, "<-", Exo24Bold, 'StateMachine = "Main Menu"; Paste = ""; Input = ""')
        ButtonStyle1Mod3(1751,88,50,50,"X",Exo24Bold,"love.event.quit()")
        ButtonStyle1Mod3(1020,887,290,96,"Confirm",Exo24Bold,'StateMachine = "Main Menu"; ImportAQuizletSet(Input,Paste); Paste = ""; Input = ""')
    end
    if StateMachine=="Set Options" then
        SetTitle, SetData = LoadIndividualSet(SetToPreview)
        SetOptionsBackdrop()
        ButtonStyle1(300,253,402,122,"Edit",Exo24Bold)
        ButtonStyle1(754,253,402,122,"Flashcards",Exo24Bold)
        ButtonStyle1(1209,253,402,122,"Matching",Exo24Bold)
        ButtonStyle1(300,486,402,122,"Missile Defense",Exo24Bold)
        ButtonStyle1(754,486,402,122,"Word Search",Exo24Bold)
        ButtonStyle1(1209,486,402,122,"Test",Exo24Bold)
        ButtonStyle1(300,720,402,122,"Reserved",Exo24Bold)
        ButtonStyle1(754,720,402,122,"Reserved",Exo24Bold)
        ButtonStyle1(1209,720,402,122,"Reserved",Exo24Bold)
        ButtonStyle1Mod3(1491,88,50,50,"<-",Exo24Bold, 'StateMachine = "Main Menu"')
        ButtonStyle1Mod3(1551,88,50,50,"X",Exo24Bold,"love.event.quit()")
    end
    love.graphics.print(MouseX.."x"..MouseY,200,50)--? Debug for mouse position
end