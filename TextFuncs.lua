function TextBox(X,Y,Text,TextFont,Alignment,SoftCorners,backgroundR,backgroundG,backgroundB,TextR,TextG,TextB,PaddingLR,PaddingUD,OverRidePadding,OverrideX,OverrideY,Selected)
    love.graphics.setFont(TextFont)
    local TW=0
    local TH=0
    if OverRidePadding=="false" then
        TW=TextFont:getWidth(Text)
        TH=TextFont:getHeight(Text)
    end
    if OverRidePadding=="true" then
        TW=OverrideX
        TH=OverrideY
    end
    if Alignment=="left" then
        AlignmentFactor=PaddingLR/-2
        --add alignments, add padding amounts on each side to the box
    end
    if Alignment=="right" then
        AlignmentFactor=PaddingLR/2
    end
    if Alignment=="center" then
        AlignmentFactor=0
    end
    if SoftCorners=="true" then
        local rx=5
        local ry=5
    else if SoftCorners=="false" then
        local rx=0
        local ry=0
    end
    end
    love.graphics.setColor(backgroundR,backgroundG,backgroundB)
    love.graphics.rectangle("fill",X+((W-TW-PaddingLR)/2),Y+((H-TH-PaddingUD)/2),TW+PaddingLR,TH+PaddingUD,rx,ry)
    love.graphics.setColor(TextR,TextG,TextB)
    love.graphics.print(Text,(((W-TW-PaddingLR)/2)+X+PaddingLR/2)+AlignmentFactor,((H-TH+PaddingUD)/2)+Y-PaddingUD/2)
    local TopLeftX=X+((W-TW-PaddingLR)/2)
    local TopLeftY=Y+((H-TH-PaddingUD)/2)
    local BottomRightX=(X+((W-TW-PaddingLR)/2))+TW+PaddingLR
    local BottomRightY=(Y+((H-TH-PaddingUD)/2))+TH+PaddingUD
    if Selected==true then
        love.graphics.setColor(backgroundR,backgroundG,backgroundB)
        love.graphics.setLineWidth(MediumLine)
        love.graphics.rectangle("line",TopLeftX-10,TopLeftY-10,BottomRightX+20-TopLeftX,BottomRightY+20-TopLeftY)
    end
    return TopLeftX,TopLeftY,BottomRightX,BottomRightY
end
function CenterText(X,Y,Text,TextFont)
    love.graphics.setFont(TextFont)
    local TW=TextFont:getWidth(Text)
    local TH=TextFont:getHeight(Text)
    love.graphics.print(Text,((W-TW)/2)+X,((H-TH)/2)+Y)--Screen Width minus text width divided by 2 + change in x
end
function ButtonStyle1(BoxX,BoxY,BoxW,BoxH,Text,TextFont)
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight(Text)
    local TW = TextFont:getWidth(Text)
    
    -- Check if mouse is over the box
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    
    -- Coordinates for the text
    local textX = BoxX + (BoxW - TW) / 2  -- Center the text horizontally
    local textY = BoxY + (BoxH - TH) / 2        -- Center the text vertically
    
    love.graphics.print(Text, textX, textY)
    love.graphics.setLineWidth(MediumLine)
    if Selected then
        love.graphics.setColor(255, 255, 255)
        if love.mouse.isDown(1) then --! clicked
            return true
        end
    else
        love.graphics.setColor(255, 153, 0)
    end
    love.graphics.rectangle("line", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setLineWidth(ThinLine)
    love.graphics.setColor(255, 255, 255)
end
function ButtonStyle1Mod2(BoxX,BoxY,BoxW,BoxH,Text,TextFont,ClickedValue)
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight(Text)
    local TW = TextFont:getWidth(Text)
    
    -- Check if mouse is over the box
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    
    -- Coordinates for the text
    local textX = BoxX + (BoxW - TW) / 2  -- Center the text horizontally
    local textY = BoxY + (BoxH - TH) / 2        -- Center the text vertically
    
    love.graphics.print(Text, textX, textY)
    love.graphics.setLineWidth(MediumLine)
    if Selected or SetToPreview==ClickedValue then
        love.graphics.setColor(255, 255, 255)
        if love.mouse.isDown(1) then --! clicked
            SetToPreview=ClickedValue
        end
    else
        love.graphics.setColor(255, 153, 0)
    end
    love.graphics.rectangle("line", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setLineWidth(ThinLine)
    love.graphics.setColor(255, 255, 255)
end
function ButtonStyle1Mod3(BoxX, BoxY, BoxW, BoxH, Text, TextFont, Action)--Be able to run a function
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight(Text)
    local TW = TextFont:getWidth(Text)
    
    -- Check if mouse is over the box
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    
    -- Coordinates for the text
    local textX = BoxX + (BoxW - TW) / 2  -- Center the text horizontally
    local textY = BoxY + (BoxH - TH) / 2  -- Center the text vertically
    
    love.graphics.print(Text, textX, textY)
    love.graphics.setLineWidth(MediumLine)
    if Selected then
        love.graphics.setColor(255, 255, 255)
        if love.mouse.isDown(1) then -- Button clicked
            if Action then
                local actionFunc, err = load(Action)
                if actionFunc then
                    actionFunc()
                else
                    print("Error in action string: " .. err)
                end
            end
            return true
        end
    else
        love.graphics.setColor(255, 153, 0)
    end
    love.graphics.rectangle("line", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setLineWidth(ThinLine)
    love.graphics.setColor(255, 255, 255)
end
function CenteredTextBox(BoxX,BoxY,BoxW,BoxH,Text,TextFont)
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight(Text)
    local TW = TextFont:getWidth(Text)
    -- Coordinates for the text
    local textX = BoxX + (BoxW - TW) / 2  -- Center the text horizontally
    local textY = BoxY + (BoxH - TH) / 2        -- Center the text vertically
    love.graphics.print(Text, textX, textY)
end
function CenteredTextBoxWithWrapping(BoxX, BoxY, BoxW, Text, TextFont)
    love.graphics.setFont(TextFont)
    local textHeight = TextFont:getHeight()  -- Height of a single line of text

    -- Calculate the wrapped text and the number of lines
    local wrappedText, lines = TextFont:getWrap(Text, BoxW)
    local totalHeight = #lines * textHeight

    -- Calculate the Y position to vertically center the text
    local textY = BoxY

    -- Print the wrapped and centered text
    love.graphics.printf(Text, BoxX, textY, BoxW, "center")

    return totalHeight
end