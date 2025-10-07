function LoadFonts()
    if Settings.FontSelected=="Stylized" then
        SmallBodyFont=love.graphics.newFont("Fonts/Exo2.ttf", scaling(20,1080,Settings.YRes,true)+FontTransform())
        SmallBodyFontBold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", scaling(20,1080,Settings.YRes,true)+FontTransform())
        BodyFont=love.graphics.newFont("Fonts/Exo2.ttf", scaling(24,1080,Settings.YRes,true)+FontTransform())
        BodyFontBold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", scaling(24,1080,Settings.YRes,true)+FontTransform())
        LargeBodyFont=love.graphics.newFont("Fonts/Exo2.ttf", scaling(28,1080,Settings.YRes,true)+FontTransform())
        LargeBodyFontBold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", scaling(28,1080,Settings.YRes,true)+FontTransform())
        SmallHeaderBold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", scaling(32,1080,Settings.YRes,true))
        MediumHeaderBold=love.graphics.newFont("Fonts/IBMPlexMono-Bold.ttf", scaling(34,1080,Settings.YRes,true))
        LargeHeader=love.graphics.newFont("Fonts/IBMPlexMono-Bold.ttf", scaling(60,1080,Settings.YRes,true))
    end
    if Settings.FontSelected=="Exo2" then
        SmallBodyFont=love.graphics.newFont("Fonts/Exo2.ttf", scaling(20,1080,Settings.YRes,true)+FontTransform())
        SmallBodyFontBold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", scaling(20,1080,Settings.YRes,true)+FontTransform())
        BodyFont=love.graphics.newFont("Fonts/Exo2.ttf", scaling(24,1080,Settings.YRes,true)+FontTransform())
        BodyFontBold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", scaling(24,1080,Settings.YRes,true)+FontTransform())
        LargeBodyFont=love.graphics.newFont("Fonts/Exo2.ttf", scaling(28,1080,Settings.YRes,true)+FontTransform())
        LargeBodyFontBold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", scaling(28,1080,Settings.YRes,true)+FontTransform())
        SmallHeaderBold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", scaling(32,1080,Settings.YRes,true))
        MediumHeaderBold=love.graphics.newFont("Fonts/Exo2-Black.ttf", scaling(34,1080,Settings.YRes,true))
        LargeHeader=love.graphics.newFont("Fonts/Exo2-Black.ttf", scaling(60,1080,Settings.YRes,true))
    end
    if Settings.FontSelected=="AtkinsonHyperlegible" then
        SmallBodyFont=love.graphics.newFont("Fonts/AtkinsonHyperlegible-Regular.ttf", scaling(20,1080,Settings.YRes,true)+FontTransform())
        SmallBodyFontBold=love.graphics.newFont("Fonts/AtkinsonHyperlegible-Bold.ttf", scaling(20,1080,Settings.YRes,true)+FontTransform())
        BodyFont=love.graphics.newFont("Fonts/AtkinsonHyperlegible-Regular.ttf", scaling(24,1080,Settings.YRes,true)+FontTransform())
        BodyFontBold=love.graphics.newFont("Fonts/AtkinsonHyperlegible-Bold.ttf", scaling(24,1080,Settings.YRes,true)+FontTransform())
        LargeBodyFont=love.graphics.newFont("Fonts/AtkinsonHyperlegible-Regular.ttf", scaling(28,1080,Settings.YRes,true)+FontTransform())
        LargeBodyFontBold=love.graphics.newFont("Fonts/AtkinsonHyperlegible-Bold.ttf", scaling(28,1080,Settings.YRes,true)+FontTransform())
        SmallHeaderBold=love.graphics.newFont("Fonts/AtkinsonHyperlegible-Bold.ttf", scaling(32,1080,Settings.YRes,true))
        MediumHeaderBold=love.graphics.newFont("Fonts/AtkinsonHyperlegible-Bold.ttf", scaling(34,1080,Settings.YRes,true))
        LargeHeader=love.graphics.newFont("Fonts/AtkinsonHyperlegible-Bold.ttf", scaling(60,1080,Settings.YRes,true))
    end
    if Settings.FontSelected=="IBMPlex" then
        SmallBodyFont=love.graphics.newFont("Fonts/IBMPlexMono-Regular.ttf", scaling(20,1080,Settings.YRes,true)+FontTransform())
        SmallBodyFontBold=love.graphics.newFont("Fonts/IBMPlexMono-Bold.ttf", scaling(20,1080,Settings.YRes,true)+FontTransform())
        BodyFont=love.graphics.newFont("Fonts/IBMPlexMono-Regular.ttf", scaling(24,1080,Settings.YRes,true)+FontTransform())
        BodyFontBold=love.graphics.newFont("Fonts/IBMPlexMono-Bold.ttf", scaling(24,1080,Settings.YRes,true)+FontTransform())
        LargeBodyFont=love.graphics.newFont("Fonts/IBMPlexMono-Regular.ttf", scaling(28,1080,Settings.YRes,true)+FontTransform())
        LargeBodyFontBold=love.graphics.newFont("Fonts/IBMPlexMono-Bold.ttf", scaling(28,1080,Settings.YRes,true)+FontTransform())
        SmallHeaderBold=love.graphics.newFont("Fonts/IBMPlexMono-Bold.ttf", scaling(32,1080,Settings.YRes,true))
        MediumHeaderBold=love.graphics.newFont("Fonts/IBMPlexMono-Bold.ttf", scaling(34,1080,Settings.YRes,true))
        LargeHeader=love.graphics.newFont("Fonts/IBMPlexMono-Bold.ttf", scaling(60,1080,Settings.YRes,true))
    end
    --fonts for setting menu
    SExo24=love.graphics.newFont("Fonts/Exo2.ttf", scaling(24,1080,Settings.YRes,true))
    SIBM24=love.graphics.newFont("Fonts/IBMPlexMono-Regular.ttf", scaling(24,1080,Settings.YRes,true))
    SAHL24=love.graphics.newFont("Fonts/AtkinsonHyperlegible-Regular.ttf", scaling(24,1080,Settings.YRes,true))
    --line settings
    ThickLine=scaling(5,1080,Settings.YRes,true)
    MediumLine=scaling(3,1080,Settings.YRes,true)
    ThinLine=scaling(1,1080,Settings.YRes,true)
