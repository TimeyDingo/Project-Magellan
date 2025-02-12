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
require "Activities/ViewSet"
--[[
1440x900
2732x1536
1760x990
1680x1050
1600x900
1366x768
1280x1024
1280x720
1128x634
1024x768
800x600
640x480
maybe just two input boxes that restrain minimum input to 480x480
https://love2d.org/wiki/love.window.getDesktopDimensions
https://love2d.org/forums/viewtopic.php?t=9751

https://fonts.google.com/specimen/Atkinson+Hyperlegible
https://github.com/2dengine/profile.lua
https://www.youtube.com/watch?v=py0iF3mwy2E
-show correct answers after finishing test mode
]]
tove = require "tove"
utf8 = require("utf8")
function love.load()
    LoadSettings()
    LoadFonts()
    LoadBackdrops()
    LoadLineThickness()
    LoadActivities()
    LoadMouseClickDebounce()
    LoadPopup()
    StateMachine="Main Menu"
    Input=""
    Paste=""
    SetData={}
    SetToPreview=0
    BackspaceTimer=0
    MainMenuScroll=0
    Deleting=false
    HeldTime=0
    NumberOfTerms=0
    YScroll=0
end
function love.update(dt)
    dt = love.timer.getDelta()
    DebounceTimer=DebounceTimer+dt
    if love.keyboard.isDown("lshift") and love.keyboard.isDown("escape") then --? allows game to be closed quickly for debugging
        love.event.quit()
    end
    if love.keyboard.isDown("escape") then
        PopupCall=true
        PopupAction="love.event.quit()"
        PopUpMessage="Close Software?"
    end
    if StateMachine=="Edit" and EditActivityLoadOnce==false then
        SetTitle, SetData, NumberOfTerms=LoadIndividualSet(SetToPreview)
        EditActivityLoadOnce=true
    end
    StateMachine=tostring(StateMachine)
    if StateMachine=="Missile Defense" then
        MissileDefenseTimer = MissileDefenseTimer + dt
    end
    if StateMachine=="Set Options" and NumberOfTerms>4 then --?? Load for the testing/matching activity
        GenerateTestingData()
        GenerateMatchingData()
    end
    function love.wheelmoved(x, y)
        YScroll=y
    end
