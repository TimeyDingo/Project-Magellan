function N5Button(BoxX, BoxY, BoxW, BoxH, Scaling, Action, Fill,TextFont,Text, ExternalPress)--Used to highlight a button like the X o` <- in 95 style
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil then
        print("In N5Button() BoxX is reporting as: "..tostring(BoxX))
        print("In N5Button() BoxY is reporting as: "..tostring(BoxY))
        print("In N5Button() BoxW is reporting as: "..tostring(BoxW))
        print("In N5Button() BoxH is reporting as: "..tostring(BoxH))
        return
    end
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
    end
    if Fill then
        love.graphics.setColor(195, 199, 203) -- white
        love.graphics.rectangle("fill", BoxX,BoxY,BoxW,BoxH)
    end
    if TextFont and Text then
        love.graphics.setColor(0,0,0)
        local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
        love.graphics.setFont(TextFont)
        local TH = TextFont:getHeight() * #Text / BoxW -- Estimate height based on wrapping
        local _, wrappedText = TextFont:getWrap(Text, BoxW)
        local wrappedHeight = #wrappedText * TextFont:getHeight()
        -- Coordinates for the text
        local textY = BoxY + (BoxH - wrappedHeight) / 2  -- Center the text vertically
        love.graphics.printf(Text, BoxX, textY, BoxW, "center")  -- Print wrapped and centered text
    end
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)    -- Check if mouse is over the box
    love.graphics.setLineWidth(MediumLine)
    if Selected or ExternalPress then
        love.graphics.setColor(255, 255, 255) -- white
        love.graphics.line( BoxX, BoxY, BoxX+BoxW, BoxY) -- horizontal top
        love.graphics.line( BoxX, BoxY, BoxX, BoxY+BoxH) -- vertical left
        love.graphics.line( BoxX, BoxY+BoxH, BoxX+BoxW, BoxY+BoxH) -- horizontal bottom
        love.graphics.line( BoxX+BoxW, BoxY, BoxX+BoxW, BoxY+BoxH) -- vertical right
        love.graphics.setColor(0, 0, 0) -- black
        love.graphics.line( BoxX, BoxY, BoxX+BoxW, BoxY) -- horizontal top
        love.graphics.line( BoxX, BoxY, BoxX, BoxY+BoxH) -- vertical left
        if love.mouse.isDown(1) and MouseClickDebounce(0.5) then -- Button clicked
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
        love.graphics.setColor(255, 255, 255) -- white
        love.graphics.line( BoxX, BoxY, BoxX+BoxW, BoxY) -- horizontal top
        love.graphics.line( BoxX, BoxY, BoxX, BoxY+BoxH) -- vertical left
        love.graphics.setColor(0, 0, 0) -- black
        love.graphics.line( BoxX, BoxY+BoxH, BoxX+BoxW, BoxY+BoxH) -- horizontal bottom
        love.graphics.line( BoxX+BoxW, BoxY, BoxX+BoxW, BoxY+BoxH) -- vertical right
    end
    love.graphics.setColor(255, 255, 255)
    love.graphics.setLineWidth(1)
end
function N5BoxHighlight(BoxX, BoxY, BoxW, BoxH, fill, FillColor, Scaling, TextFont, Text,invert)--Used to highlight a box like the X or <- in 95 style
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil then
        print("In N5BoxHighlight() BoxX is reporting as: "..tostring(BoxX))
        print("In N5BoxHighlight() BoxY is reporting as: "..tostring(BoxY))
        print("In N5BoxHighlight() BoxW is reporting as: "..tostring(BoxW))
        print("In N5BoxHighlight() BoxH is reporting as: "..tostring(BoxH))
        return
    end
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
    end
    if fill==true then
        love.graphics.setColor(FillColor[1],FillColor[2],FillColor[3])
        love.graphics.rectangle("fill", BoxX, BoxY, BoxW, BoxH)
    end
    if TextFont and Text then
        love.graphics.setColor(0,0,0)
        local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
        love.graphics.setFont(TextFont)
        local TH = TextFont:getHeight() * #Text / BoxW -- Estimate height based on wrapping
        local _, wrappedText = TextFont:getWrap(Text, BoxW)
        local wrappedHeight = #wrappedText * TextFont:getHeight()
        -- Coordinates for the text
        local textY = BoxY + (BoxH - wrappedHeight) / 2  -- Center the text vertically
        love.graphics.printf(Text, BoxX, textY, BoxW, "center")  -- Print wrapped and centered text
    end
    love.graphics.setLineWidth(MediumLine)
    love.graphics.setColor(255, 255, 255) -- white
    love.graphics.line( BoxX, BoxY+BoxH, BoxX+BoxW, BoxY+BoxH) -- horizontal bottom
    love.graphics.line( BoxX+BoxW, BoxY, BoxX+BoxW, BoxY+BoxH) -- vertical right
    love.graphics.setColor(0, 0, 0) -- black
    love.graphics.line( BoxX, BoxY, BoxX+BoxW, BoxY) -- horizontal top
    love.graphics.line( BoxX, BoxY, BoxX, BoxY+BoxH) -- vertical left
    if invert then
        love.graphics.setLineWidth(MediumLine)
        love.graphics.setColor(0, 0, 0) -- black
        love.graphics.line( BoxX, BoxY+BoxH, BoxX+BoxW, BoxY+BoxH) -- horizontal bottom
        love.graphics.line( BoxX+BoxW, BoxY, BoxX+BoxW, BoxY+BoxH) -- vertical right
        love.graphics.setColor(255, 255, 255) -- white
        love.graphics.line( BoxX, BoxY, BoxX+BoxW, BoxY) -- horizontal top
        love.graphics.line( BoxX, BoxY, BoxX, BoxY+BoxH) -- vertical left
    end
    love.graphics.setColor(255, 255, 255)
    love.graphics.setLineWidth(1)
end
function N5ScrollBar(BoxX,BoxY,BoxW,BoxH,MinNumberOfItems,NumberOfItems,CurrentScroll,Scaling)
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil or MinNumberOfItems==nil or NumberOfItems==nil or NumberOfItems<MinNumberOfItems-1 then
        print("In N5ScrollBar() BoxX is reporting as: "..tostring(BoxX))
        print("In N5ScrollBar() BoxY is reporting as: "..tostring(BoxY))
        print("In N5ScrollBar() BoxW is reporting as: "..tostring(BoxW))
        print("In N5ScrollBar() BoxH is reporting as: "..tostring(BoxH))
        print("In N5ScrollBar() MinNumberOfItems is reporting as: "..tostring(MinNumberOfItems))
        print("In N5ScrollBar() NumberOfItems is reporting as: "..tostring(NumberOfItems))
        return 0
    end
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
    end
    N5BoxHighlight(BoxX-scaling(5,1920,Settings.XRes), BoxY, BoxW+scaling(10,1920,Settings.XRes), BoxH*1.3125, true, {255,255,255} , false)
    love.graphics.setColor(255, 153, 0)
    local ScrollingOrigin=BoxY+BoxH
    N5Button(BoxX,BoxY+(ScrollingOrigin/NumberOfItems)*CurrentScroll,BoxW,ScrollingOrigin/NumberOfItems*MinNumberOfItems, false, "", {195,199,203})
    --ove.graphics.rectangle("fill",BoxX,BoxY+(ScrollingOrigin/NumberOfItems)*CurrentScroll,BoxW,ScrollingOrigin/NumberOfItems*MinNumberOfItems)
    if (ButtonDebounce("up", 0.1) or YScroll>0)and CurrentScroll > 0 then
        CurrentScroll = CurrentScroll - 1
        YScroll=0
    end
    if (ButtonDebounce("down", 0.1) or YScroll<0) and CurrentScroll < NumberOfItems-MinNumberOfItems then
        CurrentScroll = CurrentScroll + 1
        YScroll=0
    end
    love.graphics.setColor(255,255,255)
    return CurrentScroll
end
function N5BoxWithTitle(BoxX,BoxY,BoxW,BoxH,Scaling,Title,Text, InnerFillTurnOff)
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil or Scaling==nil or Title==nil then
        print("In N5BoxWithTitle() BoxX is reporting as: "..tostring(BoxX))
        print("In N5BoxWithTitle() BoxY is reporting as: "..tostring(BoxY))
        print("In N5BoxWithTitle() BoxW is reporting as: "..tostring(BoxW))
        print("In N5BoxWithTitle() BoxH is reporting as: "..tostring(BoxH))
        print("In N5BoxWithTitle() MinNumberOfItems is reporting as: "..tostring(Scaling))
        print("In N5BoxWithTitle() NumberOfItems is reporting as: "..tostring(Title))
        return 0
    end
    local BoxDiff=10
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
        BoxDiff=scaling(10,1920,Settings.XRes)--difference factor between inner box and outer box
    end
    N5BoxHighlight(BoxX, BoxY, BoxW, BoxH, false, {})-- outer black box on the outside
    N5BoxHighlight(BoxX+BoxDiff, BoxY+BoxDiff*2, BoxW-BoxDiff*2, BoxH-BoxDiff*2.5, true, {255,255,255}, false, BodyFontBold, Text)--white box on the inside
    love.graphics.setColor(195,199,203)--title cover
    if InnerFillTurnOff then
        local InFill=scaling(2,1128,Settings.XRes)
        local InFill2=scaling(4,1128,Settings.XRes)
        love.graphics.rectangle("fill",BoxX+BoxDiff-InFill, BoxY+BoxDiff*2-InFill, BoxW-BoxDiff*2+InFill2, BoxH-BoxDiff*2.5+InFill2)
    end
    local TH, TW=CenteredTextBox(BoxX,BoxY-BoxDiff*6,BoxW,BoxDiff*11,Title, MediumHeaderBold, false)--same print as later just to get the text width
    love.graphics.rectangle("fill",BoxX+(BoxW-TW)/2,BoxY-BoxDiff*2-BoxDiff/2,TW,TH)--title cover
    love.graphics.setColor(0,0,0,255) -- title text color
    CenteredTextBox(BoxX,BoxY-BoxDiff*6,BoxW,BoxDiff*11,Title, MediumHeaderBold, false)-- actual text of the title in the top middle of the outer line
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(BodyFont)
    return BoxX+BoxDiff, BoxY+BoxDiff*2, BoxW-BoxDiff*2, BoxH-BoxDiff*2.5 --return the x,y,width,height of the inner box
end
function N5TickBox(BoxX, BoxY, BoxW, BoxH, Scaling, Value)
    if BoxX == nil or BoxY == nil or BoxW == nil or BoxH == nil or Scaling == nil or Value == nil then
        print("Invalid parameters")
        return
    end
    if Scaling == true then
        BoxX = scaling(BoxX, 1920, Settings.XRes)
        BoxY = scaling(BoxY, 1080, Settings.YRes)
        BoxW = scaling(BoxW, 1920, Settings.XRes)
        BoxH = scaling(BoxH, 1080, Settings.YRes)
    end
    --clicking
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    if Selected then
        if love.mouse.isDown(1) and MouseClickDebounce(0.5) then -- Button clicked
            if Value==false then
                Value=true
            else
                Value=false
            end
        end
    end
    --
    local padding = scaling(10, 1920, Settings.XRes)
    
    -- Calculate effective dimensions after padding
    local effectiveWidth = BoxW - 2 * padding
    local effectiveHeight = BoxH - 2 * padding
    
    -- Determine square size
    local squareSize = math.min(effectiveWidth, effectiveHeight)
    
    -- Calculate square's top-left coordinates for centering
    local squareX = BoxX + padding + (effectiveWidth - squareSize) / 2
    local squareY = BoxY + padding + (effectiveHeight - squareSize) / 2

    love.graphics.setLineWidth(MediumLine)
    love.graphics.setColor(255, 255, 255) -- white
    love.graphics.rectangle("fill",squareX,squareY,squareSize,squareSize)
    love.graphics.line(squareX, squareY + squareSize, squareX + squareSize, squareY + squareSize) -- horizontal bottom
    love.graphics.line(squareX + squareSize, squareY, squareX + squareSize, squareY + squareSize) -- vertical right
    love.graphics.setColor(0, 0, 0) -- black
    love.graphics.line(squareX, squareY, squareX + squareSize, squareY) -- horizontal top
    love.graphics.line(squareX, squareY, squareX, squareY + squareSize) -- vertical left
    love.graphics.setColor(255, 255, 255)
    love.graphics.setLineWidth(1)
    if Value then --draw the tick
        love.graphics.setColor(255,0,0)
        love.graphics.line(squareX, squareY, squareX+squareSize, squareY + squareSize)
    end
    return Value
end
function N5Slider(BoxX, BoxY, BoxW, BoxH, Scaling, RawValue, Percentage)
    if BoxX == nil or BoxY == nil or BoxW == nil or BoxH == nil or Scaling == nil or RawValue == nil then
        print("Invalid parameters")
        return
    end
    if Scaling == true then
        BoxX = scaling(BoxX, 1920, Settings.XRes)
        BoxY = scaling(BoxY, 1080, Settings.YRes)
        BoxW = scaling(BoxW, 1920, Settings.XRes)
        BoxH = scaling(BoxH, 1080, Settings.YRes)
    end
    --clicking
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    local Padding = scaling(10, 1920, Settings.XRes)
    if Selected then
        if love.mouse.isDown(1) then -- Button clicked
            if MouseX<BoxX+BoxW-Padding and MouseX>BoxX+Padding then
                RawValue=MouseX
            end
        end
    end
    local LineY = BoxY + BoxH / 2
    love.graphics.setLineWidth(ThickLine*2)
    local LineStart=BoxX+Padding
    local LineEnd=BoxX+BoxW-Padding
    local LineLength=LineEnd-LineStart
    love.graphics.line(BoxX+Padding, LineY+Padding, BoxX+BoxW-Padding, LineY+Padding)
    N5Button(RawValue, LineY-Padding/2, LineLength/25, Padding*3, false, "", true, BodyFont, "", Selected)
    love.graphics.setLineWidth(1)
    if RawValue<BoxX+Padding then
        RawValue=LineEnd
    end
    if RawValue>BoxX+BoxW-Padding then
        RawValue=LineStart
    end
    Percentage=(RawValue-LineStart)/LineLength
    return RawValue, Percentage
end