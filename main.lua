require "math"--default lua math
require "TextFuncs"--adds custom functions
require "MainMenu"--Menu Functions
require "IOFuncs"
require "CoreChanges"
require "Loading"
require "Activities/EditActivity"
require "Activities/FlashcardsActivity"
require "Activities/MatchingActivity"
require "Activities/MissileDefenseActivity"
require "Activities/TestActivity"
require "Activities/WordSearchActivity"
utf8 = require("utf8")
function love.load()
    LoadFonts()
    LoadBackdrops()
    LoadSettings()
    LoadActivities()
    LoadMouseClickDebounce()
    StateMachine="Main Menu"
    Input=""
    Paste=""
    SetData={}
    SetToPreview=0
    BackspaceTimer=0
    MainMenuScroll=0
end
function love.update(dt)
    dt = love.timer.getDelta()
    MouseClickDebounceValue=MouseClickDebounceValue+1
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
        ButtonStyle1Mod3(1551,88,50,50,"X",Exo24Bold,"love.event.quit()")
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
        ButtonStyle1Mod3(300,253,402,122,"Edit",Exo24Bold, 'StateMachine = "Edit"')
        ButtonStyle1Mod3(754,253,402,122,"Flashcards",Exo24Bold, 'StateMachine = "Flashcards"')
        ButtonStyle1Mod3(1209,253,402,122,"Matching",Exo24Bold, 'StateMachine = "Matching"')
        ButtonStyle1Mod3(300,486,402,122,"Missile Defense",Exo24Bold, 'StateMachine = "Missile Defense"')
        ButtonStyle1Mod3(754,486,402,122,"Word Search",Exo24Bold, 'StateMachine = "Word Search"')
        ButtonStyle1Mod3(1209,486,402,122,"Test",Exo24Bold, 'StateMachine = "Test"')
        ButtonStyle1(300,720,402,122,"Reserved",Exo24Bold)
        ButtonStyle1(754,720,402,122,"Reserved",Exo24Bold)
        ButtonStyle1(1209,720,402,122,"Reserved",Exo24Bold)
        ButtonStyle1Mod3(1491,88,50,50,"<-",Exo24Bold, 'StateMachine = "Main Menu"')
        ButtonStyle1Mod3(1551,88,50,50,"X",Exo24Bold,"love.event.quit()")
    end
    if StateMachine=="Edit" then
        ActivityBackdrop()
        ButtonStyle1Mod3(1797,3,50,50,"<-",Exo24Bold,'StateMachine = "Set Options"')
        ButtonStyle1Mod3(1867,3,50,50,"X",Exo24Bold,"love.event.quit()")
        EditActivity()
    end
    if StateMachine=="Flashcards" then
        ActivityBackdrop()
        ButtonStyle1Mod3(1797,3,50,50,"<-",Exo24Bold,'StateMachine = "Set Options"; ResetFlashCardActivity()')
        ButtonStyle1Mod3(1867,3,50,50,"X",Exo24Bold,"love.event.quit()")
        FlashcardActivity()
    end
    if StateMachine=="Matching" then
        ActivityBackdrop()
        ButtonStyle1Mod3(1797,3,50,50,"<-",Exo24Bold,'StateMachine = "Set Options"; LoadMatching()')
        ButtonStyle1Mod3(1867,3,50,50,"X",Exo24Bold,"love.event.quit()")
        MatchingActivity()
    end
    if StateMachine=="Missile Defense" then
        ActivityBackdrop()
        ButtonStyle1Mod3(1797,3,50,50,"<-",Exo24Bold,'StateMachine = "Set Options"')
        ButtonStyle1Mod3(1867,3,50,50,"X",Exo24Bold,"love.event.quit()")
        MissileDefenseActivity()
    end
    if StateMachine=="Word Search" then
        ActivityBackdrop()
        ButtonStyle1Mod3(1797,3,50,50,"<-",Exo24Bold,'StateMachine = "Set Options"')
        ButtonStyle1Mod3(1867,3,50,50,"X",Exo24Bold,"love.event.quit()")
        WordSearchActivity()
    end
    if StateMachine=="Test" then
        ActivityBackdrop()
        ButtonStyle1Mod3(1797,3,50,50,"<-",Exo24Bold,'StateMachine = "Set Options"')
        ButtonStyle1Mod3(1867,3,50,50,"X",Exo24Bold,"love.event.quit()")
        TestActivity()
    end
    love.graphics.print(MouseX.."x"..MouseY,200,50)--? Debug for mouse position
end