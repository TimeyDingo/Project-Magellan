function SetSelectionMenu()
    Backdrop()
    if ImportMenuOpen==true then
        ImportMenu()
    end
    if ImportMenuOpen==false then
        SelectButton()
        CreateNewSetButton()
        ImportQuizletSetButton()
        ListofSets()
        --SetPreview()
    end
end
-- Function to check if the mouse is over a box
function isMouseOverBox(boxX, boxY, boxWidth, boxHeight)
    return MouseX >= boxX and MouseX <= boxX + boxWidth and MouseY >= boxY and MouseY <= boxY + boxHeight
end

function SelectButton()
    love.graphics.setFont(Exo24Bold)
    local buttonText = "Select"
    local TH = Exo24Bold:getHeight(buttonText)
    local textWidth = Exo24Bold:getWidth(buttonText)

    -- Coordinates for the box
    local boxX = 261
    local boxY = 833
    local boxWidth = 689
    local boxHeight = 41

    -- Check if mouse is over the box
    local Selected = isMouseOverBox(boxX, boxY, boxWidth, boxHeight)

    -- Coordinates for the text
    local textX = boxX + boxWidth - textWidth - 10  -- Adjust -10 to add some padding from the right edge
    local textY = boxY + (boxHeight - TH) / 2

    love.graphics.print(buttonText, textX, textY)
    love.graphics.setLineWidth(3)
    if Selected then
        love.graphics.setColor(255, 255, 255)
    else
        love.graphics.setColor(255, 153, 0)
    end
    love.graphics.rectangle("line", boxX, boxY, boxWidth, boxHeight)
    love.graphics.setLineWidth(1)
    love.graphics.setColor(255, 255, 255)
end

function CreateNewSetButton()
    love.graphics.setFont(Exo24Bold)
    local buttonText = "Create New Set"
    local TH = Exo24Bold:getHeight(buttonText)
    local textWidth = Exo24Bold:getWidth(buttonText)

    -- Coordinates for the box
    local boxX = 261
    local boxY = 889
    local boxWidth = 689
    local boxHeight = 41

    -- Check if mouse is over the box
    local Selected = isMouseOverBox(boxX, boxY, boxWidth, boxHeight)

    -- Coordinates for the text
    local textX = boxX + boxWidth - textWidth - 10  -- Adjust -10 to add some padding from the right edge
    local textY = boxY + (boxHeight - TH) / 2

    love.graphics.print(buttonText, textX, textY)
    love.graphics.setLineWidth(3)
    if Selected then
        love.graphics.setColor(255, 255, 255)
    else
        love.graphics.setColor(255, 153, 0)
    end
    love.graphics.rectangle("line", boxX, boxY, boxWidth, boxHeight)
    love.graphics.setLineWidth(1)
    love.graphics.setColor(255, 255, 255)
end

function ImportQuizletSetButton()
    love.graphics.setFont(Exo24Bold)
    local buttonText = "Import Quizlet Set"
    local TH = Exo24Bold:getHeight(buttonText)
    local textWidth = Exo24Bold:getWidth(buttonText)

    -- Coordinates for the box
    local boxX = 327
    local boxY = 944
    local boxWidth = 624
    local boxHeight = 41

    -- Check if mouse is over the box
    local Selected = isMouseOverBox(boxX, boxY, boxWidth, boxHeight)

    -- Coordinates for the text
    local textX = boxX + boxWidth - textWidth - 10  -- Adjust -10 to add some padding from the right edge
    local textY = boxY + (boxHeight - TH) / 2

    love.graphics.print(buttonText, textX, textY)
    love.graphics.setLineWidth(3)
    if Selected then
        love.graphics.setColor(255, 255, 255)
        if love.mouse.isDown(1) then
            ImportMenuOpen=true
        end
    else
        love.graphics.setColor(255, 153, 0)
    end
    love.graphics.rectangle("line", boxX, boxY, boxWidth, boxHeight)
    love.graphics.setLineWidth(1)
    love.graphics.setColor(255, 255, 255)
end
function ListofSets()
    SetData = LoadSavedSetsIntoMemory()
    CenterText(0,0, tostring(SetData[1][1]), Exo24)
    CenterText(0,100, tostring(SetData[2][1]), Exo24)
    CenterText(0,200, tostring(SetData[3][1]), Exo24)
    local TopLeftX=267
    local TopLeftY=156
    local Width=656
    local Height=651
    love.graphics.setLineWidth(5)
    love.graphics.setColor(22, 22, 22)
    love.graphics.rectangle("line", TopLeftX,TopLeftY,Width,Height)
    love.graphics.setColor(255,255,255)
    love.graphics.setLineWidth(1)
    ButtonStyle1(283,183,624,59,"1",Exo24)
    ButtonStyle1(283,275,624,59,"2",Exo24)
    ButtonStyle1(283,367,624,59,"3",Exo24)
    ButtonStyle1(283,463,624,59,"4",Exo24)
    ButtonStyle1(283,554,624,59,"5",Exo24)
    ButtonStyle1(283,642,624,59,"6",Exo24)
    ButtonStyle1(283,731,624,59,"7",Exo24)
