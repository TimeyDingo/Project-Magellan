function LoadFonts()
    Exo20=love.graphics.newFont("Fonts/Exo2.ttf", scaling(20,1080,Settings.YRes,true))
    Exo20Bold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", scaling(20,1080,Settings.YRes,true))
    Exo24=love.graphics.newFont("Fonts/Exo2.ttf", scaling(24,1080,Settings.YRes,true))
    Exo24Bold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", scaling(24,1080,Settings.YRes,true))
    Exo28=love.graphics.newFont("Fonts/Exo2.ttf", scaling(28,1080,Settings.YRes,true))
    Exo28Bold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", scaling(28,1080,Settings.YRes,true))
    Exo32Bold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", scaling(32,1080,Settings.YRes,true))
    Exo60Black=love.graphics.newFont("Fonts/Exo2-Black.ttf", scaling(45,1080,Settings.YRes,true))
    IBM34Bold=love.graphics.newFont("Fonts/IBMPlexMono-Bold.ttf", scaling(34,1080,Settings.YRes,true))
    IBM60Bold=love.graphics.newFont("Fonts/IBMPlexMono-Bold.ttf", scaling(60,1080,Settings.YRes,true))
    ThickLine=scaling(5,1080,Settings.YRes,true)
    MediumLine=scaling(3,1080,Settings.YRes,true)
    ThinLine=scaling(1,1080,Settings.YRes,true)
end
function LoadBackdrops()
    local MainMenuFile = love.filesystem.read("SVG/MainMenu.svg")
    MainMenuBackdrop = tove.newGraphics(MainMenuFile,Settings.XRes,Settings.YRes)
    local ImportMenuFile = love.filesystem.read("SVG/ImportMenu.svg")
    ImportMenuBackdrop = tove.newGraphics(ImportMenuFile,Settings.XRes,Settings.YRes)
    local SelectActionMenuFile = love.filesystem.read("SVG/SelectMenu.svg")
    SelectActionBackdrop = tove.newGraphics(SelectActionMenuFile,Settings.XRes,Settings.YRes)
    local SettingsMenuFile = love.filesystem.read("SVG/SettingsMenu.svg")
    SettingsMenuBackdrop = tove.newGraphics(SettingsMenuFile,Settings.XRes,Settings.YRes)
    local GameBarFile = love.filesystem.read("SVG/GameBar.svg")
    GameBarBackdrop = tove.newGraphics(GameBarFile,Settings.XRes,Settings.YRes)
end
function LoadSettings()
    Settings={XRes=1024,YRes=576,MSAA=2,Fullscreen=false, FontModifier=4, LineModifier=3,AudioVolume=0,DarkMode=false,ReducedFlicker=false,FontSelected="Exo"}
    LoadSettingsIO(Settings)
    love.window.setMode(0, 0)
    if Settings.ReducedFlicker then
        love.timer.sleep(0.5)
        love.mouse.setPosition(0,0)
    end
    DetectedX = love.graphics.getWidth()
    DetectedY = love.graphics.getHeight()
    DetectedRes = DetectedX .. " x " .. DetectedY
    love.window.setMode(Settings.XRes,Settings.YRes,{msaa=Settings.MSAA, fullscreen=toboolean(Settings.Fullscreen), borderless=toboolean(Settings.Fullscreen)})
    if Settings.ReducedFlicker then
        love.timer.sleep(0.5)
        love.mouse.setPosition(0,0)
    end
    SettingsResolution=Settings.XRes
    SettingsResolutionDropDownClicked=false
    math.randomseed (os.time())
end
function LoadActivities()
    LoadFlashcards()
    LoadEdit()
    LoadMatching()
    LoadViewSet()
    LoadMissileDefense()
    LoadTestActivity()
end
function LoadFlashcards()
    FlashCardActivityFlashCard=1
    FlashCardActivityFlashCardSide=2
    FlashCardActivityDisplaySideFirst=2
end
function LoadEdit()
    EditActivityLoadOnce=false
    EditActivityScroll=0
    EditActivitySelectedTerm = nil
    EditActivitySelectedDefinition = nil
    EditCursorPosition=0
