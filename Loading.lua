function LoadFonts()
    Exo24=love.graphics.newFont("Fonts/Exo2.ttf", 24)
    Exo24Bold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", 24)
    Exo20=love.graphics.newFont("Fonts/Exo2.ttf", 20)
    Exo20Bold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", 20)
    Exo28Bold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", 28)
    Exo28=love.graphics.newFont("Fonts/Exo2.ttf", 28)
    Exo32Bold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", 32)
    Exo60Black=love.graphics.newFont("Fonts/Exo2-Black.ttf", 45)
end
function LoadBackdrops()
    BackdropMainMenu=love.graphics.newImage('Selectscreenbackdrop.png')
    BackdropImport=love.graphics.newImage('ImportMenumk3.png')
    BackdropSelectAction=love.graphics.newImage('SelectMenu.png')
    GameBar=love.graphics.newImage('GameBar.png')
end
function LoadSettings()
    Settings={1920,1080,2}
    if LoadSettingsIO(Settings) == 1 then--? If loading is successful 
        love.window.setMode(Settings[1],Settings[2],{msaa=Settings[3]})--! Scaling of various objects need to be correctly done so that resolution can eventually be changed
    end
end
function LoadActivities()
    LoadFlashcards()
end
function LoadFlashcards()
    FlashCardActivityFlashCard=1
    FlashCardActivityFlashCardSide=2
end