end
function LoadSettings()
    Settings={XRes=1024,YRes=576,MSAA=2,Fullscreen=false, FontModRaw=4, FontModPercent=5, LineModifier=3, AudioRaw=0, AudioPercent=5, DarkMode=false,ReducedFlicker=false,FontSelected="Exo2"}
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
    Dictionary={}
    Dictionary=DictionaryLoader()
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
function ApplySettings(NewX,NewY)
    local PrevX=Settings.XRes
    local PrevY=Settings.YRes
    Settings.XRes=NewX
    Settings.YRes=NewY
    if NewX>DetectedX then
        Settings.XRes=DetectedX
    end
    if NewY>DetectedY then
        Settings.YRes=DetectedY
    end
    LoadFonts()
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
    Settings.FontModRaw=scaling(Settings.FontModRaw,PrevX,Settings.XRes)
    Settings.AudioRaw=scaling(Settings.AudioRaw,PrevX,Settings.XRes)
end
function FontTransform()
    -- Convert percent into a signed scaling factor
    local deviation = (Settings.FontModPercent - 0.5) * 2 -- Ranges from -1 to 1
    local FontChange = math.floor(scaling(deviation * 10, 1920, Settings.XRes))

    -- Ensure FontChange has the correct flipping behavior
    if Settings.FontModPercent < 0.5 then
        FontChange = -math.abs(FontChange) -- Force negative change
    else
        FontChange = math.abs(FontChange)  -- Force positive change
    end
    return FontChange
end
function LoadSounds()
    Sounds={}
    Sounds.blip1=love.audio.newSource("SoundEffects/Blip_Select1.wav", "static")
    Sounds.blip2=love.audio.newSource("SoundEffects/Blip_Select2.wav", "static")
    Sounds.blip3=love.audio.newSource("SoundEffects/Blip_Select3.wav", "static")
    Sounds.blip4=love.audio.newSource("SoundEffects/Blip_Select4.wav", "static")
    Sounds.blip5=love.audio.newSource("SoundEffects/Blip_Select5.wav", "static")
    Sounds.GameEnd=love.audio.newSource("SoundEffects/Game Over.wav", "static")
    Sounds.GameSelected=love.audio.newSource("SoundEffects/Game_Selected.wav", "static")
    Sounds.MissileDefenseStart=love.audio.newSource("SoundEffects/Missle_Defense_Start.wav", "static")
    Sounds.MissileIncoming=love.audio.newSource("SoundEffects/Missle_Incoming.wav", "static")
    Sounds.MissileHit=love.audio.newSource("SoundEffects/Missle_Let_Thru.wav", "static")
    Sounds.Success=love.audio.newSource("SoundEffects/Success.wav", "static")
    Sounds.MissileDestroyed=(love.audio.newSource("SoundEffects/MissileDestroyed.wav", "static"))
    --Sounds.blip1:play()
end
function SetSoundVolume(volume)
    for _, sound in pairs(Sounds) do
        sound:setVolume(volume)
    end
end
