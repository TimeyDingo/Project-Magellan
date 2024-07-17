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
        SetPreview()
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
    NumberOfSets=CheckSavedSets()
    love.graphics.print(NumberOfSets, 500, 500)
end
function SetPreview()

end
function Backdrop()
    love.graphics.draw(BackdropImage,0,0,0,1,1,0,0)
end
function ImportMenu()
    love.graphics.draw(ImportBackdrop,0,0,0,1,1,0,0)
    ImportSuccess=false
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
                ImportSuccess=true
                return Input, Paste
            end
        else
            love.graphics.setColor(255, 153, 0)
        end
        love.graphics.rectangle("line", boxX, boxY, boxWidth, boxHeight)
        love.graphics.setLineWidth(1)
        love.graphics.setColor(255, 255, 255)
    end
    CancelButton()
    Title, ImportedSet, ImportSuccess=ConfirmButton()
    return Title, ImportedSet, ImportSuccess
end



--! converting love2D shitty color space to rgb color
love.graphics.setColorF = love.graphics.setColor
function love.graphics.setColor(r,g,b,a)
	r, g, b = r/255, g/255, b/255
	love.graphics.setColorF(r,g,b,a)
end