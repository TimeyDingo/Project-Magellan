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
        if love.mouse.isDown(1) and SetToPreview>0 then
            StateMachine="Set Options"
        end
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
            StateMachine="Import Menu"
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
    local TopLeftX=267
    local TopLeftY=156
    local Width=656
    local Height=651
    love.graphics.setLineWidth(5)
    love.graphics.setColor(22, 22, 22)
    love.graphics.rectangle("line", TopLeftX,TopLeftY,Width,Height)
    love.graphics.setColor(255,255,255)
    love.graphics.setLineWidth(1)
    local NumberofSets=CheckSavedSets()
    if NumberofSets>0 then
        ButtonStyle1Mod2(283,173,624,59,tostring(SetData[1][1]),Exo24,1)
    end
    if NumberofSets>1 then
        ButtonStyle1Mod2(283,266,624,59,tostring(SetData[2][1]),Exo24,2) 
    end
    if NumberofSets>2 then
        ButtonStyle1Mod2(283,359,624,59,tostring(SetData[3][1]),Exo24,3)
    end
    if NumberofSets>3 then
        ButtonStyle1Mod2(283,452,624,59,tostring(SetData[4][1]),Exo24,4)
    end
    if NumberofSets>4 then
        ButtonStyle1Mod2(283,545,624,59,tostring(SetData[5][1]),Exo24,5)
    end
    if NumberofSets>5 then
        ButtonStyle1Mod2(283,638,624,59,tostring(SetData[6][1]),Exo24,6)
    end
    if NumberofSets>6 then
        ButtonStyle1Mod2(283,731,624,59, tostring(SetData[7][1]),Exo24,7)
    end
    --Space between top and bottom is 17, space between buttons is 93
end
function SetPreview()
    local x = 976  -- Starting X position for text drawing
    local y = 156  -- Starting Y position for text drawing
    local WrapDistance=0

    if SetToPreview > 0 and SetData[SetToPreview] then
        local setTitle = SetData[SetToPreview][1]
        local dataSet = SetData[SetToPreview][2]
        CenteredTextBox(976, 135, 673, 59, setTitle, Exo24Bold)
        love.graphics.setFont(Exo24)
        y = y + 20  -- Move to the next line

        for i, item in ipairs(dataSet) do
            local definition = item[1]
            local term = item[2]
            CenteredTextBox(x,y,673,30,term,Exo20Bold)
            y=y+20
            WrapDistance=CenteredTextBoxWithWrapping(x,y,673,definition,Exo20)
            y = y + WrapDistance  -- Move to the next line
            if y>945 then
                love.graphics.setColor(255,255,255,0)
            end
        end
    end
    love.graphics.setColor(255,255,255,255)
    love.graphics.setFont(Exo24)
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
                Paste = "Paste Text Here"
                Input = ""
                StateMachine="Main Menu"
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
                StateMachine="Main Menu"
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