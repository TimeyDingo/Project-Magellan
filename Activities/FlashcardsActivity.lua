function FlashcardActivity()
    SetTitle, SetData = LoadIndividualSet(SetToPreview)
    CenterText(0,-450,SetTitle,Exo32Bold)
    CenterText(0,-400,tostring(FlashCardActivityFlashcard).."/"..tostring(#SetData),Exo32Bold)
    --CenterText(0,0,tostring(SetData[2][2]),Exo24)
    DisplayFlashCard(578,308,763,464,tostring(SetData[FlashCardActivityFlashcard][FlashCardActivityFlashCardSide]),Exo24Bold)
    FlashCardKeyboardControls()
end
function DisplayFlashCard(BoxX, BoxY, BoxW, BoxH, Text, TextFont)--!
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight(Text)
    local TW = TextFont:getWidth(Text)
    
    -- Check if mouse is over the box
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    
    -- Coordinates for the text
    local textX = BoxX + (BoxW - TW) / 2  -- Center the text horizontally
    local textY = BoxY + (BoxH - TH) / 2  -- Center the text vertically
    
    love.graphics.print(Text, textX, textY)
    love.graphics.setLineWidth(3)
    if Selected then
        love.graphics.setColor(255, 255, 255)
        function love.mousepressed(x, y, button, istouch, presses)
            if button == 1 then  -- Check for left mouse button
                FlipCard()
            end
        end        
    else
        love.graphics.setColor(255, 153, 0)
    end
    love.graphics.rectangle("line", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setLineWidth(1)
    love.graphics.setColor(255, 255, 255)
end
function FlashCardKeyboardControls()
    function love.keypressed(key)
        if key == "left" then
            if FlashCardActivityFlashcard==1 then
                FlashCardActivityFlashcard=#SetData
            else
                FlashCardActivityFlashcard=FlashCardActivityFlashcard-1
            end
            FlashCardActivityFlashCardSide=2
        end
        if key == "right" then
            if FlashCardActivityFlashcard==#SetData then
                FlashCardActivityFlashcard=1
            else
                FlashCardActivityFlashcard=FlashCardActivityFlashcard+1
            end
            FlashCardActivityFlashCardSide=2
        end
        if key =="up" then
            FlipCard()
        end
        if key=="down" then
            FlipCard()
        end
    end
end
function FlipCard()
    if FlashCardActivityFlashCardSide==1 then
        FlashCardActivityFlashCardSide=2
    else
        FlashCardActivityFlashCardSide=1
    end
end