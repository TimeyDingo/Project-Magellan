function FlashcardActivity()
    SetTitle, SetData = LoadIndividualSet(SetToPreview)
    CenterText(0,scaling(-450,1080,Settings[2]),SetTitle,Exo32Bold)
    CenterText(0,scaling(-400,1080,Settings[2]),tostring(FlashCardActivityFlashCard).."/"..tostring(#SetData),Exo32Bold)
    --CenterText(0,0,tostring(SetData[2][2]),Exo24)
    DisplayFlashCard(scaling(578,1920,Settings[1]),scaling(308,1080,Settings[2]),scaling(763,1920,Settings[1]),scaling(464,1080,Settings[2]),tostring(SetData[FlashCardActivityFlashCard][FlashCardActivityFlashCardSide]),Exo24Bold)
    FlashCardKeyboardControls()
end
function DisplayFlashCard(BoxX, BoxY, BoxW, BoxH, Text, TextFont)
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight() * #Text / BoxW -- Estimate height based on wrapping
    local _, wrappedText = TextFont:getWrap(Text, BoxW)
    local wrappedHeight = #wrappedText * TextFont:getHeight()
    
    -- Check if mouse is over the box
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    
    -- Coordinates for the text
    local textY = BoxY + (BoxH - wrappedHeight) / 2  -- Center the text vertically
    
    love.graphics.printf(Text, BoxX, textY, BoxW, "center")  -- Print wrapped and centered text
    love.graphics.setLineWidth(MediumLine)
    if FlashCardActivityFlashCardSide==1 then
        love.graphics.setColor(255, 255, 255)
    else
        love.graphics.setColor(255, 153, 0)
    end
    if Selected then
        function love.mousepressed(x, y, button, istouch, presses)
            if button == 1 then  -- Check for left mouse button
                FlipCard()
            end
        end
    end
    love.graphics.rectangle("line", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setLineWidth(ThinLine)
    love.graphics.setColor(255, 255, 255)
end
function FlashCardKeyboardControls()
        if ButtonDebounce("left", 30) then
            if FlashCardActivityFlashCard==1 then
                FlashCardActivityFlashCard=#SetData
            else
                FlashCardActivityFlashCard=FlashCardActivityFlashCard-1
            end
            FlashCardActivityFlashCardSide=2
        end
        if ButtonDebounce("right", 30) then
            if FlashCardActivityFlashCard==#SetData then
                FlashCardActivityFlashCard=1
            else
                FlashCardActivityFlashCard=FlashCardActivityFlashCard+1
            end
            FlashCardActivityFlashCardSide=2
        end
        if ButtonDebounce("up", 30) then
            FlipCard()
        end
        if ButtonDebounce("down", 30) then
            FlipCard()
        end
end
function FlipCard()
    if FlashCardActivityFlashCardSide==1 then
        FlashCardActivityFlashCardSide=2
    else
        FlashCardActivityFlashCardSide=1
    end
end
function ResetFlashCardActivity()
    LoadFlashcards()
end