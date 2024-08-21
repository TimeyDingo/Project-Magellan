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
end
function love.update(dt)
    dt = love.timer.getDelta()
    DebounceTimer=DebounceTimer+1
    if love.keyboard.isDown("1") then --? allows game to be closed on 1 keyboard input for debugging
        love.event.quit()
    end
    if StateMachine=="Edit" and EditActivityLoadOnce==false then
        SetTitle, SetData, NumberOfTerms=LoadIndividualSet(SetToPreview)
        EditActivityLoadOnce=true
    end
    StateMachine=tostring(StateMachine)
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
            BackdropDraw(SelectActionBackdrop)
            SettingResolutionButtons(300,253,402,122,"1024x576",Exo24Bold,1024, true)
            SettingResolutionButtons(754,253,402,122,"1280x720",Exo24Bold,1280, true)
            SettingResolutionButtons(1209,253,402,122,"1920x1080",Exo24Bold,1920,true)
            SettingsFullscreenButtons(300,486,402,122,"Fullscreen",Exo24Bold,true,true)
            SettingsFullscreenButtons(1209,486,402,122,"Windowed",Exo24Bold,false,true)
            ButtonStyle1Mod3(754,720,402,122,"Confirm",Exo24Bold,true, 'ConfirmSettings()')
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
            SetTitle, SetData = LoadIndividualSet(SetToPreview)
            BackdropDraw(SelectActionBackdrop)
            ButtonStyle1Mod3(300,253,402,122,"View/Edit",Exo24Bold,true, 'StateMachine = "View Set"')
            ButtonStyle1Mod3(754,253,402,122,"Flashcards",Exo24Bold,true, 'StateMachine = "Flashcards"')
            ButtonStyle1Mod3(1209,253,402,122,"Matching",Exo24Bold,true, 'StateMachine = "Matching"; LoadMatching()')
            ButtonStyle1Mod3(300,486,402,122,"Missile Defense",Exo24Bold,true, 'StateMachine = "Missile Defense"')
            ButtonStyle1Mod3(754,486,402,122,"Word Search",Exo24Bold,true, 'StateMachine = "Word Search"')
            ButtonStyle1Mod3(1209,486,402,122,"Test",Exo24Bold,true, 'StateMachine = "Test"')
            ButtonStyle1(300,720,402,122,"Reserved",Exo24Bold,true)
            ButtonStyle1(754,720,402,122,"Reserved",Exo24Bold,true)
            ButtonStyle1(1209,720,402,122,"Reserved",Exo24Bold,true)
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
            ButtonStyle1Mod3(1797,3,50,50,"<-",Exo24Bold,true,'StateMachine = "Set Options"; ResetFlashCardActivity()')
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
            ButtonStyle1Mod3(1797,3,50,50,"<-",Exo24Bold,true,'StateMachine = "Set Options"')
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
    love.graphics.print(MouseX.."x"..MouseY,scaling(200,1920,Settings[1]),scaling(50,1080,Settings[2]))--? Debug for mouse position
    if PopupCall==true then
        ConfirmActionPopup(PopUpMessage,Exo24Bold,true,PopupAction)
    end
end