end
function LoadMouseClickDebounce()
    DebounceTimer=0
end
function ConfirmSettings()
    SaveSettings(Settings)
    love.load()
end
function LoadViewSet()
    ViewActivityScroll=0
end
function LoadPopup()
    PopupCall=false
    PopupAction=""
    PopUpMessage=""
    BackoutAction=""
end
function LoadMissileDefense()
    MissileDefenseTimer=0
    MissileDefenseSpeedFactor=1
    MissileDefenseChallengeCount=0
    MissileDefenseTypedResponse=""
    MissileDefenseChallenges={
        {Challenge="",Answer="",IndividualTimer=0,IncomingMissilePathingPoints={0,0},IncomingMissileRGB={255, 43, 28},TrailPoints={0,0}},
        {Challenge="",Answer="",IndividualTimer=0,IncomingMissilePathingPoints={0,0},IncomingMissileRGB={248, 255, 38},TrailPoints={0,0}},
        {Challenge="",Answer="",IndividualTimer=0,IncomingMissilePathingPoints={0,0},IncomingMissileRGB={255, 38, 179},TrailPoints={0,0}}
    }
    local TerrainMinY=scaling(915,1920,Settings.XRes)
    TerrainPoints=GenerateTerrainPoints(MediumLine,TerrainMinY,scaling(1320,1080,Settings.YRes)-MediumLine,scaling(200,1920,Settings.XRes),50)
    MissileDefenseSurviveTimer=0
    MissileDefenseLivesRemaining=4
    MissileDefenseChallenge1Failed=false
    MissileDefenseChallenge2Failed=false
    MissileDefenseChallenge3Failed=false
    MissileDefenseChallengeFailedStep1Timer=0
    MissileDefenseAChallengeFailed=false
    MissileDefenseChallenge1AccumulatedTime=0
    MissileDefenseChallenge2AccumulatedTime=0
    MissileDefenseChallenge3AccumulatedTime=0
    MissileDefenseCorrectResponses=0
    MissileDefenseLevelUpTimer=0
    MissileDefenseLevelUp=false
    MissileDefenseChallenges[1].IncomingMissilePathingPoints=GenerateMissilePoints(scaling(196,1920, Settings.XRes), scaling(88,1080, Settings.YRes), scaling(664,1920, Settings.XRes), TerrainMinY-scaling(200,1080,Settings.YRes), 600)
    MissileDefenseChallenges[2].IncomingMissilePathingPoints=GenerateMissilePoints(scaling(664,1920, Settings.XRes), scaling(88,1080, Settings.YRes), scaling(664,1920, Settings.XRes), TerrainMinY-scaling(200,1080,Settings.YRes), 600)
    MissileDefenseChallenges[3].IncomingMissilePathingPoints=GenerateMissilePoints(scaling(1132,1920, Settings.XRes), scaling(88,1080, Settings.YRes), scaling(664,1920, Settings.XRes), TerrainMinY-scaling(200,1080,Settings.YRes), 600)
end
function GenerateTerrainPoints(MinX, MinY, Width, Height, Subdivisions)
    local TableOfPoints = {}
    
    -- Starting point
    table.insert(TableOfPoints, {MinX, MinY})
    
    -- Generate intermediate points
    for i = 1, Subdivisions do
        local X = MinX + (Width / (Subdivisions - 1)) * (i - 1)
        local Y = MinY - math.random(0, Height)
        if i>Subdivisions/2-Subdivisions/8 and i<Subdivisions/2+Subdivisions/8 then
            Y=MinY-scaling(150,1080,Settings.YRes)
            if i>Subdivisions/2-Subdivisions/12 and i<Subdivisions/2+Subdivisions/12 then
                Y=MinY-scaling(170,1080,Settings.YRes)
                if i>Subdivisions/2-Subdivisions/16 and i<Subdivisions/2+Subdivisions/16 then
                    Y=MinY-scaling(200,1080,Settings.YRes)
                end
            end
        end
        table.insert(TableOfPoints, {X, Y})
    end
    
    -- Ending point
    table.insert(TableOfPoints, {MinX + Width, MinY})
    
    return TableOfPoints
