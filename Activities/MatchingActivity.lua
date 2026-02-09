function MatchingActivity()
    --SetTitle, SetData = LUASetRead(SetToPreview)
    SetData = LUASetRead(SetToPreview)
    if SetData==nil or MatchingActivity4XTable==nil or MatchingActivityPositions==nil then
        print("In MatchingActivity() SetData is reporting as: "..tostring(SetData))
        print("In MatchingActivity() MatchingActivity4XTable is reporting as: "..tostring(MatchingActivity4XTable))
        print("In MatchingActivity() MatchingActivityPositions is reporting as: "..tostring(MatchingActivityPositions))
        return
    end
    N5BoxHighlight(660, 145, 600, 50, true, {255,255,255}, true, SmallHeaderBold, SetData.Title)
    N5BoxHighlight(830, 90, 240, 50, true, {255,255,255}, true, SmallHeaderBold, tostring(#MatchingActivity4XTable).."/4")
    if #MatchingActivity4XTable==0 then
        GenerateMatchingData()
        LoadMatching()
    end
    RemoveMatchingCards()

    local CardNumber=0
    for i = 1, #MatchingActivity4XTable do
        for j = 1, 2 do
            CardNumber=CardNumber+1
            MatchingActivityPositions[i][j][3], MatchingActivityPositions[i][j][4] = DisplayMatchingCard(MatchingActivityPositions[i][j][1], MatchingActivityPositions[i][j][2], MatchingActivity4XTable[i][j], BodyFont, i,j, CardNumber)--i + (j-1) * NumberOfTerms
        end
    end
end
function DisplayMatchingCard(BoxX, BoxY, Text, TextFont, Pair, PairSubset, CardNumber)
    local BoxW=100
    local BoxH=100
    if BoxX==nil or BoxY==nil or Text==nil or TextFont==nil or Pair==nil or PairSubset==nil or CardNumber==nil then
        print("In DisplayMatchingCard() BoxX is reporting as: "..tostring(BoxX))
        print("In DisplayMatchingCard() BoxY is reporting as: "..tostring(BoxY))
        print("In DisplayMatchingCard() Text is reporting as: "..tostring(Text))
        print("In DisplayMatchingCard() TextFont is reporting as: "..tostring(TextFont))
        print("In DisplayMatchingCard() Pair is reporting as: "..tostring(Pair))
        print("In DisplayMatchingCard() PairSubset is reporting as: "..tostring(PairSubset))
        print("In DisplayMatchingCard() CardNumber is reporting as: "..tostring(CardNumber))
        return
    end
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
    love.graphics.setColor(0, 0, 0)  -- Set text color to black
    love.graphics.printf(Text, textX, textY, BoxW, "center")
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    -- Handle mouse input
    if Selected and love.mouse.isDown(1) then  -- Left mouse button clicked
        if MatchingActivityCurrentCard == nil then  -- No card is currently selected
            MatchingActivityCurrentCard = CardNumber  -- Select this card
        end
    end
    if MatchingActivityCurrentCard == CardNumber then
        if love.mouse.isDown(1) then
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
        love.graphics.setColorF(255, 255, 255) -- white
        love.graphics.line( BoxX, BoxY, BoxX+BoxW, BoxY) -- horizontal top
        love.graphics.line( BoxX, BoxY, BoxX, BoxY+BoxH) -- vertical left
        love.graphics.line( BoxX, BoxY+BoxH, BoxX+BoxW, BoxY+BoxH) -- horizontal bottom
        love.graphics.line( BoxX+BoxW, BoxY, BoxX+BoxW, BoxY+BoxH) -- vertical right
        love.graphics.setColorF(0, 0, 0) -- black
        love.graphics.line( BoxX, BoxY, BoxX+BoxW, BoxY) -- horizontal top
        love.graphics.line( BoxX, BoxY, BoxX, BoxY+BoxH) -- vertical left
    else
        love.graphics.setColorF(255, 255, 255) -- white
        love.graphics.line( BoxX, BoxY, BoxX+BoxW, BoxY) -- horizontal top
        love.graphics.line( BoxX, BoxY, BoxX, BoxY+BoxH) -- vertical left
        love.graphics.setColorF(0, 0, 0) -- black
        love.graphics.line( BoxX, BoxY+BoxH, BoxX+BoxW, BoxY+BoxH) -- horizontal bottom
        love.graphics.line( BoxX+BoxW, BoxY, BoxX+BoxW, BoxY+BoxH) -- vertical right
    end
    
    -- Reset line width and color
    love.graphics.setLineWidth(ThinLine)
    love.graphics.setColor(255, 255, 255)
    return BoxW, BoxH
end
function RemoveMatchingCards()
    local indicesToRemove = {}
    if MatchingActivity4XTable==nil or MatchingActivityPositions==nil then
        print("Crash in RemoveMatchingCards".."MatchingActivity4XTable:"..tostring(MatchingActivity4XTable).."MatchingActivityPositions:"..tostring(MatchingActivityPositions))
        return
    end
    for i = 1, #MatchingActivity4XTable do
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
        table.remove(MatchingActivity4XTable, index)
        table.remove(MatchingActivityPositions, index)
        MatchingActivityCurrentCard=nil
    end
end
function MatchingPositionPercentage(XPosA, YPosA, WidthA, HeightA, XPosB, YPosB, WidthB, HeightB)
    if XPosA==nil or YPosA==nil or WidthA==nil or HeightA==nil or XPosB==nil or YPosB==nil or WidthB==nil or HeightB==nil then
        print("In MatchingPositionPercentage() XPosA is reporting as: "..tostring(XPosA))
        print("In MatchingPositionPercentage() YPosA is reporting as: "..tostring(YPosA))
        print("In MatchingPositionPercentage() WidthA is reporting as: "..tostring(WidthA))
        print("In MatchingPositionPercentage() HeightA is reporting as: "..tostring(HeightA))
        print("In MatchingPositionPercentage() XPosB is reporting as: "..tostring(XPosB))
        print("In MatchingPositionPercentage() YPosB is reporting as: "..tostring(YPosB))
        print("In MatchingPositionPercentage() WidthB is reporting as: "..tostring(WidthB))
        print("In MatchingPositionPercentage() HeightB is reporting as: "..tostring(HeightB))
        return
    end
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
    if TextFont==nil or Text==nil or baseRatio==nil or targetRatio==nil or transitionPoint==nil or minWordCount==nil then
        print("In CalculateWrap() TextFont is reporting as: "..tostring(TextFont))
        print("In CalculateWrap() Text is reporting as: "..tostring(Text))
        print("In CalculateWrap() baseRatio is reporting as: "..tostring(baseRatio))
        print("In CalculateWrap() targetRatio is reporting as: "..tostring(targetRatio))
        print("In CalculateWrap() transitionPoint is reporting as: "..tostring(transitionPoint))
        print("In CalculateWrap() minWordCount is reporting as: "..tostring(minWordCount))
        return
    end
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