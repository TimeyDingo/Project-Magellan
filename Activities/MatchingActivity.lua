function MatchingActivity()
    SetTitle, SetData = LoadIndividualSet(SetToPreview)
    CenterText(0,-450,SetTitle,Exo32Bold)
    local NumberOfTerms=#SetData
    for i=1, NumberOfTerms do
        DisplayMatchingCard(MatchingActivityPositions[i][1],MatchingActivityPositions[i][2],600,250,"Draggable",Exo24,i)
    end
end
function DisplayMatchingCard(BoxX, BoxY, BoxW, BoxH, Text, TextFont,CardNumber)
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    if Selected then
        if love.mouse.isDown(1) then -- Button clicked
            love.graphics.setColor(255, 255, 255)
            MatchingActivityPositions[CardNumber][1]=MouseX-BoxW/2
            MatchingActivityPositions[CardNumber][2]=MouseY-BoxH/2
        end
    end
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight(Text)
    local TW = TextFont:getWidth(Text)
    
    -- Check if mouse is over the box
    
    -- Coordinates for the text
    local textX = BoxX + (BoxW - TW) / 2  -- Center the text horizontally
    local textY = BoxY + (BoxH - TH) / 2  -- Center the text vertically
    
    love.graphics.print(Text, textX, textY)
    love.graphics.setLineWidth(3)

    love.graphics.setColor(255, 153, 0)
    love.graphics.rectangle("line", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setLineWidth(1)
    love.graphics.setColor(255, 255, 255)
end
