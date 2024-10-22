function CenterText(X,Y,Text,TextFont)
    love.graphics.setFont(TextFont)
    if Text==nil or TextFont==nil or X==nil or Y==nil then
        print("In CenterText() X is reporting as: "..tostring(X))
        print("In CenterText() Y is reporting as: "..tostring(Y))
        print("In CenterText() Text is reporting as: "..tostring(Text))
        print("In CenterText() TextFont is reporting as: "..tostring(TextFont))
        return
    end
    local TW=TextFont:getWidth(Text)
    local TH=TextFont:getHeight(Text)
    love.graphics.print(Text,((W-TW)/2)+X,((H-TH)/2)+Y)--Screen Width minus text width divided by 2 + change in x
end
function ButtonStyle1(BoxX,BoxY,BoxW,BoxH,Text,TextFont,Scaling)
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil or Text==nil or TextFont==nil then
        print("In ButtonStyle1() BoxX is reporting as: "..tostring(BoxX))
        print("In ButtonStyle1() BoxY is reporting as: "..tostring(BoxY))
        print("In ButtonStyle1() BoxW is reporting as: "..tostring(BoxW))
        print("In ButtonStyle1() BoxH is reporting as: "..tostring(BoxH))
        print("In ButtonStyle1() Text is reporting as: "..tostring(Text))
        print("In ButtonStyle1() TextFont is reporting as: "..tostring(TextFont))
        return
    end
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight(Text)
    local TW = TextFont:getWidth(Text)
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
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
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil or Text==nil or TextFont==nil then
        print("In ButtonStyle1Mod3() BoxX is reporting as: "..tostring(BoxX))
        print("In ButtonStyle1Mod3() BoxY is reporting as: "..tostring(BoxY))
        print("In ButtonStyle1Mod3() BoxW is reporting as: "..tostring(BoxW))
        print("In ButtonStyle1Mod3() BoxH is reporting as: "..tostring(BoxH))
        print("In ButtonStyle1Mod3() Text is reporting as: "..tostring(Text))
        print("In ButtonStyle1Mod3() TextFont is reporting as: "..tostring(TextFont))
        return
    end
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight(Text)
    local TW = TextFont:getWidth(Text)
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
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
        love.graphics.setColor(255, 153, 0)
    end
    love.graphics.rectangle("line", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setLineWidth(ThinLine)
    love.graphics.setColor(255, 255, 255)
end
function CenteredTextBox(BoxX,BoxY,BoxW,BoxH,Text,TextFont, Scaling)
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil or Text==nil or TextFont==nil then
        print("In CenteredTextBox() BoxX is reporting as: "..tostring(BoxX))
        print("In CenteredTextBox() BoxY is reporting as: "..tostring(BoxY))
        print("In CenteredTextBox() BoxW is reporting as: "..tostring(BoxW))
        print("In CenteredTextBox() BoxH is reporting as: "..tostring(BoxH))
        print("In CenteredTextBox() Text is reporting as: "..tostring(Text))
        print("In CenteredTextBox() TextFont is reporting as: "..tostring(TextFont))
        return
    end
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight(Text)
    local TW = TextFont:getWidth(Text)
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
    end
    -- Coordinates for the text
    local textX = BoxX + (BoxW - TW) / 2  -- Center the text horizontally
    local textY = BoxY + (BoxH - TH) / 2        -- Center the text vertically
    love.graphics.print(Text, textX, textY)
end
function CenteredTextBoxWithWrapping(BoxX, BoxY, BoxW, Text, TextFont, Scaling)
    if BoxX==nil or BoxY==nil or BoxW==nil or Text==nil or TextFont==nil then
        print("In CenteredTextBoxWithWrapping() BoxX is reporting as: "..tostring(BoxX))
        print("In CenteredTextBoxWithWrapping() BoxY is reporting as: "..tostring(BoxY))
        print("In CenteredTextBoxWithWrapping() BoxW is reporting as: "..tostring(BoxW))
        print("In CenteredTextBoxWithWrapping() BoxH is reporting as: "..tostring(BoxH))
        print("In CenteredTextBoxWithWrapping() Text is reporting as: "..tostring(Text))
        print("In CenteredTextBoxWithWrapping() TextFont is reporting as: "..tostring(TextFont))
        return
    end
    love.graphics.setFont(TextFont)
    local textHeight = TextFont:getHeight()  -- Height of a single line of text
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
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
    love.graphics.translate(Settings.XRes/2, Settings.YRes/2)
    Backdrop:draw()
    love.graphics.translate(-Settings.XRes/2, -Settings.YRes/2)
end
function ButtonStyle1Mod3WithRGB(BoxX, BoxY, BoxW, BoxH, Text, TextFont, Scaling,RGB, Action)--Be able to run a function
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil or Text==nil or TextFont==nil or RGB==nil then
        print("In ButtonStyle1Mod3WithRGB() BoxX is reporting as: "..tostring(BoxX))
        print("In ButtonStyle1Mod3WithRGB() BoxY is reporting as: "..tostring(BoxY))
        print("In ButtonStyle1Mod3WithRGB() BoxW is reporting as: "..tostring(BoxW))
        print("In ButtonStyle1Mod3WithRGB() BoxH is reporting as: "..tostring(BoxH))
        print("In ButtonStyle1Mod3WithRGB() Text is reporting as: "..tostring(Text))
        print("In ButtonStyle1Mod3WithRGB() TextFont is reporting as: "..tostring(TextFont))
        print("In ButtonStyle1Mod3WithRGB() RGB is reporting as: "..tostring(RGB))
        return
    end
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight(Text)
    local TW = TextFont:getWidth(Text)
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
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
        love.graphics.setColor(RGB[4], RGB[5], RGB[6])
    end
    love.graphics.rectangle("line", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setLineWidth(ThinLine)
    love.graphics.setColor(255, 255, 255)
end
function ConfirmActionPopup(MessageType,TextFont,Scaling,Action,BackoutAction)
    if MessageType==nil or TextFont==nil or Action==nil then
        print("In ConfirmActionPopup() MessageType is reporting as: "..tostring(MessageType))
        print("In ConfirmActionPopup() TextFont is reporting as: "..tostring(TextFont))
        print("In ConfirmActionPopup() Action is reporting as: "..tostring(Action))
        return
    end
    local BoxXUnscalled=600
    local BoxYUnscalled=480
    local BoxWUnscalled=660
    local BoxHUnscalled=220
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight(MessageType)
    local TW = TextFont:getWidth(MessageType)
    if Scaling==true then
        BoxX=scaling(BoxXUnscalled,1920,Settings.XRes)
        BoxY=scaling(BoxYUnscalled,1080,Settings.YRes)
        BoxW=scaling(BoxWUnscalled,1920,Settings.XRes)
        BoxH=scaling(BoxHUnscalled,1080,Settings.YRes)
    end
    -- Coordinates for the text
    local textX = BoxX + (BoxW - TW) / 2  -- Center the text horizontally
    local textY = (BoxY + (BoxH - TH) / 2)-scaling(90,1080,Settings.YRes)  -- Center the text vertically
    love.graphics.setLineWidth(MediumLine)
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("fill", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setLineWidth(ThinLine)
    love.graphics.setColor(255,153,0)
    love.graphics.print(MessageType, textX, textY)
    love.graphics.setColor(255, 255, 255)
    if BackoutAction==nil then
        BackoutAction="PopupCall=false"
    end
    ButtonStyle1Mod3WithRGB(BoxXUnscalled+MediumLine,BoxY+BoxH-152-MediumLine, 300, 152+MediumLine, "Cancel", Exo24, true,{0,255,0,255,153,0},BackoutAction)
    ButtonStyle1Mod3WithRGB(960-MediumLine, BoxY+BoxH-152-MediumLine, 300, 152+MediumLine, "Confirm", Exo24, true,{255,0,0,255,153,0},Action)
end
function ScrollBar(BoxX,BoxY,BoxW,BoxH,MinNumberOfItems,NumberOfItems,CurrentScroll,Scaling)
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
    love.graphics.setColor(255, 153, 0)
    local ScrollingOrigin=BoxY+BoxH
    love.graphics.rectangle("fill",BoxX,BoxY+(ScrollingOrigin/NumberOfItems)*CurrentScroll,BoxW,ScrollingOrigin/NumberOfItems*MinNumberOfItems)
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