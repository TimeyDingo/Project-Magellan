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
    if Text==nil or TextFont==nil or X==nil or Y==nil then
        return
    end
    local TW=TextFont:getWidth(Text)
    local TH=TextFont:getHeight(Text)
    love.graphics.print(Text,((W-TW)/2)+X,((H-TH)/2)+Y)--Screen Width minus text width divided by 2 + change in x
end
function ButtonStyle1(BoxX,BoxY,BoxW,BoxH,Text,TextFont,Scaling)
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight(Text)
    local TW = TextFont:getWidth(Text)
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings[1])
        BoxY=scaling(BoxY,1080,Settings[2])
        BoxW=scaling(BoxW,1920,Settings[1])
        BoxH=scaling(BoxH,1080,Settings[2])
    end
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
function ButtonStyle1Mod3(BoxX, BoxY, BoxW, BoxH, Text, TextFont, Scaling, Action)--Be able to run a function
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight(Text)
    local TW = TextFont:getWidth(Text)
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings[1])
        BoxY=scaling(BoxY,1080,Settings[2])
        BoxW=scaling(BoxW,1920,Settings[1])
        BoxH=scaling(BoxH,1080,Settings[2])
    end
    -- Check if mouse is over the box
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    
    -- Coordinates for the text
    local textX = BoxX + (BoxW - TW) / 2  -- Center the text horizontally
    local textY = BoxY + (BoxH - TH) / 2  -- Center the text vertically
    
    love.graphics.print(Text, textX, textY)
    love.graphics.setLineWidth(MediumLine)
    if Selected then
        love.graphics.setColor(255, 255, 255)
        if love.mouse.isDown(1) and MouseClickDebounce(30) then -- Button clicked
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
function CenteredTextBox(BoxX,BoxY,BoxW,BoxH,Text,TextFont, Scaling)
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight(Text)
    local TW = TextFont:getWidth(Text)
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings[1])
        BoxY=scaling(BoxY,1080,Settings[2])
        BoxW=scaling(BoxW,1920,Settings[1])
        BoxH=scaling(BoxH,1080,Settings[2])
    end
    -- Coordinates for the text
    local textX = BoxX + (BoxW - TW) / 2  -- Center the text horizontally
    local textY = BoxY + (BoxH - TH) / 2        -- Center the text vertically
    love.graphics.print(Text, textX, textY)
end
function CenteredTextBoxWithWrapping(BoxX, BoxY, BoxW, Text, TextFont, Scaling)
    love.graphics.setFont(TextFont)
    local textHeight = TextFont:getHeight()  -- Height of a single line of text
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings[1])
        BoxY=scaling(BoxY,1080,Settings[2])
        BoxW=scaling(BoxW,1920,Settings[1])
        BoxH=scaling(BoxH,1080,Settings[2])
    end
    -- Calculate the wrapped text and the number of lines
    local wrappedText, lines = TextFont:getWrap(Text, BoxW)
    local totalHeight = #lines * textHeight

    -- Calculate the Y position to vertically center the text
    local textY = BoxY

    -- Print the wrapped and centered text
    love.graphics.printf(Text, BoxX, textY, BoxW, "center")

    return totalHeight
end
function BackdropDraw(Backdrop)
    love.graphics.translate(Settings[1]/2, Settings[2]/2)
    Backdrop:draw()
    love.graphics.translate(-Settings[1]/2, -Settings[2]/2)
end
function ButtonStyle1Mod3WithRGB(BoxX, BoxY, BoxW, BoxH, Text, TextFont, Scaling,RGB, Action)--Be able to run a function
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight(Text)
    local TW = TextFont:getWidth(Text)
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings[1])
        BoxY=scaling(BoxY,1080,Settings[2])
        BoxW=scaling(BoxW,1920,Settings[1])
        BoxH=scaling(BoxH,1080,Settings[2])
    end
    -- Check if mouse is over the box
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    
    -- Coordinates for the text
    local textX = BoxX + (BoxW - TW) / 2  -- Center the text horizontally
    local textY = BoxY + (BoxH - TH) / 2  -- Center the text vertically
    love.graphics.setColor(RGB[1], RGB[2], RGB[3])
    love.graphics.print(Text, textX, textY)
    love.graphics.setLineWidth(MediumLine)
    if Selected then
        love.graphics.setColor(RGB[1], RGB[2], RGB[3])
        if love.mouse.isDown(1) and MouseClickDebounce(30) then -- Button clicked
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
        love.graphics.setColor(RGB[4], RGB[5], RGB[6])
    end
    love.graphics.rectangle("line", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setLineWidth(ThinLine)
    love.graphics.setColor(255, 255, 255)
end
function ConfirmActionPopup(MessageType,TextFont,Scaling,Action)
    local BoxXUnscalled=600
    local BoxYUnscalled=480
    local BoxWUnscalled=660
    local BoxHUnscalled=220
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight(MessageType)
    local TW = TextFont:getWidth(MessageType)
    if Scaling==true then
        BoxX=scaling(BoxXUnscalled,1920,Settings[1])
        BoxY=scaling(BoxYUnscalled,1080,Settings[2])
        BoxW=scaling(BoxWUnscalled,1920,Settings[1])
        BoxH=scaling(BoxHUnscalled,1080,Settings[2])
    end
    -- Coordinates for the text
    local textX = BoxX + (BoxW - TW) / 2  -- Center the text horizontally
    local textY = (BoxY + (BoxH - TH) / 2)-scaling(90,1080,Settings[2])  -- Center the text vertically
    love.graphics.setLineWidth(MediumLine)
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("fill", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setLineWidth(ThinLine)
    love.graphics.setColor(255,153,0)
    love.graphics.print(MessageType, textX, textY)
    love.graphics.setColor(255, 255, 255)
    ButtonStyle1Mod3WithRGB(BoxXUnscalled+MediumLine, BoxYUnscalled+scaling(120,1080,Settings[2]), 300, 152+MediumLine, "Cancel", Exo24, true,{0,255,0,255,153,0},"PopupCall=false")
    ButtonStyle1Mod3WithRGB(960-MediumLine, BoxYUnscalled+scaling(120,1080,Settings[2]), 300, 152+MediumLine, "Confirm", Exo24, true,{255,0,0,255,153,0},Action)
end