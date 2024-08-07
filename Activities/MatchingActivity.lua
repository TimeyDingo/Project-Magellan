function MatchingActivity()
    SetTitle, SetData = LoadIndividualSet(SetToPreview)
    if MatchingActivityLoadOnce==false then
        MatchingActivityTable=SetData
        MatchingActivityLoadOnce=true
    end
    CenterText(0, -450, SetTitle, Exo32Bold)
    local NumberOfTerms = #SetData
    CenterText(0,-400,tostring(#MatchingActivityTable).."/"..tostring(#SetData),Exo32Bold)--?? The count
    local CardNumber=0
    for i = 1, #MatchingActivityTable do
        --[[
        if MatchingPositionPercentage(MatchingActivityPositions[i][1][1], MatchingActivityPositions[i][1][2], 600, 250,MatchingActivityPositions[i][2][1], MatchingActivityPositions[i][2][2], 600, 250) > 75 then
            table.remove(MatchingActivityTable, i)
        end
        ]]
        for j = 1, 2 do
            CardNumber=CardNumber+1
            DisplayMatchingCard(MatchingActivityPositions[i][j][1], MatchingActivityPositions[i][j][2], 600, 250, MatchingActivityTable[i][j], Exo24, i,j, CardNumber)--i + (j-1) * NumberOfTerms
        end
    end
    CenterText(0,0,tostring(MatchingPositionPercentage(MatchingActivityPositions[1][1][1], MatchingActivityPositions[1][1][2], 600, 250,MatchingActivityPositions[1][2][1], MatchingActivityPositions[1][2][2], 600, 250)),Exo60Black)
end
function DisplayMatchingCard(BoxX, BoxY, BoxW, BoxH, Text, TextFont, Pair, PairSubset, CardNumber)
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
    if type(Text) == "string" then
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
    else
        -- Handle the case where Text is not a string (optional)
        print("Warning: Text is not a string")
    end
    
    -- Draw the box border
    love.graphics.setLineWidth(3)
    if MatchingActivityCurrentCard == CardNumber then
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