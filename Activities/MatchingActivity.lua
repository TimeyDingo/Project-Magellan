function MatchingActivity()
    SetTitle, SetData = LoadIndividualSet(SetToPreview)
    if MatchingActivityLoadOnce==false then
        MatchingActivityTable=SetData
        MatchingActivityLoadOnce=true
    end
    CenterText(0, scaling(-450,1080,Settings[2]), SetTitle, Exo32Bold)
    CenterText(0,scaling(-400,1080,Settings[2]),tostring(#MatchingActivityTable).."/"..tostring(#SetData),Exo32Bold)--?? The count
    
    RemoveMatchingCards()

    local CardNumber=0
    for i = 1, #MatchingActivityTable do
        for j = 1, 2 do
            CardNumber=CardNumber+1
            MatchingActivityPositions[i][j][3], MatchingActivityPositions[i][j][4] = DisplayMatchingCard(MatchingActivityPositions[i][j][1], MatchingActivityPositions[i][j][2], MatchingActivityTable[i][j], Exo24, i,j, CardNumber)--i + (j-1) * NumberOfTerms
        end
    end
end
function DisplayMatchingCard(BoxX, BoxY, Text, TextFont, Pair, PairSubset, CardNumber)
    local BoxW=100
    local BoxH=100
    if type(Text) == "string" then
        -- Wrap the text and calculate dimensions
        BoxW=CalculateWrap(TextFont, Text, 0.8, 0.15, 10, 5)
        love.graphics.setFont(TextFont)
        local _, wrappedText = TextFont:getWrap(Text, BoxW)
        local wrappedHeight = #wrappedText * TextFont:getHeight()
        BoxH=wrappedHeight
        -- Coordinates for the text
        local textX = BoxX
        local textY = BoxY + (BoxH - wrappedHeight) / 2  -- Center the text vertically
        
        -- Draw the wrapped text
        love.graphics.setColor(255, 255, 255)  -- Set text color to white
        love.graphics.printf(Text, textX, textY, BoxW, "center")
    else
        -- Handle the case where Text is not a string (optional)
        print("Warning: Text is not a string")
    end
    
    
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    
    -- Handle mouse input
    if Selected and love.mouse.isDown(1) then  -- Left mouse button clicked
        if MatchingActivityCurrentCard == nil then  -- No card is currently selected
            MatchingActivityCurrentCard = CardNumber  -- Select this card
        end
    end
    
    if MatchingActivityCurrentCard == CardNumber then
        if love.mouse.isDown(1) then
            love.graphics.setColor(255, 255, 255)
            MatchingActivityPositions[Pair][PairSubset][1] = love.mouse.getX() - BoxW / 2
            MatchingActivityPositions[Pair][PairSubset][2] = love.mouse.getY() - BoxH / 2
        else
            MatchingActivityCurrentCard = nil  -- Deselect the card when the mouse button is released
        end
    end
    
    -- Ensure Text is a string before wrapping
    
    -- Draw the box border
    love.graphics.setLineWidth(MediumLine)
    if MatchingActivityCurrentCard == CardNumber then
        love.graphics.setColor(255, 255, 255)  -- Set border color
    else
        love.graphics.setColor(255, 153, 0)
    end
    love.graphics.rectangle("line", BoxX, BoxY, BoxW, BoxH)
    
    -- Reset line width and color
    love.graphics.setLineWidth(ThinLine)
    love.graphics.setColor(255, 255, 255)
    return BoxW, BoxH
end
function RemoveMatchingCards()
    -- Identify the indices of cards to remove
    local indicesToRemove = {}
    for i = 1, #MatchingActivityTable do
        if MatchingPositionPercentage(
            MatchingActivityPositions[i][1][1], MatchingActivityPositions[i][1][2], MatchingActivityPositions[i][1][3], MatchingActivityPositions[i][1][4],
            MatchingActivityPositions[i][2][1], MatchingActivityPositions[i][2][2], MatchingActivityPositions[i][2][3], MatchingActivityPositions[i][2][4]
        ) > 50 then
            table.insert(indicesToRemove, i)
        end
    end
    
    -- Remove the identified cards and their positions
    for i = #indicesToRemove, 1, -1 do
        local index = indicesToRemove[i]
        table.remove(MatchingActivityTable, index)
        table.remove(MatchingActivityPositions, index)
        MatchingActivityCurrentCard=nil
    end
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
function CalculateWrap(TextFont, Text, baseRatio, targetRatio, transitionPoint, minWordCount)
    -- Count the number of words in the text by counting the spaces
    local wordCount = 1  -- Start with 1 because the last word won't have a trailing space
    for _ in string.gmatch(Text, "%S+") do
        wordCount = wordCount + 1
    end

    -- Get the width of the text using the provided font
    local textWidth = TextFont:getWidth(Text)
    
    -- If the word count is below the minimum word count, return the full text width
    if wordCount < minWordCount then
        return textWidth
    end
    
    -- Calculate the ratio based on the number of words
    local ratio
    if wordCount <= transitionPoint then
        ratio = baseRatio
    else
        -- Gradually approach the target ratio
        local excessWords = wordCount - transitionPoint
        ratio = baseRatio - (baseRatio - targetRatio) * (excessWords / (25 - transitionPoint))
        -- Ensure the ratio does not fall below the target ratio
        if ratio < targetRatio then
            ratio = targetRatio
        end
    end
    
    -- Calculate the wrap width based on the adjusted ratio
    local wrapWidth = textWidth * ratio

    return wrapWidth
end