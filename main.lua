require "math"--default lua math
require "TextFuncs"--adds custom functions
require "MainMenu"--Menu Functions
require "IOFuncs"
require "CoreChanges"
require "Loading"
require "Activities.EditActivity"
require "Activities.FlashcardsActivity"
require "Activities.MatchingActivity"
require "Activities.MissileDefenseActivity"
require "Activities.TestActivity"
require "Activities.WordSearchActivity"
require "Activities.ViewSet"
require "95Styling"
require "backdrops"
utf8 = require("utf8")
https = require("https")
--[[
https://www.youtube.com/watch?v=py0iF3mwy2E
-show correct answers after finishing test mode
]]
function love.load()
    LoadSettings()
    LoadFonts()
    LoadActivities()
    LoadMouseClickDebounce()
    LoadPopup()
    LoadSounds()
    SetStateMachine("Main Menu")
    Input=""
    Paste=""
    SetToPreview=0
    BackspaceTimer=0
    MainMenuScroll=0
    Deleting=false
    HeldTime=0
    NumberOfTerms=0
    YScroll=0
    MouseHistory = {}
    MouseHistory.maxEntries = 10
    love.keyboard.setTextInput(true)
    CheckForUpdates("0.0.10")
end
function love.update(dt)
    dt = love.timer.getDelta()
    UpdateDebounceTimers()
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
        --SetTitle, SetData, NumberOfTerms=LUASetRead(SetToPreview)
        SetData=LUASetRead(SetToPreview)
        EditActivityLoadOnce=true
        --!!!!! this can potentially be removed now with the SetState function
    end
    if StateMachine=="Missile Defense" then
        MissileDefenseTimer = MissileDefenseTimer + dt
    end
    if StateMachine=="Set Options" and SetData.Terms>4 then --?? Load for the testing/matching activity
        GenerateTestingData()
        GenerateMatchingData()
    end
    function love.wheelmoved(x, y)
        YScroll=y
    end