end
function SetPreview()
    SetData = LoadSavedSetsIntoMemory()
    local y = 0

    for i, set in ipairs(SetData) do
        local title = tostring(set[1])
        CenterText(0, y, title, Exo24)
        y = y + 50  -- Adjust y position for the next line

        local dataSet = set[2]
        for _, dataPair in ipairs(dataSet) do
            local dataText = table.concat(dataPair, " ")
            CenterText(0, y, dataText, Exo24)
            y = y + 50  -- Adjust y position for the next line
        end

        y = y + 50  -- Add extra space between sets
    end
end

function Backdrop()
    love.graphics.draw(BackdropImage,0,0,0,1,1,0,0)
end
function ImportMenu()
    love.graphics.draw(ImportBackdrop,0,0,0,1,1,0,0)
    CenterText(0,350,Paste,Exo24)
    CenterText(0,-100,Input,Exo24)
    if love.keyboard.isDown('v')==true and love.keyboard.isDown('lctrl')==true then
        Paste=love.system.getClipboardText()
    end
    function love.textinput(t)
        Input=Input..t
    end
    function love.keypressed(key)
        if key == "backspace" then
            -- get the byte offset to the last UTF-8 character in the string.
            local byteoffset = utf8.offset(Input, -1)
    
            if byteoffset then
                -- remove the last UTF-8 character.
                -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
                Input = string.sub(Input, 1, byteoffset - 1)
            end
        end
    end
    local function CancelButton()
        love.graphics.setFont(Exo24Bold)
        local buttonText = "Cancel"
        local Title, ImportedSet
        local TH = Exo24Bold:getHeight(buttonText)
        local textWidth = Exo24Bold:getWidth(buttonText)
        
        -- Coordinates for the box
        local boxX = 333
        local boxY = 931
        local boxWidth = 418
        local boxHeight = 120
        
        -- Check if mouse is over the box
        local Selected = isMouseOverBox(boxX, boxY, boxWidth, boxHeight)
        
        -- Coordinates for the text
        local textX = boxX + (boxWidth - textWidth) / 2  -- Center the text horizontally
        local textY = boxY + (boxHeight - TH) / 2        -- Center the text vertically
        
        love.graphics.print(buttonText, textX, textY)
        love.graphics.setLineWidth(3)
        if Selected then
            love.graphics.setColor(255, 255, 255)
            if love.mouse.isDown(1) then
                ImportMenuOpen = false
                Paste = "Paste Text Here"
                Input = ""
            end
        else
            love.graphics.setColor(255, 153, 0)
        end
        love.graphics.rectangle("line", boxX, boxY, boxWidth, boxHeight)
        love.graphics.setLineWidth(1)
        love.graphics.setColor(255, 255, 255)
    end
    local function ConfirmButton()
        love.graphics.setFont(Exo24Bold)
        local buttonText = "Confirm"
        local TH = Exo24Bold:getHeight(buttonText)
        local textWidth = Exo24Bold:getWidth(buttonText)
        
        -- Coordinates for the box
        local boxX = 1169
        local boxY = 931
        local boxWidth = 418
        local boxHeight = 120
        
        -- Check if mouse is over the box
        local Selected = isMouseOverBox(boxX, boxY, boxWidth, boxHeight)
        
        -- Coordinates for the text
        local textX = boxX + (boxWidth - textWidth) / 2  -- Center the text horizontally
        local textY = boxY + (boxHeight - TH) / 2        -- Center the text vertically
        
        love.graphics.print(buttonText, textX, textY)
        love.graphics.setLineWidth(3)
        if Selected then
            love.graphics.setColor(255, 255, 255)
            if love.mouse.isDown(1) then
                ImportMenuOpen = false
                ImportAQuizletSet(Input,Paste)
            end
        else
            love.graphics.setColor(255, 153, 0)
        end
        love.graphics.rectangle("line", boxX, boxY, boxWidth, boxHeight)
        love.graphics.setLineWidth(1)
        love.graphics.setColor(255, 255, 255)
    end
    CancelButton()
    ConfirmButton()
end



--! converting love2D shitty color space to rgb color
love.graphics.setColorF = love.graphics.setColor
function love.graphics.setColor(r,g,b,a)
	r, g, b = r/255, g/255, b/255
	love.graphics.setColorF(r,g,b,a)
end