end
function love.draw()
    H=love.graphics.getPixelHeight()
    W=love.graphics.getPixelWidth()
    MouseX = love.mouse.getX()
    MouseY = love.mouse.getY()
    if PopupCall==false then
        if StateMachine=="Main Menu" then
            BackdropDraw(MainMenuBackdrop)
            ButtonStyle1Mod3(261,833,689,41,"Select",Exo24Bold,true,'if SetToPreview>0 then StateMachine="Set Options" end')
            ButtonStyle1Mod3(261,889,689,41,"Create New Set",Exo24Bold,true, "CreateNewSet()")
            ButtonStyle1Mod3(327,944,624,41,"Import Quizlet Set",Exo24Bold,true,'StateMachine="Import Menu"')
            if Deleting==false then
                SetData = LoadSavedSetsIntoMemory()
                ListofSets()
                SetPreview()
            end
            ButtonStyle1Mod3(1491,88,50,50,"~",Exo24Bold,true,"StateMachine='Settings Menu'")
            ButtonStyle1Mod3(1551,88,50,50,"X",Exo24Bold,true,"PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'")
        end
        if StateMachine=="Settings Menu" then
            BackdropDraw(SettingsMenuBackdrop)
            ButtonStyle1Mod3(754,880,402,110,"Confirm",Exo24Bold,true, 'ConfirmSettings()')
            ResolutionDropDownMenuMk1(835-MediumLine,200,300,125,Exo24Bold,true)
            ButtonStyle1Mod3(1491,88,50,50,"<-",Exo24Bold,true, 'StateMachine = "Main Menu"')
            ButtonStyle1Mod3(1551,88,50,50,"X",Exo24Bold,true,"PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'")
        end
        if StateMachine=="Import Menu" then
            BackdropDraw(ImportMenuBackdrop)
            ImportMenuTitle()
            ImportMenuSetPastingAndPreview()
            ButtonStyle1Mod3(1691, 88, 50, 50, "<-",Exo24Bold,true, 'StateMachine = "Main Menu"; Paste = ""; Input = ""')
            ButtonStyle1Mod3(1751,88,50,50,"X",Exo24Bold,true,"PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'")
            ButtonStyle1Mod3(1020,887,290,96,"Confirm",Exo24Bold,true,'StateMachine = "Main Menu"; ImportAQuizletSet(Input,Paste); Paste = ""; Input = ""')
        end
        if StateMachine=="Set Options" then
            SetTitle, SetData, NumberOfTerms = LoadIndividualSet(SetToPreview)
            BackdropDraw(SelectActionBackdrop)
            ButtonStyle1Mod3(300,253,402,122,"View/Edit",Exo24Bold,true, 'StateMachine = "View Set"')
            ButtonStyle1Mod3(754,253,402,122,"Flashcards",Exo24Bold,true, 'StateMachine = "Flashcards"')
            ButtonStyle1Mod3(300,486,402,122,"Missile Defense",Exo24Bold,true, 'StateMachine = "Missile Defense"; LoadMissileDefense()')
            --ButtonStyle1Mod3(754,486,402,122,"Word Search",Exo24Bold,true, 'StateMachine = "Word Search"')
            if NumberOfTerms>4 then 
                ButtonStyle1Mod3(1209,486,402,122,"Test",Exo24Bold,true, 'StateMachine = "Test"')
                ButtonStyle1Mod3(1209,253,402,122,"Matching",Exo24Bold,true, 'StateMachine = "Matching"; LoadMatching()')
            else
                ButtonStyle1(1209,486,402,122,"Not Enough Terms",Exo24Bold,true)
                ButtonStyle1(1209,253,402,122,"Not Enough Terms",Exo24Bold,true)
            end
            --ButtonStyle1(300,720,402,122,"Reserved",Exo24Bold,true)
            --ButtonStyle1(754,720,402,122,"Reserved",Exo24Bold,true)
            --ButtonStyle1(1209,720,402,122,"Reserved",Exo24Bold,true)
            ButtonStyle1Mod3(1491,88,50,50,"<-",Exo24Bold,true, 'StateMachine = "Main Menu"')
            ButtonStyle1Mod3(1551,88,50,50,"X",Exo24Bold,true,"PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'")
        end
        if StateMachine=="Edit" then
            ActivityBackdrop()
            ButtonStyle1Mod3(1797, 3, 50, 50, "<-", Exo24Bold, true, 'EditActivityCallBackoutPopup()')            
            ButtonStyle1Mod3(1867,3,50,50,"X",Exo24Bold,true,"PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'")
            EditActivity()
        end
        if StateMachine=="Flashcards" then
            ActivityBackdrop()
            ButtonStyle1Mod3(1797,3,50,50,"<-",Exo24Bold,true,'StateMachine = "Set Options"; LoadFlashcards()')
            ButtonStyle1Mod3(1867,3,50,50,"X",Exo24Bold,true,"PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'")
            FlashcardActivity()
        end
        if StateMachine=="Matching" then
            ActivityBackdrop()
            ButtonStyle1Mod3(1797,3,50,50,"<-",Exo24Bold,true,'StateMachine = "Set Options"; LoadMatching()')
            ButtonStyle1Mod3(1867,3,50,50,"X",Exo24Bold,true,"PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'")
            MatchingActivity()
        end
        if StateMachine=="Missile Defense" then
            ActivityBackdrop()
            ButtonStyle1Mod3(1797,3,50,50,"<-",Exo24Bold,true,'StateMachine = "Set Options"')
            ButtonStyle1Mod3(1867,3,50,50,"X",Exo24Bold,true,"PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'")
            MissileDefenseActivity()
        end
        if StateMachine=="Word Search" then
            ActivityBackdrop()
            ButtonStyle1Mod3(1797,3,50,50,"<-",Exo24Bold,true,'StateMachine = "Set Options"')
            ButtonStyle1Mod3(1867,3,50,50,"X",Exo24Bold,true,"PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'")
            WordSearchActivity()
        end
        if StateMachine=="Test" then
            ActivityBackdrop()
            ButtonStyle1Mod3(1797,3,50,50,"<-",Exo24Bold,true,'StateMachine = "Set Options"; LoadTestActivity()')
            ButtonStyle1Mod3(1867,3,50,50,"X",Exo24Bold,true,"PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'")
            TestActivity()
        end
        if StateMachine=="View Set" then
            ActivityBackdrop()
            ButtonStyle1Mod3(1797,3,50,50,"<-",Exo24Bold,true,'StateMachine = "Set Options"; LoadViewSet()')
            ButtonStyle1Mod3(1867,3,50,50,"X",Exo24Bold,true,"PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'")
            ViewActivity()
        end
    end
    love.graphics.print(MouseX.."x"..MouseY,scaling(200,1920,Settings.XRes),scaling(50,1080,Settings.YRes))--? Debug for mouse position
    if PopupCall==true then
        ConfirmActionPopup(PopUpMessage,Exo24Bold,true,PopupAction)
    end
end