end
function love.draw()
    H=love.graphics.getHeight()
    W=love.graphics.getWidth()
    MouseX = love.mouse.getX()
    MouseY = love.mouse.getY()
    MouseDX, MouseDY=MouseDelta()
    if PopupCall==false then
        if StateMachine=="Main Menu" then
            
            --N5Window(244, 79, 1431, 922, true, "Project Copernicus", true,{{"StateMachine='Settings Menu'","~"},{"PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'","X"}})
            N5MainMenu()
            N5Button(261, 833, 689, 41, true, 'if SetToPreview>0 then SetStateMachine("Set Options") end' , true ,BodyFont,"Select")
            N5Button(261, 889, 689, 41, true, "CreateNewSet()" , true ,BodyFont, "Create New Set")
            N5Button(261, 944, 689, 41, true, 'SetStateMachine("Import Menu")' , true ,BodyFont, "Import Quizlet Set")
            if Deleting==false then
                ListofSets()
                SetPreview()
            end
            N5Button(1542,93,55,55,true,"SetStateMachine('Settings Menu')",true,SmallHeaderBold,"~")
            N5Button(1604,93,55,55,true,"PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'",true,SmallHeaderBold,"X")
        end

        
        if StateMachine=="Settings Menu" then
            N5SettingMenu()
            N5Button(754,880,402,110, true, 'ConfirmSettings()', true, BodyFontBold, "Save Settings")
            --resolution
            N5BoxWithTitle(1249,178,411,55,true,"Current Resolution",Settings.XRes.. " x " ..Settings.YRes)
            local RSBX,RSBY,RSBW,RSBH=N5BoxWithTitle(1249,261,411,573,true,"Select A Resolution")
            local Padding=scaling(10,1920,Settings.XRes)
            local YSpacing=scaling(44.5,1080,Settings.YRes)
            local BoxHeight=scaling(24,634,Settings.YRes)
            N5Button(RSBX+Padding,RSBY+Padding,RSBW-Padding*2,BoxHeight,false,"ApplySettings(854,480)",true,BodyFont,"854 x 480")
            N5Button(RSBX+Padding,RSBY+Padding+YSpacing*1,RSBW-Padding*2,BoxHeight,false,"ApplySettings(1024,576)",true,BodyFont,"1024 x 576")
            N5Button(RSBX+Padding,RSBY+Padding+YSpacing*2,RSBW-Padding*2,BoxHeight, false, "ApplySettings(1128,634)", true, BodyFont, "1128 x 634")
            N5Button(RSBX+Padding,RSBY+Padding+YSpacing*3,RSBW-Padding*2,BoxHeight, false, "ApplySettings(1280,720)", true, BodyFont, "1280 x 720")
            N5Button(RSBX+Padding,RSBY+Padding+YSpacing*4,RSBW-Padding*2,BoxHeight, false, "ApplySettings(1366,768)", true, BodyFont, "1366 x 768")
            N5Button(RSBX+Padding,RSBY+Padding+YSpacing*5,RSBW-Padding*2,BoxHeight, false, "ApplySettings(1440,810)", true, BodyFont, "1440 x 810")
            N5Button(RSBX+Padding,RSBY+Padding+YSpacing*6,RSBW-Padding*2,BoxHeight, false, "ApplySettings(1600,900)", true, BodyFont, "1600 x 900")
            N5Button(RSBX+Padding,RSBY+Padding+YSpacing*7,RSBW-Padding*2,BoxHeight, false, "ApplySettings(1760,990)", true, BodyFont, "1760 x 990")
            N5Button(RSBX+Padding,RSBY+Padding+YSpacing*8,RSBW-Padding*2,BoxHeight, false, "ApplySettings(1920,1080)", true, BodyFont, "1920 x 1080")
            N5Button(RSBX+Padding,RSBY+Padding+YSpacing*9,RSBW-Padding*2,BoxHeight, false, "ApplySettings(2560,1440)", true, BodyFont, "2560 x 1440")
            N5Button(RSBX+Padding,RSBY+Padding+YSpacing*10,RSBW-Padding*2,BoxHeight, false, "ApplySettings(2732,1536)", true, BodyFont, "2732 x 1536")
            N5Button(RSBX+Padding,RSBY+Padding+YSpacing*11,RSBW-Padding*2,BoxHeight, false, "ApplySettings(3840,2160)", true, BodyFont, "3840 x 2160")
            --
            --font selector
            N5BoxWithTitle(261,178,411,55,true,"Current Font",Settings.FontSelected)
            local FSBX,FSBY,FSBW,FSBH=N5BoxWithTitle(261,261,411,573,true,"Select A Font")
            N5Button(FSBX+Padding,FSBY+Padding,FSBW-Padding*2,BoxHeight,false,"Settings.FontSelected='Exo2'",true,SExo24,"Exo2")
            N5Button(FSBX+Padding,FSBY+Padding+YSpacing*1,FSBW-Padding*2,BoxHeight,false,"Settings.FontSelected='AtkinsonHyperlegible'",true,SAHL24,"AtkinsonHyperlegible")
            N5Button(FSBX+Padding,FSBY+Padding+YSpacing*2,FSBW-Padding*2,BoxHeight, false, "Settings.FontSelected='IBMPlex'", true, SIBM24, "IBMPlex")
            N5Button(FSBX+Padding,FSBY+Padding+YSpacing*3,FSBW-Padding*2,BoxHeight, false, "Settings.FontSelected='Stylized'", true, SExo24, "Stylized (Exo2+IBM)")
            N5Button(FSBX+Padding,FSBY+Padding+YSpacing*4,FSBW-Padding*2,BoxHeight, false, "Settings.FontSelected='OpenDyslexic'", true, SOD24, "Open Dyslexic")
            --dark mode
            local DMTX,DMTY,DMTW,DMTH=N5BoxWithTitle(744,436,411,79,true,"Dark Mode?","",true)
            Settings.DarkMode=N5TickBox(DMTX,DMTY,DMTW,DMTH, false, Settings.DarkMode)
            --antiflicker
            local RFTX,RFTY,RFTW,RFTH=N5BoxWithTitle(744,565,411,79,true,"Reduced Flicker?","",true)
            Settings.ReducedFlicker=N5TickBox(RFTX,RFTY,RFTW,RFTH, false, Settings.ReducedFlicker)
            --
            --Font size
            local FSTX,FSTY,FSTW,FSTH=N5BoxWithTitle(744,693,411,79,true,"Font Size Modifier","",true)
            Settings.FontModRaw,Settings.FontModPercent=N5Slider(FSTX,FSTY,FSTW,FSTH, false, Settings.FontModRaw,Settings.FontModPercent)
            SExo24=love.graphics.newFont("Fonts/Exo2.ttf", scaling(24,1080,Settings.YRes)+FontTransform())
            SIBM24=love.graphics.newFont("Fonts/IBMPlexMono-Regular.ttf", scaling(24,1080,Settings.YRes)+FontTransform())
            SAHL24=love.graphics.newFont("Fonts/AtkinsonHyperlegible-Regular.ttf", scaling(24,1080,Settings.YRes)+FontTransform())
            SOD24=love.graphics.newFont("Fonts/OpenDyslexic-Regular.otf", scaling(24,1080,Settings.YRes,true)+FontTransform())
            --
            --Audio
            local AVTX,AVTY,AVTW,AVTH=N5BoxWithTitle(744,308,411,79,true,"Audio Volume","",true)
            Settings.AudioRaw,Settings.AudioPercent=N5Slider(AVTX,AVTY,AVTW,AVTH, false, Settings.AudioRaw,Settings.AudioPercent)
            local Selected = isMouseOverBox(AVTX, AVTY, AVTW, AVTH)
            if Selected and math.abs(MouseDY)>0.5 then
                Sounds.MissileIncoming:play()
            end
            SetSoundVolume(Settings.AudioPercent)
            --
            N5Button(1542,93,55,55,true,"SetStateMachine('Main Menu');love.load()",true,SmallHeaderBold,"<-")
            N5Button(1604,93,55,55,true,"PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'",true,SmallHeaderBold,"X")
        end
        if StateMachine=="Import Menu" then
            N5ImportMenu()
            ImportMenuTitle()
            ImportMenuSetPastingAndPreview()
            N5Button(1749,93,55,55,true,'StateMachine = "Main Menu"; Paste = ""; Input = ""',true,SmallHeaderBold,"<-")
            N5Button(1810,93,55,55,true,"PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'",true,SmallHeaderBold,"X")
            N5Button(1020, 887, 290, 96, true, 'StateMachine = "Main Menu"; ImportAQuizletSet(Input,Paste); Paste = ""; Input = ""' , true ,BodyFontBold,"Confirm")
        end
        if StateMachine=="Set Options" then
            N5SelectMenu()
            N5Button(300, 253, 402, 122, true, 'StateMachine = "View Set"', false,BodyFontBold,"View/Edit")
            N5Button(754, 253, 402, 122, true, 'StateMachine = "Flashcards"', false,BodyFontBold,"Flashcards")
            N5Button(754, 486, 402, 122, true, 'StateMachine = "Missile Defense"; LoadMissileDefense()', false,BodyFontBold,"Missile Defense")
            --ButtonStyle1Mod3(754,486,402,122,"Word Search",Exo24Bold,true, 'StateMachine = "Word Search"')
            if SetData.Terms>4 then 
                N5Button(1209, 486, 402, 122, true, 'StateMachine = "Test"', false,BodyFontBold, "Test")
                N5Button(1209, 253, 402, 122, true, 'StateMachine = "Matching"; LoadMatching()', false,BodyFontBold,"Matching")
            else
                N5Button(1209, 486, 402, 122, true, "", false,BodyFontBold, "Not Enough Terms")
                N5Button(1209, 253, 402, 122, true, "", false,BodyFontBold, "Not Enough Terms")
            end
            --ButtonStyle1(300,720,402,122,"Reserved",Exo24Bold,true)
            --ButtonStyle1(754,720,402,122,"Reserved",Exo24Bold,true)
            --ButtonStyle1(1209,720,402,122,"Reserved",Exo24Bold,true)
            N5Button(1542,93,55,55,true,"SetStateMachine('Main Menu')",true,SmallHeaderBold,"<-")
            N5Button(1604,93,55,55,true,"PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'",true,SmallHeaderBold,"X")
        end
        if StateMachine=="Edit" then
            N5GameBar("Edit")
            N5Button(1751, 6, 75, 75, true, "EditActivityCallBackoutPopup()",true,SmallHeaderBold,"<-")
            N5Button(1835, 6, 75, 75, true, "PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'",true,SmallHeaderBold,"X")
            EditActivity()
        end
        if StateMachine=="Flashcards" then
            N5GameBar("Flashcards")
            N5Button(1751, 6, 75, 75, true, 'SetStateMachine("Set Options"); LoadFlashcards()',true,SmallHeaderBold,"<-")
            N5Button(1835, 6, 75, 75, true, "PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'",true,SmallHeaderBold,"X")
            FlashcardActivity()
        end
        if StateMachine=="Matching" then
            N5GameBar("Matching")
            N5Button(1751, 6, 75, 75, true, 'SetStateMachine("Set Options"); LoadMatching()',true,SmallHeaderBold,"<-")
            N5Button(1835, 6, 75, 75, true, "PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'",true,SmallHeaderBold,"X")
            MatchingActivity()
        end
        if StateMachine=="Missile Defense" then
            N5GameBar("Missile Defense")
            N5Button(1642, 6, 100, 75, true, 'SetSoundVolume(0)',true,SmallHeaderBold,"Mute")
            N5Button(1751, 6, 75, 75, true, 'SetStateMachine("Set Options")',true,SmallHeaderBold,"<-")
            N5Button(1835, 6, 75, 75, true, "PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'",true,SmallHeaderBold,"X")
            MissileDefenseActivity()
        end
        if StateMachine=="Word Search" then
            N5GameBar("Word Search")
            N5Button(1751, 6, 75, 75, true, 'SetStateMachine("Set Options")',true,SmallHeaderBold,"<-")
            N5Button(1835, 6, 75, 75, true, "PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'",true,SmallHeaderBold,"X")
            WordSearchActivity()
        end
        if StateMachine=="Test" then
            N5GameBar("Test")
            N5Button(1751, 6, 75, 75, true, 'SetStateMachine("Set Options"); LoadTestActivity()',true,SmallHeaderBold,"<-")
            N5Button(1835, 6, 75, 75, true, "PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'",true,SmallHeaderBold,"X")
            TestActivity()
        end
        if StateMachine=="View Set" then
            N5GameBar("View Set")
            N5Button(1751, 6, 75, 75, true, 'SetStateMachine("Set Options"); LoadViewSet()',true,SmallHeaderBold,"<-")
            N5Button(1835, 6, 75, 75, true, "PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'",true,SmallHeaderBold,"X")
            ViewActivity()
        end
    end
    --love.graphics.print(MouseX.."x"..MouseY,scaling(200,1920,Settings.XRes),scaling(50,1080,Settings.YRes))--? Debug for mouse position
    love.graphics.print("FPS:"..love.timer.getFPS(),scaling(100,1920,Settings.XRes),scaling(100,1080,Settings.YRes))--? Debug for mouse position
    if PopupCall==true then
        ConfirmActionPopup(PopUpMessage,BodyFontBold,true,PopupAction)
    end
end