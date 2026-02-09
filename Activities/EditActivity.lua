function EditActivity()
    local BlankTerm={{Term=' ',Definition=' ',UserSeenTimes=0,UserCorrectTimes=0,Image=false}}
    local TermFont=BodyFont
    local DefinitionFont=SmallBodyFont
    if Deleting==false then
        if SetData==nil or Settings==nil or EditActivityScroll==nil or Deleting==true then
            print("In EditActivity() SetData is reporting as: "..tostring(SetData))
            print("In EditActivity() Settings is reporting as: "..tostring(Settings))
            print("In EditActivity() EditActivityScroll is reporting as: "..tostring(EditActivityScroll))
            return
        end
        --EditableTitle(660, 145, 600, 50, SmallBodyFontBold,true)
        SetData.Title=N5TextEntryBox(660,145,600,50,true,"","EditActivityTitle",false,true,SetData.Title,true, BodyFontBold)
        N5Button(830, 90, 240, 50, true, 'LUASetWrite(SetToPreview,SetData); SetStateMachine("View Set"); EditActivityScroll=0', false, BodyFontBold, "-> View Mode")
        love.graphics.setColor(40,40,40)
        love.graphics.rectangle("fill",scaling(940,1920,Settings.XRes),scaling(200-MediumLine,1080,Settings.YRes),scaling(40,1920,Settings.XRes),scaling(950,1080,Settings.YRes))
        love.graphics.setColor(255,255,255)
        N5BoxHighlight(390, 145, 240, 50, true, {255,255,255}, true, SmallHeaderBold, "Terms")
        N5BoxHighlight(1305, 145, 240, 50, true, {255,255,255}, true, SmallHeaderBold, "Definitions")
        N5Button(1522, 6, 200, 75, true, 'LUASetWrite(SetToPreview,SetData)',true, BodyFontBold, "Save Set")

        N5Button(1433, 6, 80, 75, true, 'table.insert(SetData, BlankTerm); SetData.Terms=SetData.Terms+1' ,true, BodyFontBold, "+++")
        if SetData.Terms>0 then
            --SetTitle=N5TextEntryBox(20,200+MediumLine,870,200,true,"","EditActivityTitle",false,true,SetTitle,true,TermFont)
            EditableDisplayTerm(20,200+MediumLine,870,200,1+EditActivityScroll,TermFont,true)
            EditableDisplayDefinition(990,200+MediumLine,910,200,1+EditActivityScroll,DefinitionFont,true)
            N5Button(890, 200+MediumLine, 40, 200, true, 'EditActivityRemoveTerm(1+EditActivityScroll)', false, BodyFontBold, "X")
        end
        if SetData.Terms>1 then
            EditableDisplayTerm(20,420+MediumLine,870,200,2+EditActivityScroll,TermFont,true)
            EditableDisplayDefinition(990,420+MediumLine,910,200,2+EditActivityScroll,DefinitionFont,true)
            N5Button(890, 420+MediumLine, 40, 200, true, 'EditActivityRemoveTerm(2+EditActivityScroll)', false, BodyFontBold, "X")
        end
        if SetData.Terms>2 then
            EditableDisplayTerm(20,640+MediumLine,870,200,3+EditActivityScroll,TermFont,true)
            EditableDisplayDefinition(990,640+MediumLine,910,200,3+EditActivityScroll,DefinitionFont,true)
            N5Button(890, 640+MediumLine, 40, 200, true, 'EditActivityRemoveTerm(3+EditActivityScroll)', false, BodyFontBold, "X")
        end
        if SetData.Terms>3 then
            EditableDisplayTerm(20,860+MediumLine,870,200,4+EditActivityScroll,TermFont,true)
            EditableDisplayDefinition(990,860+MediumLine,910,200,4+EditActivityScroll,DefinitionFont,true)
            N5Button(890, 860+MediumLine, 40, 200, true, 'EditActivityRemoveTerm(4+EditActivityScroll)', false, BodyFontBold, "X")
            EditActivityScroll=N5ScrollBar(940,200-MediumLine,40,750,4,SetData.Terms,EditActivityScroll,true)
        end
    end
    love.graphics.setColor(255,255,255)