end
function GenerateMissilePoints(StartingX, StartingY, EndingX, EndingY, Time)
    -- Create the table to store the interpolated points
    Table = {}
    
    -- Insert the starting position
    table.insert(Table, {StartingX, StartingY})
    
    -- Calculate the step increment for each point
    local stepX = (EndingX - StartingX) / Time
    local stepY = (EndingY - StartingY) / Time
    
    -- Generate the points and insert them into the table
    for i = 1, Time do
        local CalculatedX = StartingX + stepX * i
        local CalculatedY = StartingY + stepY * i
        table.insert(Table, {CalculatedX, CalculatedY})
    end
    for i=1, 100 do--?? extra range just in case
        table.insert(Table, {EndingX,EndingY})
    end
    return Table
end
function LoadTestActivity()
    TestActivityScroll=0
end
function GenerateTestingData()
    SetTitle, SetData, NumberOfTerms = LoadIndividualSet(SetToPreview)
    TestActivityTestTable={}
    for i = 1, NumberOfTerms do
        local wrongAnswers = generateUniqueNumbersExclude(3, NumberOfTerms, i)
        local Positions = generateUniqueNumbers(4, 4)
        table.insert(TestActivityTestTable, {
            TermToTest = SetData[i][2],
            CorrectAnswer = SetData[i][1],
            WrongAnswer1 = SetData[wrongAnswers[1]][1],
            WrongAnswer2 = SetData[wrongAnswers[2]][1],
            WrongAnswer3 = SetData[wrongAnswers[3]][1],
            CorrectAnswerPos = Positions[1],
            WrongAnswer1Pos = Positions[2],
            WrongAnswer2Pos = Positions[3],
            WrongAnswer3Pos = Positions[4],
            SelectedAnswer = 0
        })
    end
    TestActivityTestTable=ShuffleTableCopy(TestActivityTestTable)
end
function GenerateMatchingData()
    SetTitle, SetData, NumberOfTerms = LoadIndividualSet(SetToPreview)
    local WhichCardsToMatchWith=generateUniqueNumbers(4, #SetData)
        MatchingActivity4XTable={
        {SetData[WhichCardsToMatchWith[1]][1],SetData[WhichCardsToMatchWith[1]][2]},
        {SetData[WhichCardsToMatchWith[2]][1],SetData[WhichCardsToMatchWith[2]][2]},
        {SetData[WhichCardsToMatchWith[3]][1],SetData[WhichCardsToMatchWith[3]][2]},
        {SetData[WhichCardsToMatchWith[4]][1],SetData[WhichCardsToMatchWith[4]][2]}
    }
end
function LoadMatching()
    -- Define the range for random positions
    MatchingActivityCurrentCard = nil
    local xMin, xMax = 0, Settings.XRes-200
    local yMin, yMax = 100, Settings.YRes-180
    local w1=100
    local h1=100
    local w2=100
    local h2=100
    MatchingActivityPositions = {}
    for i = 1, 4 do
        -- Generate random positions within the specified range
        local x1 = math.random(xMin, xMax)
        local y1 = math.random(yMin, yMax)
        local x2 = math.random(xMin, xMax)
        local y2 = math.random(yMin, yMax)
        table.insert(MatchingActivityPositions, {{x1, y1, w1, h1}, {x2, y2, w2, h2}})
    end
end
function ApplySettings()
    if Settings.XRes>DetectedX then
        Settings.XRes=DetectedX
    end
    if Settings.YRes>DetectedY then
        Settings.YRes=DetectedY
    end
    LoadFonts()
    LoadBackdrops()
    if Settings.ReducedFlicker then
        love.timer.sleep(0.5)
        love.mouse.setPosition(0,0)
    end
    LoadActivities()
    LoadMouseClickDebounce()
    LoadPopup()
    love.window.setMode(Settings.XRes,Settings.YRes)
    if Settings.ReducedFlicker then
        love.timer.sleep(0.5)
        love.mouse.setPosition(0,0)
    end
end