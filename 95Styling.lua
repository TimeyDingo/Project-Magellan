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
        love.graphics.setColorF(255, 255, 255) -- white
        love.graphics.line( BoxX, BoxY, BoxX+BoxW, BoxY) -- horizontal top
        love.graphics.line( BoxX, BoxY, BoxX, BoxY+BoxH) -- vertical left
        love.graphics.line( BoxX, BoxY+BoxH, BoxX+BoxW, BoxY+BoxH) -- horizontal bottom
        love.graphics.line( BoxX+BoxW, BoxY, BoxX+BoxW, BoxY+BoxH) -- vertical right
        love.graphics.setColorF(0, 0, 0) -- black
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
        love.graphics.setColorF(255, 255, 255) -- white
        love.graphics.line( BoxX, BoxY, BoxX+BoxW, BoxY) -- horizontal top
        love.graphics.line( BoxX, BoxY, BoxX, BoxY+BoxH) -- vertical left
        love.graphics.setColorF(0, 0, 0) -- black
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
    love.graphics.setColorF(255, 255, 255) -- white
    love.graphics.line( BoxX, BoxY+BoxH, BoxX+BoxW, BoxY+BoxH) -- horizontal bottom
    love.graphics.line( BoxX+BoxW, BoxY, BoxX+BoxW, BoxY+BoxH) -- vertical right
    love.graphics.setColorF(0, 0, 0) -- black
    love.graphics.line( BoxX, BoxY, BoxX+BoxW, BoxY) -- horizontal top
    love.graphics.line( BoxX, BoxY, BoxX, BoxY+BoxH) -- vertical left
    if invert then
        love.graphics.setLineWidth(MediumLine)
        love.graphics.setColorF(0, 0, 0) -- black
        love.graphics.line( BoxX, BoxY+BoxH, BoxX+BoxW, BoxY+BoxH) -- horizontal bottom
        love.graphics.line( BoxX+BoxW, BoxY, BoxX+BoxW, BoxY+BoxH) -- vertical right
        love.graphics.setColorF(255, 255, 255) -- white
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
    love.graphics.rectangle("fill",BoxX+(BoxW-TW)/2,BoxY-BoxDiff*2-BoxDiff/2,TW,TH-BoxDiff)--title cover
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
    love.graphics.setColorF(255, 255, 255) -- white
    love.graphics.rectangle("fill",squareX,squareY,squareSize,squareSize)
    love.graphics.line(squareX, squareY + squareSize, squareX + squareSize, squareY + squareSize) -- horizontal bottom
    love.graphics.line(squareX + squareSize, squareY, squareX + squareSize, squareY + squareSize) -- vertical right
    love.graphics.setColorF(0, 0, 0) -- black
    love.graphics.line(squareX, squareY, squareX + squareSize, squareY) -- horizontal top
    love.graphics.line(squareX, squareY, squareX, squareY + squareSize) -- vertical left
    love.graphics.setColorF(255, 255, 255)
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
function N5TextEntryBox(BoxX,BoxY,BoxW,BoxH,Scaling,Prompt,TextEntryKey,InnerFillTurnOff,NoPrompt,InitialEntry)
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil or Scaling==nil or Prompt==nil then
        print("In N5TextEntryBox() BoxX is reporting as: "..tostring(BoxX))
        print("In N5TextEntryBox() BoxY is reporting as: "..tostring(BoxY))
        print("In N5TextEntryBox() BoxW is reporting as: "..tostring(BoxW))
        print("In N5TextEntryBox() BoxH is reporting as: "..tostring(BoxH))
        print("In N5TextEntryBox() Scaling is reporting as: "..tostring(Scaling))
        print("In N5TextEntryBox() Title is reporting as: "..tostring(Prompt))
        print("In N5TextEntryBox() TextEntryKey is reporting as: "..tostring(TextEntryKey))
        return 0
    end
    local index = TextEntryIndexFromKey(TextEntryKey)
    local Entry = ""
    if InitialEntry then
        Entry = InitialEntry
    end
    if index == nil then
        table.insert(TextEntry, { TextEntryKey, Entry})
        index = #TextEntry
        return 0
    end
    local BoxDiff=10
    if NoPrompt then
        BoxDiff = 0
    end
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
        BoxDiff=scaling(BoxDiff,1920,Settings.XRes)--difference factor between inner box and outer box
    end

    local Selected = isMouseOverBox(BoxX+BoxDiff, BoxY+BoxDiff*2, BoxW-BoxDiff*2, BoxH-BoxDiff*2.5)
    --print(TextEntryKey..","..index..","..tostring(Selected))
    --[[
    if Selected then
        love.graphics.setColor(255, 0, 0)
        love.graphics.rectangle("line", BoxX+BoxDiff, BoxY+BoxDiff*2, BoxW-BoxDiff*2, BoxH-BoxDiff*2.5)
    end
    ]]
    if Selected and MouseClickDebounce(0.1) and TextEntryKey~=index then 
        TextEntryWriter=index
        EditCursorPosition=string.len(TextEntry[index][2])
    end -- deactivate others TextEntry[index][3] = true end
    --print(TextEntryKey..index)
    if index==TextEntryWriter then
        local t=""
        function love.textinput(t)
            --TextEntry[index][2] = TextEntry[index][2] .. t
            local Text = TextEntry[index][2]
            local beforeCursor = Text:sub(1,EditCursorPosition)
            local afterCursor = Text:sub(EditCursorPosition + 1)

            TextEntry[index][2] = beforeCursor .. t .. afterCursor
            EditCursorPosition = EditCursorPosition + #t
        end
        -- Extract the text before the cursor for backspacing
        local TextBeforeCursor = TextEntry[index][2]:sub(1, EditCursorPosition)

        -- Call BackspaceController to handle the text before the cursor
        TextBeforeCursor = BackspaceController(TextBeforeCursor, 1, 0.2)  -- Use suitable hold delay values

        -- Update the full text after backspacing
        local RemainingText = TextEntry[index][2]:sub(EditCursorPosition + 1)
        TextEntry[index][2] = TextBeforeCursor .. RemainingText

        -- Update cursor position after backspacing
        EditCursorPosition = #TextBeforeCursor  -- Update cursor position based on backspacing

        -- Handle Ctrl+V for pasting
        if ButtonDebounce("v", 1) and love.keyboard.isDown('lctrl') == true then
            local clipboardText = love.system.getClipboardText()
            local Text = TextEntry[index][2]
            local beforeCursor = Text:sub(1, EditCursorPosition)
            local afterCursor = Text:sub(EditCursorPosition + 1)

            -- Insert clipboard text at the cursor position
            TextEntry[index][2] = beforeCursor .. clipboardText .. afterCursor
            EditCursorPosition = EditCursorPosition + #clipboardText  -- Update cursor position
        end
        if ButtonDebounce("return", 1) then
            local Text = TextEntry[index][2]
            local beforeCursor = Text:sub(1, EditCursorPosition)
            local afterCursor = Text:sub(EditCursorPosition + 1)
            local newline = "\n"
            TextEntry[index][2] = beforeCursor .. newline .. afterCursor
            EditCursorPosition = EditCursorPosition + #newline  -- Update cursor position
        end

        -- Move the cursor with arrow keys
        if ButtonDebounce("left", 0.1) then
            EditCursorPosition = math.max(0, EditCursorPosition - 1)
        elseif ButtonDebounce("right", 0.1) then
            EditCursorPosition = math.min(#TextEntry[index][2], EditCursorPosition + 1)
        end
    end
    local BeforeCursorText=TextEntry[index][2]
    local Text = BeforeCursorText

    -- Add cursor only if the box is selected
    if index == TextEntryWriter then
        Text = BeforeCursorText:sub(1, EditCursorPosition) .. "|" .. BeforeCursorText:sub(EditCursorPosition + 1)  -- Add cursor to the text
    end
    
    N5BoxHighlight(BoxX, BoxY, BoxW, BoxH, false, {})-- outer black box on the outside
    N5BoxHighlight(BoxX+BoxDiff, BoxY+BoxDiff*2, BoxW-BoxDiff*2, BoxH-BoxDiff*2.5, true, {255,255,255}, false, BodyFontBold, Text)--white box on the inside
    love.graphics.setColor(195,199,203)--title cover
    if InnerFillTurnOff then
        local InFill=scaling(2,1128,Settings.XRes)
        local InFill2=scaling(4,1128,Settings.XRes)
        love.graphics.rectangle("fill",BoxX+BoxDiff-InFill, BoxY+BoxDiff*2-InFill, BoxW-BoxDiff*2+InFill2, BoxH-BoxDiff*2.5+InFill2)
    end
    local TH, TW=CenteredTextBox(BoxX,BoxY-BoxDiff*6,BoxW,BoxDiff*11,Prompt, MediumHeaderBold, false)--same print as later just to get the text width
    love.graphics.rectangle("fill",BoxX+(BoxW-TW)/2,BoxY-BoxDiff*2-BoxDiff/2,TW,TH-BoxDiff)--title cover
    love.graphics.setColor(0,0,0,255) -- title text color
    CenteredTextBox(BoxX,BoxY-BoxDiff*6,BoxW,BoxDiff*11,Prompt, MediumHeaderBold, false)-- actual text of the title in the top middle of the outer line
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(BodyFont)
    return TextEntry[index][2], BoxX+BoxDiff, BoxY+BoxDiff*2, BoxW-BoxDiff*2, BoxH-BoxDiff*2.5 --return the x,y,width,height of the inner box
end
function N5Window(windowx,windowy,windoww,windowh, Scaling, header,background, buttons, bannerheight)
    if header==nil or windowx==nil or windowy==nil or windoww==nil or windowh==nil then
        print("In N5MainMenu header is reporting as: "..tostring(header))
        print("In N5MainMenu windowx is reporting as: "..tostring(windowx))
        print("In N5MainMenu windowy is reporting as: "..tostring(windowy))
        print("In N5MainMenu windoww is reporting as: "..tostring(windoww))
        print("In N5MainMenu windowh is reporting as: "..tostring(windowh))
        return 0
    end
    if background==true then
        N5BackgroundColor()
    end
    local boxdiff=scaling(5,1920,Settings.XRes)
    if bannerheight == nil then
        bannerheight = 63
    end
    if Scaling==true then
        windowx=scaling(windowx,1920,Settings.XRes)
        windowy=scaling(windowy,1080,Settings.YRes)
        windoww=scaling(windoww,1920,Settings.XRes)
        windowh=scaling(windowh,1080,Settings.YRes)
        bannerheight=scaling(bannerheight, 1080,Settings.YRes)
    end
    N5BoxHighlight(windowx, windowy, windoww, windowh, true, {195,199,203}, false, SExo24,"",true) -- central box
    love.graphics.setColor(0,0,170) -- header color
    local bannerx=windowx+boxdiff
    local bannery=windowy+boxdiff
    local bannerwidth=windoww-boxdiff*2
    love.graphics.rectangle("fill",bannerx,bannery,bannerwidth,bannerheight)
    love.graphics.setColor(244,244,244) -- header text color
    --header text
    CenteredTextBox(bannerx+boxdiff*2,bannery,bannerwidth,bannerheight,header,SmallHeaderBold,false,"left")
    if buttons ~= nil then
        --buttons table format = {{function, icon},{function,icon}}
        local amountofbuttons = #buttons
        local buttonwh = scaling(55,1920,Settings.XRes)
        local spacebetweenbuttons=7
        local spacerequiredforbuttons = amountofbuttons*(buttonwh+spacebetweenbuttons)
        local bannerrightside=bannerx+bannerwidth
        local VerticalSpacingBetweenBannerAndButtons = scaling(4,1920,Settings.XRes)
        local ContainerY=bannery+VerticalSpacingBetweenBannerAndButtons
        local ContainerH=bannerheight-VerticalSpacingBetweenBannerAndButtons*2
        local Positions=ContainerHorizontal(bannerrightside-spacerequiredforbuttons,ContainerY,spacerequiredforbuttons-VerticalSpacingBetweenBannerAndButtons,ContainerH,amountofbuttons,spacebetweenbuttons,false)
        for i = 1, #Positions do
            N5Button(Positions[i][1], Positions[i][2], Positions[i][3], Positions[i][4],false,buttons[i][1],true,SmallHeaderBold,buttons[i][2])
        end
        --[[
        --buttonwh = 55
        --7 pixels between the edge of each button
        N5Button(1542,93,55,55,true,"StateMachine='Settings Menu'",true,SmallHeaderBold,"~")
        N5Button(1604,93,55,55,true,"PopupCall=true; PopupAction='love.event.quit()';PopUpMessage='Close Software?'",true,SmallHeaderBold,"X")
        ]]
    end
    local usableX = windowx
    local usableY = windowy + bannerheight
    local usableW = windoww
    local usableH = windowh - bannerheight

    local CenterX = usableX + (usableW / 2)
    local CenterY = usableY + (usableH / 2)
    return CenterX, CenterY
end
function N5BackgroundColor()
    love.graphics.setColor(56,110,110) -- backdrop color
    love.graphics.rectangle("fill",0,0,scaling(1920,1920,Settings.XRes),scaling(1080,1080,Settings.YRes)) --backdrop fill
end