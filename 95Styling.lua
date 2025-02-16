function N5Button(BoxX, BoxY, BoxW, BoxH, Scaling, Action, Fill,TextFont,Text)--Used to highlight a button like the X or <- in 95 style
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil then
        print("In ButtonStyle1Mod3() BoxX is reporting as: "..tostring(BoxX))
        print("In ButtonStyle1Mod3() BoxY is reporting as: "..tostring(BoxY))
        print("In ButtonStyle1Mod3() BoxW is reporting as: "..tostring(BoxW))
        print("In ButtonStyle1Mod3() BoxH is reporting as: "..tostring(BoxH))
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
    if Selected then
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
function N5BoxHighlight(BoxX, BoxY, BoxW, BoxH, fill, FillColor, Scaling, TextFont, Text)--Used to highlight a box like the X or <- in 95 style
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil then
        print("In ButtonStyle1Mod3() BoxX is reporting as: "..tostring(BoxX))
        print("In ButtonStyle1Mod3() BoxY is reporting as: "..tostring(BoxY))
        print("In ButtonStyle1Mod3() BoxW is reporting as: "..tostring(BoxW))
        print("In ButtonStyle1Mod3() BoxH is reporting as: "..tostring(BoxH))
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
    love.graphics.setColor(255, 255, 255)
    love.graphics.setLineWidth(1)
end
function N5ScrollBar(BoxX,BoxY,BoxW,BoxH,MinNumberOfItems,NumberOfItems,CurrentScroll,Scaling)
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil or MinNumberOfItems==nil or NumberOfItems==nil or NumberOfItems<MinNumberOfItems-1 then
        print("In ScrollBar() BoxX is reporting as: "..tostring(BoxX))
        print("In ScrollBar() BoxY is reporting as: "..tostring(BoxY))
        print("In ScrollBar() BoxW is reporting as: "..tostring(BoxW))
        print("In ScrollBar() BoxH is reporting as: "..tostring(BoxH))
        print("In ScrollBar() MinNumberOfItems is reporting as: "..tostring(MinNumberOfItems))
        print("In ScrollBar() NumberOfItems is reporting as: "..tostring(NumberOfItems))
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
function N5BoxWithTitle(BoxX,BoxY,BoxW,BoxH,Scaling,Title)
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil or Scaling==nil or Title==nil then
        print("In ScrollBar() BoxX is reporting as: "..tostring(BoxX))
        print("In ScrollBar() BoxY is reporting as: "..tostring(BoxY))
        print("In ScrollBar() BoxW is reporting as: "..tostring(BoxW))
        print("In ScrollBar() BoxH is reporting as: "..tostring(BoxH))
        print("In ScrollBar() MinNumberOfItems is reporting as: "..tostring(Scaling))
        print("In ScrollBar() NumberOfItems is reporting as: "..tostring(Title))
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
    N5BoxHighlight(BoxX+BoxDiff, BoxY+BoxDiff*3, BoxW-BoxDiff*2, BoxH-BoxDiff*4, true, {255,255,255})--white box on the inside
    love.graphics.setColor(195,199,203)--title cover
    local TH, TW=CenteredTextBox(BoxX,BoxY-BoxDiff*6,BoxW,BoxDiff*11,Title, IBM34Bold, false)--same print as later just to get the text width
    love.graphics.rectangle("fill",BoxX+(BoxW-TW)/2,BoxY-BoxDiff*2-BoxDiff/2,TW,TH)
    love.graphics.setColor(0,0,0,255) -- title text color
    CenteredTextBox(BoxX,BoxY-BoxDiff*6,BoxW,BoxDiff*11,Title, IBM34Bold, false)-- actual text of the title in the top middle of the outer line
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(Exo24)
end