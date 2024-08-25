function LoadFonts()
    Exo20=love.graphics.newFont("Fonts/Exo2.ttf", 20-Settings[5])
    Exo24=love.graphics.newFont("Fonts/Exo2.ttf", 24-Settings[5])
    Exo24Bold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", 24-Settings[5])
    Exo20=love.graphics.newFont("Fonts/Exo2.ttf", 20-Settings[5])
    Exo20Bold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", 20-Settings[5])
    Exo28Bold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", 28-Settings[5])
    Exo28=love.graphics.newFont("Fonts/Exo2.ttf", 28-Settings[5])
    Exo32Bold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", 32-Settings[5])
    Exo60Black=love.graphics.newFont("Fonts/Exo2-Black.ttf", 45-Settings[5]*5)
end
function LoadBackdrops()
    --BackdropMainMenu=love.graphics.newImage('Selectscreenbackdrop.png')
        local MainMenuFile = love.filesystem.read("SVG/MainMenu.svg")
        MainMenuBackdrop = tove.newGraphics(MainMenuFile,Settings[1],Settings[2])
    --BackdropImport=love.graphics.newImage('ImportMenumk3.png')
        local ImportMenuFile = love.filesystem.read("SVG/ImportMenu.svg")
        ImportMenuBackdrop = tove.newGraphics(ImportMenuFile,Settings[1],Settings[2])
    --BackdropSelectAction=love.graphics.newImage('SelectMenu.png')
        local SelectActionMenuFile = love.filesystem.read("SVG/SelectMenu.svg")
        SelectActionBackdrop = tove.newGraphics(SelectActionMenuFile,Settings[1],Settings[2])
    --GameBar=love.graphics.newImage('GameBar.png')
        local GameBarFile = love.filesystem.read("SVG/GameBar.svg")
        GameBarBackdrop = tove.newGraphics(GameBarFile,Settings[1],Settings[2])
end
function LoadSettings()
    Settings={1024,600,2,false}
    if LoadSettingsIO(Settings) == 1 then--? If loading is successful 
        love.window.setMode(Settings[1],Settings[2],{msaa=Settings[3], fullscreen=toboolean(Settings[4]), borderless=toboolean(Settings[4])})
    end
    SettingsResolution=Settings[1]
    SettingsFullscreen=toboolean(Settings[4])
    math.randomseed (os.time())
end
function LoadActivities()
    LoadFlashcards()
    LoadEdit()
    LoadMatching()
    LoadViewSet()
    LoadMissileDefense()
end
function LoadFlashcards()
    FlashCardActivityFlashCard=1
    FlashCardActivityFlashCardSide=2
end
function LoadEdit()
    EditActivityLoadOnce=false
    EditActivityScroll=0
end
function LoadMouseClickDebounce()
    DebounceTimer=0
end
function LoadMatching()
    -- Define the range for random positions
    MatchingActivityLoadOnce = false
    MatchingActivityTable = {}
    MatchingActivityCurrentCard = nil
    local xMin, xMax = 0, Settings[1]-200
    local yMin, yMax = 0, Settings[2]-180
    local w1=100
    local h1=100
    local w2=100
    local h2=100
    MatchingActivityPositions = {}
    for i = 1, 100 do
        -- Generate random positions within the specified range
        local x1 = math.random(xMin, xMax)
        local y1 = math.random(yMin, yMax)
        local x2 = math.random(xMin, xMax)
        local y2 = math.random(yMin, yMax)
        table.insert(MatchingActivityPositions, {{x1, y1, w1, h1}, {x2, y2, w2, h2}})
    end
end
function LoadLineThickness()
    local MediumLineSubtraction=0
    if Settings[6] > 0 then
        MediumLineSubtraction=1
    end
    ThickLine=5-Settings[6]
    MediumLine=3-MediumLineSubtraction
    ThinLine=1
end
function ConfirmSettings()
    if SettingsResolution==1920 then
        Settings[1]=1920
        Settings[2]=1080
        Settings[5]=0
        Settings[6]=0
    end
    if SettingsResolution==1280 then
        Settings[1]=1280
        Settings[2]=720
        Settings[5]=3
        Settings[6]=2
    end
    if SettingsResolution==1024 then
        Settings[1]=1024
        Settings[2]=576
        Settings[5]=4
        Settings[6]=3
    end
    if SettingsFullscreen==true then
        Settings[4]=true
    end
    if SettingsFullscreen==false then
        Settings[4]=false
    end
    SaveSettings(Settings)
    LoadSettings()
    LoadBackdrops()
    LoadActivities()
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
    MissileDefenseChallengeCount=0
    MissileDefenseTypedResponse=""
    MissileDefenseChallenges={{"","",0},{"","",0},{"","",0}}
    local TerrainMinY=scaling(915,1920,Settings[1])
    TerrainPoints=GenerateTerrainPoints(MediumLine,TerrainMinY,scaling(1320,1080,Settings[2])-MediumLine,scaling(200,1920,Settings[1]),50)
    MissileDefenseSurviveTimer=0
    MissileDefenseLivesRemaining=3
    MissileDefenseChallenge1Failed=false
    MissileDefenseChallenge2Failed=false
    MissileDefenseChallenge3Failed=false
    MissileDefenseChallengeFailedStep1Timer=0
    MissileDefenseAChallengeFailed=false
    Missile1Points=GenerateMissilePoints(scaling(196,1920, Settings[1]), scaling(65,1080, Settings[2]), scaling(664,1920, Settings[1]), TerrainMinY-scaling(200,1080,Settings[2]), 600)
    Missile2Points=GenerateMissilePoints(scaling(664,1920, Settings[1]), scaling(65,1080, Settings[2]), scaling(664,1920, Settings[1]), TerrainMinY-scaling(200,1080,Settings[2]), 600)
    Missile3Points=GenerateMissilePoints(scaling(1132,1920, Settings[1]), scaling(65,1080, Settings[2]), scaling(664,1920, Settings[1]), TerrainMinY-scaling(200,1080,Settings[2]), 600)
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
            Y=MinY-scaling(150,1080,Settings[2])
            if i>Subdivisions/2-Subdivisions/12 and i<Subdivisions/2+Subdivisions/12 then
                Y=MinY-scaling(170,1080,Settings[2])
                if i>Subdivisions/2-Subdivisions/16 and i<Subdivisions/2+Subdivisions/16 then
                    Y=MinY-scaling(200,1080,Settings[2])
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