end
function EditableDisplayTerm(BoxX, BoxY, BoxW, BoxH, TermToDisplayAndEdit, TextFont, Scaling)
    -- Scaling logic
    if Scaling == true then
        BoxX = scaling(BoxX, 1920, Settings.XRes)
        BoxY = scaling(BoxY, 1080, Settings.YRes)
        BoxW = scaling(BoxW, 1920, Settings.XRes)
        BoxH = scaling(BoxH, 1080, Settings.YRes)
    end
    
    -- Check if the mouse is over the box
    local isHovered = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    
    -- Check for mouse click to select the box
    if isHovered and love.mouse.isDown(1) then
        EditActivitySelectedTerm = TermToDisplayAndEdit
        EditActivitySelectedDefinition = nil
        EditCursorPositionTerm = #SetData[TermToDisplayAndEdit].Term  -- Set cursor to the end of the text
    end

    -- Set color based on whether this box is selected or hovered
    if EditActivitySelectedTerm == TermToDisplayAndEdit then
        love.graphics.setColor(255, 255, 255)  -- Highlight color for selected
    elseif isHovered then
        love.graphics.setColor(200, 200, 200)  -- Lighter hover color
    else
        love.graphics.setColor(180, 180, 180)  -- Default color
    end
    --95 box background
    love.graphics.rectangle("fill", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setColor(0,0,0)--text color
    -- Only allow editing if this box is currently selected
    if EditActivitySelectedTerm == TermToDisplayAndEdit then
        function love.textinput(t)
            local Text = SetData[TermToDisplayAndEdit].Term
            local beforeCursor = Text:sub(1, EditCursorPositionTerm)
            local afterCursor = Text:sub(EditCursorPositionTerm + 1)

            SetData[TermToDisplayAndEdit].Term = beforeCursor .. t .. afterCursor
            EditCursorPositionTerm = EditCursorPositionTerm + #t
        end

        -- Extract the text before the cursor for backspacing
        local TextBeforeCursor = SetData[TermToDisplayAndEdit].Term:sub(1, EditCursorPositionTerm)

        -- Call BackspaceController to handle the text before the cursor
        TextBeforeCursor = BackspaceController(TextBeforeCursor, 1, 0.2)  -- Use suitable hold delay values

        -- Update the full text after backspacing
        local RemainingText = SetData[TermToDisplayAndEdit].Term:sub(EditCursorPositionTerm + 1)
        SetData[TermToDisplayAndEdit].Term = TextBeforeCursor .. RemainingText

        -- Update cursor position after backspacing
        EditCursorPositionTerm = #TextBeforeCursor  -- Update cursor position based on backspacing

        -- Handle Ctrl+V for pasting
        if ButtonDebounce("v", 1) and love.keyboard.isDown('lctrl') == true then
            local clipboardText = love.system.getClipboardText()
            local Text = SetData[TermToDisplayAndEdit].Term
            local beforeCursor = Text:sub(1, EditCursorPositionTerm)
            local afterCursor = Text:sub(EditCursorPositionTerm + 1)

            -- Insert clipboard text at the cursor position
            SetData[TermToDisplayAndEdit].Term = beforeCursor .. clipboardText .. afterCursor
            EditCursorPositionTerm = EditCursorPositionTerm + #clipboardText  -- Update cursor position
        end

        -- Move the cursor with arrow keys
        if ButtonDebounce("left", 0.1) then
            EditCursorPositionTerm = math.max(0, EditCursorPositionTerm - 1)
        elseif ButtonDebounce("right", 0.1) then
            EditCursorPositionTerm = math.min(#SetData[TermToDisplayAndEdit].Term, EditCursorPositionTerm + 1)
        end
    end
    -- Draw the text inside the box
    local Text = SetData[TermToDisplayAndEdit].Term
    local displayText = Text

    -- Add cursor only if the box is selected
    if EditActivitySelectedTerm == TermToDisplayAndEdit then
        displayText = Text:sub(1, EditCursorPositionTerm) .. "|" .. Text:sub(EditCursorPositionTerm + 1)  -- Add cursor to the text
    end
    --text wrapping
    local _, wrappedText = TextFont:getWrap(displayText, BoxW)
    local wrappedHeight = #wrappedText * TextFont:getHeight()
    local textY = BoxY + (BoxH - wrappedHeight) / 2
    love.graphics.printf(displayText, BoxX, textY, BoxW, "center")
    
    --95 box border
    love.graphics.setLineWidth(MediumLine)
    love.graphics.setColorF(255, 255, 255) -- white
    love.graphics.line( BoxX, BoxY+BoxH, BoxX+BoxW, BoxY+BoxH) -- horizontal bottom
    love.graphics.line( BoxX+BoxW, BoxY, BoxX+BoxW, BoxY+BoxH) -- vertical right
    love.graphics.setColorF(0, 0, 0) -- black
    love.graphics.line( BoxX, BoxY, BoxX+BoxW, BoxY) -- horizontal top
    love.graphics.line( BoxX, BoxY, BoxX, BoxY+BoxH) -- vertical left
    love.graphics.setColor(255, 255, 255)
    love.graphics.setLineWidth(1)
end
function EditableDisplayDefinition(BoxX, BoxY, BoxW, BoxH, TermToDisplayAndEdit, TextFont, Scaling)
    -- Scaling logic
    if Scaling == true then
        BoxX = scaling(BoxX, 1920, Settings.XRes)
        BoxY = scaling(BoxY, 1080, Settings.YRes)
        BoxW = scaling(BoxW, 1920, Settings.XRes)
        BoxH = scaling(BoxH, 1080, Settings.YRes)
    end

    -- Check if the mouse is over the box
    local isHovered = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)

    -- Check for mouse click to select the box
    if isHovered and love.mouse.isDown(1) then
        EditActivitySelectedDefinition = TermToDisplayAndEdit
        EditCursorPosition = #SetData[TermToDisplayAndEdit].Definition  -- Place cursor at the end
        EditActivitySelectedTerm = nil
    end

    -- Set color based on whether this box is selected or hovered
    if EditActivitySelectedDefinition == TermToDisplayAndEdit then
        love.graphics.setColor(255, 255, 255)  -- Highlight color for selected
    elseif isHovered then
        love.graphics.setColor(200, 200, 200)  -- Lighter hover color
    else
        love.graphics.setColor(180, 180, 180)  -- Default color
    end
    --95 box background
    love.graphics.rectangle("fill", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setColor(0,0,0)--text color

    -- Only allow editing if this box is currently selected
    if EditActivitySelectedDefinition == TermToDisplayAndEdit then
        function love.textinput(t)
            local Text = SetData[TermToDisplayAndEdit].Definition
            local beforeCursor = Text:sub(1, EditCursorPosition)
            local afterCursor = Text:sub(EditCursorPosition + 1)
            
            -- Update text with input
            SetData[TermToDisplayAndEdit].Definition = beforeCursor .. t .. afterCursor
            EditCursorPosition = EditCursorPosition + #t
        end
        
        -- Extract the text before the cursor for backspacing
        local TextBeforeCursor = SetData[TermToDisplayAndEdit].Definition:sub(1, EditCursorPosition)

        -- Call BackspaceController to handle the text before the cursor
        TextBeforeCursor = BackspaceController(TextBeforeCursor, 1, 0.2)  -- Use suitable hold delay values

        -- Update the full text after backspacing
        local RemainingText = SetData[TermToDisplayAndEdit].Definition:sub(EditCursorPosition + 1)
        SetData[TermToDisplayAndEdit].Definition = TextBeforeCursor .. RemainingText

        -- Update cursor position after backspacing
        EditCursorPosition = #TextBeforeCursor  -- Update cursor position based on backspacing

        -- Handle Ctrl+V for pasting
        if ButtonDebounce("v", 1) and love.keyboard.isDown('lctrl') == true then
            local clipboardText = love.system.getClipboardText()
            local Text = SetData[TermToDisplayAndEdit].Definition
            local beforeCursor = Text:sub(1, EditCursorPosition)
            local afterCursor = Text:sub(EditCursorPosition + 1)

            -- Insert clipboard text at the cursor position
            SetData[TermToDisplayAndEdit].Definition = beforeCursor .. clipboardText .. afterCursor
            EditCursorPosition = EditCursorPosition + #clipboardText  -- Update cursor position
        end
        if ButtonDebounce("return", 1) then
            local Text = SetData[TermToDisplayAndEdit].Definition
            local beforeCursor = Text:sub(1, EditCursorPosition)
            local afterCursor = Text:sub(EditCursorPosition + 1)
            local newline = "\n"
            SetData[TermToDisplayAndEdit].Definition = beforeCursor .. newline .. afterCursor
            EditCursorPosition = EditCursorPosition + #newline  -- Update cursor position
        end

        -- Move the cursor with arrow keys
        if ButtonDebounce("left", 0.1) then
            EditCursorPosition = math.max(0, EditCursorPosition - 1)
        elseif ButtonDebounce("right", 0.1) then
            EditCursorPosition = math.min(#SetData[TermToDisplayAndEdit].Definition, EditCursorPosition + 1)
        end
    end

    -- Draw the text inside the box
    local Text = SetData[TermToDisplayAndEdit].Definition
    local displayText = Text

    -- Add cursor only if the box is selected
    if EditActivitySelectedDefinition == TermToDisplayAndEdit then
        displayText = Text:sub(1, EditCursorPosition) .. "|" .. Text:sub(EditCursorPosition + 1)  -- Add cursor to the text
    end

    local _, wrappedText = TextFont:getWrap(displayText, BoxW)
    local wrappedHeight = #wrappedText * TextFont:getHeight()
    local textY = BoxY + (BoxH - wrappedHeight) / 2
    love.graphics.printf(displayText, BoxX, textY, BoxW, "center")

    --95 box border
    love.graphics.setLineWidth(MediumLine)
    love.graphics.setColorF(255, 255, 255) -- white
    love.graphics.line( BoxX, BoxY+BoxH, BoxX+BoxW, BoxY+BoxH) -- horizontal bottom
    love.graphics.line( BoxX+BoxW, BoxY, BoxX+BoxW, BoxY+BoxH) -- vertical right
    love.graphics.setColorF(0, 0, 0) -- black
    love.graphics.line( BoxX, BoxY, BoxX+BoxW, BoxY) -- horizontal top
    love.graphics.line( BoxX, BoxY, BoxX, BoxY+BoxH) -- vertical left
    love.graphics.setColorF(255, 255, 255)
    love.graphics.setLineWidth(1)
end
function EditActivityRemoveTerm(TermToRemove)
    if TermToRemove==nil then
        print("In EditActivityRemoveTerm() TermToRemove is reporting as: "..tostring(TermToRemove))
        return
    end
    Deleting=true
    EditActivityScroll=0
    if SetData.Terms>0 then
        table.remove(SetData, TermToRemove)
        SetData.Terms=SetData.Terms-1
    end
    Deleting=false
end
function EditActivityCallBackoutPopup()
    PopupCall = true
    PopupAction = 'StateMachine = "Set Options"; LoadEdit(); PopupCall=false'
    PopUpMessage = "Unsaved Edits will be lost"
end