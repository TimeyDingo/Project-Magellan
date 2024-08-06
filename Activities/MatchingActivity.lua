function MatchingActivity()
    SetTitle, SetData = LoadIndividualSet(SetToPreview)
    CenterText(0, -450, SetTitle, Exo32Bold)
    local NumberOfTerms = #SetData

    for i = 1, NumberOfTerms do
        for j = 1, 2 do
            DisplayMatchingCard(MatchingActivityPositions[i + (j-1) * NumberOfTerms][1], MatchingActivityPositions[i + (j-1) * NumberOfTerms][2], 600, 250, SetData[i][j], Exo24, i + (j-1) * NumberOfTerms)
        end
    end
end

function DisplayMatchingCard(BoxX, BoxY, BoxW, BoxH, Text, TextFont, CardNumber)
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    
    -- Handle mouse input
    if Selected and love.mouse.isDown(1) then  -- Left mouse button clicked
        if currentCard == nil then  -- No card is currently selected
            currentCard = CardNumber  -- Select this card
        end
    end
    
    if currentCard == CardNumber then
        if love.mouse.isDown(1) then
            love.graphics.setColor(255, 255, 255)
            MatchingActivityPositions[CardNumber][1] = love.mouse.getX() - BoxW / 2
            MatchingActivityPositions[CardNumber][2] = love.mouse.getY() - BoxH / 2
        else
            currentCard = nil  -- Deselect the card when the mouse button is released
        end
    end
    
    -- Wrap the text and calculate dimensions
    love.graphics.setFont(TextFont)
    local _, wrappedText = TextFont:getWrap(Text, BoxW)
    local wrappedHeight = #wrappedText * TextFont:getHeight()

    -- Coordinates for the text
    local textX = BoxX
    local textY = BoxY + (BoxH - wrappedHeight) / 2  -- Center the text vertically
    
    -- Draw the wrapped text
    love.graphics.setColor(255, 255, 255)  -- Set text color to white
    love.graphics.printf(Text, textX, textY, BoxW, "center")
    
    -- Draw the box border
    love.graphics.setLineWidth(3)
    if currentCard==CardNumber then
        love.graphics.setColor(255, 255, 255)  -- Set border color
    else
        love.graphics.setColor(255, 153, 0)
    end
    love.graphics.rectangle("line", BoxX, BoxY, BoxW, BoxH)
    
    -- Reset line width and color
    love.graphics.setLineWidth(1)
    love.graphics.setColor(255, 255, 255)
end






function MatchingPositionPercentage(XPosA, YPosA, WidthA, HeightA, XPosB, YPosB, WidthB, HeightB)
    -- Calculate the edges of the rectangles
    local rightA = XPosA + WidthA
    local bottomA = YPosA + HeightA
    local rightB = XPosB + WidthB
    local bottomB = YPosB + HeightB
    
    -- Calculate the overlap boundaries
    local overlapLeft = math.max(XPosA, XPosB)
    local overlapRight = math.min(rightA, rightB)
    local overlapTop = math.max(YPosA, YPosB)
    local overlapBottom = math.min(bottomA, bottomB)
    
    -- Calculate the overlap width and height
    local overlapWidth = math.max(0, overlapRight - overlapLeft)
    local overlapHeight = math.max(0, overlapBottom - overlapTop)
    
    -- Calculate the area of the overlapping region
    local overlapArea = overlapWidth * overlapHeight
    
    -- Calculate the area of the first and second rectangles
    local areaA = WidthA * HeightA
    local areaB = WidthB * HeightB
    
    -- Calculate the percentage of overlap with respect to both rectangles
    local percentageA = (overlapArea / areaA) * 100
    local percentageB = (overlapArea / areaB) * 100
    
    -- Calculate the overall overlap percentage as the average of the two percentages
    local overallOverlap = (percentageA + percentageB) / 2
    
    return overallOverlap
end
