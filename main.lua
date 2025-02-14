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
require "95Styling"
tove = require "tove"
utf8 = require("utf8")
--[[
https://www.youtube.com/watch?v=py0iF3mwy2E
-show correct answers after finishing test mode
]]
function love.load()
    LoadSettings()
    LoadFonts()
    LoadBackdrops()
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
            N5Button(261, 833, 689, 41, true, 'if SetToPreview>0 then StateMachine="Set Options" end' , true ,Exo24,"Select")
            N5Button(261, 889, 689, 41, true, "CreateNewSet()" , true ,Exo24, "Create New Set")
            N5Button(261, 944, 689, 41, true, 'StateMachine="Import Menu"' , true ,Exo24, "Import Quizlet Set")
            if Deleting==false then
                SetData = LoadSavedSetsIntoMemory()
                ListofSets()
                SetPreview()
            end
            N5Button(1542,93,55,55,true,"StateMachine='Settings Menu'")
            N5Button(1604,93,55,55,true,"PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'")
        end
        if StateMachine=="Settings Menu" then
            BackdropDraw(SettingsMenuBackdrop)
            ButtonStyle1Mod3(754,880,402,110,"Confirm",Exo24Bold,true, 'ConfirmSettings()')
            ResolutionDropDownMenuMk1(835-MediumLine,200,300,125,Exo24Bold,true)
            N5Button(1542,93,55,55,true,"StateMachine='Main Menu'")
            N5Button(1604,93,55,55,true,"PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'")
        end
        if StateMachine=="Import Menu" then
            BackdropDraw(ImportMenuBackdrop)
            ImportMenuTitle()
            ImportMenuSetPastingAndPreview()
            N5Button(1749,93,55,55,true,'StateMachine = "Main Menu"; Paste = ""; Input = ""')
            N5Button(1810,93,55,55,true,"PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'")
            N5Button(1020, 887, 290, 96, true, 'StateMachine = "Main Menu"; ImportAQuizletSet(Input,Paste); Paste = ""; Input = ""' , true ,Exo24Bold,"Confirm")
        end
        if StateMachine=="Set Options" then
            SetTitle, SetData, NumberOfTerms = LoadIndividualSet(SetToPreview)
            BackdropDraw(SelectActionBackdrop)
            N5Button(300, 253, 402, 122, true, 'StateMachine = "View Set"', false,Exo24Bold,"View/Edit")
            N5Button(754, 253, 402, 122, true, 'StateMachine = "Flashcards"', false,Exo24Bold,"Flashcards")
            N5Button(754, 486, 402, 122, true, 'StateMachine = "Missile Defense"; LoadMissileDefense()', false,Exo24Bold,"Missile Defense")
            --ButtonStyle1Mod3(754,486,402,122,"Word Search",Exo24Bold,true, 'StateMachine = "Word Search"')
            if NumberOfTerms>4 then 
                N5Button(1209, 486, 402, 122, true, 'StateMachine = "Test"', false,Exo24Bold, "Test")
                N5Button(1209, 253, 402, 122, true, 'StateMachine = "Matching"; LoadMatching()', false,Exo24Bold,"Matching")
            else
                N5Button(1209, 486, 402, 122, true, "", false,Exo24Bold, "Not Enough Terms")
                N5Button(1209, 253, 402, 122, true, "", false,Exo24Bold, "Not Enough Terms")
            end
            --ButtonStyle1(300,720,402,122,"Reserved",Exo24Bold,true)
            --ButtonStyle1(754,720,402,122,"Reserved",Exo24Bold,true)
            --ButtonStyle1(1209,720,402,122,"Reserved",Exo24Bold,true)
            N5Button(1542,93,55,55,true,"StateMachine='Main Menu'")
            N5Button(1604,93,55,55,true,"PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'")
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