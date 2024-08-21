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
end
function LoadMissileDefense()
    MissileDefenseTimer=0
    MissileDefenseTypedResponse=""
    TerrainPoints=GenerateTerrainPoints(MediumLine,scaling(915,1920,Settings[1]),scaling(1320,1080,Settings[2])-MediumLine,scaling(200,1920,Settings[1]),50)
end
function GenerateTerrainPoints(MinX, MinY, Width, Height, Subdivisions)
    local TableOfPoints = {}
    
    -- Starting point
    table.insert(TableOfPoints, {MinX, MinY})
    
    -- Generate intermediate points
    for i = 1, Subdivisions do
        local X = MinX + (Width / (Subdivisions - 1)) * (i - 1)
        local Y = MinY - math.random(0, Height)
        table.insert(TableOfPoints, {X, Y})
    end
    
    -- Ending point
    table.insert(TableOfPoints, {MinX + Width, MinY})
    
    return TableOfPoints
end
