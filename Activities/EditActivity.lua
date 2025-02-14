function EditActivity()
    if Deleting==false then
        if SetTitle==nil or SetData==nil or NumberOfTerms==nil or Settings==nil or EditActivityScroll==nil or Deleting==true then
            print("In EditActivity() SetTitle is reporting as: "..tostring(SetTitle))
            print("In EditActivity() SetData is reporting as: "..tostring(SetData))
            print("In EditActivity() NumberOfTerms is reporting as: "..tostring(NumberOfTerms))
            print("In EditActivity() Settings is reporting as: "..tostring(Settings))
            print("In EditActivity() EditActivityScroll is reporting as: "..tostring(EditActivityScroll))
            return
        end
        EditableTitle(660, 60, 600, 60, Exo32Bold,true)
        N5Button(830, 90, 240, 50, true, 'SaveIndividualSet(SetTitle, SetData, SetToPreview); StateMachine="View Set"; EditActivityScroll=0', false, Exo24Bold, "-> View Mode")
        local TermFont=Exo24
        local DefinitionFont=Exo20
        love.graphics.setColor(40,40,40)
        love.graphics.rectangle("fill",scaling(940,1920,Settings.XRes),scaling(200-MediumLine,1080,Settings.YRes),scaling(40,1920,Settings.XRes),scaling(950,1080,Settings.YRes))
        love.graphics.setColor(255,255,255)
        N5BoxHighlight(390, 145, 240, 50, true, {255,255,255}, true, Exo32Bold, "Terms")
        N5BoxHighlight(1305, 145, 240, 50, true, {255,255,255}, true, Exo32Bold, "Definitions")
        ButtonStyle1Mod3(850, 120, 220, 80, "Save Set", Exo24Bold, true, 'SaveIndividualSet(SetTitle, SetData, SetToPreview)')
        ButtonStyle1Mod3(1090, 120, 80, 80, "+++", Exo24Bold, true, 'table.insert(SetData, {" "," "});NumberOfTerms=NumberOfTerms+1')
        if NumberOfTerms>0 then
            EditableDisplayTerm(20,200+MediumLine,870,200,1+EditActivityScroll,TermFont,true)
            EditableDisplayDefinition(990,200+MediumLine,910,200,1+EditActivityScroll,DefinitionFont,true)
            N5Button(890, 200+MediumLine, 40, 200, true, 'EditActivityRemoveTerm(1+EditActivityScroll)', false, Exo24Bold, "X")
        end
        if NumberOfTerms>1 then
            EditableDisplayTerm(20,420+MediumLine,870,200,2+EditActivityScroll,TermFont,true)
            EditableDisplayDefinition(990,420+MediumLine,910,200,2+EditActivityScroll,DefinitionFont,true)
            N5Button(890, 420+MediumLine, 40, 200, true, 'EditActivityRemoveTerm(2+EditActivityScroll)', false, Exo24Bold, "X")
        end
        if NumberOfTerms>2 then
            EditableDisplayTerm(20,640+MediumLine,870,200,3+EditActivityScroll,TermFont,true)
            EditableDisplayDefinition(990,640+MediumLine,910,200,3+EditActivityScroll,DefinitionFont,true)
            N5Button(890, 640+MediumLine, 40, 200, true, 'EditActivityRemoveTerm(3+EditActivityScroll)', false, Exo24Bold, "X")
        end
        if NumberOfTerms>3 then
            EditableDisplayTerm(20,860+MediumLine,870,200,4+EditActivityScroll,TermFont,true)
            EditableDisplayDefinition(990,860+MediumLine,910,200,4+EditActivityScroll,DefinitionFont,true)
            N5Button(890, 860+MediumLine, 40, 200, true, 'EditActivityRemoveTerm(4+EditActivityScroll)', false, Exo24Bold, "X")
            EditActivityScroll=N5ScrollBar(940,200-MediumLine,40,750,4,NumberOfTerms,EditActivityScroll,true)
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
        EditCursorPositionTerm = #SetData[TermToDisplayAndEdit][2]  -- Set cursor to the end of the text
    end

    -- Set color based on whether this box is selected or hovered
    if EditActivitySelectedTerm == TermToDisplayAndEdit then
        love.graphics.setColor(255, 255, 255)  -- Highlight color for selected
    elseif isHovered then
        love.graphics.setColor(200, 200, 200)  -- Lighter hover color
    else
        love.graphics.setColor(255, 153, 0)  -- Default color
    end

    -- Only allow editing if this box is currently selected
    if EditActivitySelectedTerm == TermToDisplayAndEdit then
        function love.textinput(t)
            local Text = SetData[TermToDisplayAndEdit][2]
            local beforeCursor = Text:sub(1, EditCursorPositionTerm)
            local afterCursor = Text:sub(EditCursorPositionTerm + 1)

            SetData[TermToDisplayAndEdit][2] = beforeCursor .. t .. afterCursor
            EditCursorPositionTerm = EditCursorPositionTerm + #t
        end

        -- Extract the text before the cursor for backspacing
        local TextBeforeCursor = SetData[TermToDisplayAndEdit][2]:sub(1, EditCursorPositionTerm)

        -- Call BackspaceController to handle the text before the cursor
        TextBeforeCursor = BackspaceController(TextBeforeCursor, 1, 0.2)  -- Use suitable hold delay values

        -- Update the full text after backspacing
        local RemainingText = SetData[TermToDisplayAndEdit][2]:sub(EditCursorPositionTerm + 1)
        SetData[TermToDisplayAndEdit][2] = TextBeforeCursor .. RemainingText

        -- Update cursor position after backspacing
        EditCursorPositionTerm = #TextBeforeCursor  -- Update cursor position based on backspacing

        -- Handle Ctrl+V for pasting
        if ButtonDebounce("v", 1) and love.keyboard.isDown('lctrl') == true then
            local clipboardText = love.system.getClipboardText()
            local Text = SetData[TermToDisplayAndEdit][2]
            local beforeCursor = Text:sub(1, EditCursorPositionTerm)
            local afterCursor = Text:sub(EditCursorPositionTerm + 1)

            -- Insert clipboard text at the cursor position
            SetData[TermToDisplayAndEdit][2] = beforeCursor .. clipboardText .. afterCursor
            EditCursorPositionTerm = EditCursorPositionTerm + #clipboardText  -- Update cursor position
        end

        -- Move the cursor with arrow keys
        if ButtonDebounce("left", 0.1) then
            EditCursorPositionTerm = math.max(0, EditCursorPositionTerm - 1)
        elseif ButtonDebounce("right", 0.1) then
            EditCursorPositionTerm = math.min(#SetData[TermToDisplayAndEdit][2], EditCursorPositionTerm + 1)
        end
    end

    -- Draw the text inside the box
    local Text = SetData[TermToDisplayAndEdit][2]
    local displayText = Text

    -- Add cursor only if the box is selected
    if EditActivitySelectedTerm == TermToDisplayAndEdit then
        displayText = Text:sub(1, EditCursorPositionTerm) .. "|" .. Text:sub(EditCursorPositionTerm + 1)  -- Add cursor to the text
    end

    local _, wrappedText = TextFont:getWrap(displayText, BoxW)
    local wrappedHeight = #wrappedText * TextFont:getHeight()
    local textY = BoxY + (BoxH - wrappedHeight) / 2
    love.graphics.printf(displayText, BoxX, textY, BoxW, "center")
    
    -- Draw the box border
    love.graphics.setLineWidth(MediumLine)
    love.graphics.rectangle("line", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setLineWidth(ThinLine)
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
        EditCursorPosition = #SetData[TermToDisplayAndEdit][1]  -- Place cursor at the end
        EditActivitySelectedTerm = nil
    end

    -- Set color based on whether this box is selected or hovered
    if EditActivitySelectedDefinition == TermToDisplayAndEdit then
        love.graphics.setColor(255, 255, 255)  -- Highlight color for selected
    elseif isHovered then
        love.graphics.setColor(200, 200, 200)  -- Lighter hover color
    else
        love.graphics.setColor(255, 153, 0)  -- Default color
    end

    -- Only allow editing if this box is currently selected
    if EditActivitySelectedDefinition == TermToDisplayAndEdit then
        function love.textinput(t)
            local Text = SetData[TermToDisplayAndEdit][1]
            local beforeCursor = Text:sub(1, EditCursorPosition)
            local afterCursor = Text:sub(EditCursorPosition + 1)

            -- Update text with input
            SetData[TermToDisplayAndEdit][1] = beforeCursor .. t .. afterCursor
            EditCursorPosition = EditCursorPosition + #t
        end

        -- Extract the text before the cursor for backspacing
        local TextBeforeCursor = SetData[TermToDisplayAndEdit][1]:sub(1, EditCursorPosition)

        -- Call BackspaceController to handle the text before the cursor
        TextBeforeCursor = BackspaceController(TextBeforeCursor, 1, 0.2)  -- Use suitable hold delay values

        -- Update the full text after backspacing
        local RemainingText = SetData[TermToDisplayAndEdit][1]:sub(EditCursorPosition + 1)
        SetData[TermToDisplayAndEdit][1] = TextBeforeCursor .. RemainingText

        -- Update cursor position after backspacing
        EditCursorPosition = #TextBeforeCursor  -- Update cursor position based on backspacing

        -- Handle Ctrl+V for pasting
        if ButtonDebounce("v", 1) and love.keyboard.isDown('lctrl') == true then
            local clipboardText = love.system.getClipboardText()
            local Text = SetData[TermToDisplayAndEdit][1]
            local beforeCursor = Text:sub(1, EditCursorPosition)
            local afterCursor = Text:sub(EditCursorPosition + 1)

            -- Insert clipboard text at the cursor position
            SetData[TermToDisplayAndEdit][1] = beforeCursor .. clipboardText .. afterCursor
            EditCursorPosition = EditCursorPosition + #clipboardText  -- Update cursor position
        end

        -- Move the cursor with arrow keys
        if ButtonDebounce("left", 0.1) then
            EditCursorPosition = math.max(0, EditCursorPosition - 1)
        elseif ButtonDebounce("right", 0.1) then
            EditCursorPosition = math.min(#SetData[TermToDisplayAndEdit][1], EditCursorPosition + 1)
        end
    end

    -- Draw the text inside the box
    local Text = SetData[TermToDisplayAndEdit][1]
    local displayText = Text

    -- Add cursor only if the box is selected
    if EditActivitySelectedDefinition == TermToDisplayAndEdit then
        displayText = Text:sub(1, EditCursorPosition) .. "|" .. Text:sub(EditCursorPosition + 1)  -- Add cursor to the text
    end

    local _, wrappedText = TextFont:getWrap(displayText, BoxW)
    local wrappedHeight = #wrappedText * TextFont:getHeight()
    local textY = BoxY + (BoxH - wrappedHeight) / 2
    love.graphics.printf(displayText, BoxX, textY, BoxW, "center")

    -- Draw the box border
    love.graphics.setLineWidth(MediumLine)
    love.graphics.rectangle("line", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setLineWidth(ThinLine)
end
function EditActivityRemoveTerm(TermToRemove)
    if TermToRemove==nil then
        print("In EditActivityRemoveTerm() TermToRemove is reporting as: "..tostring(TermToRemove))
        return
    end
    Deleting=true
    EditActivityScroll=0
    table.remove(SetData, TermToRemove)
    NumberOfTerms=NumberOfTerms-1
    Deleting=false
end
function EditActivityCallBackoutPopup()
    PopupCall = true
    PopupAction = 'StateMachine = "Set Options"; LoadEdit(); PopupCall=false'
    PopUpMessage = "Unsaved Edits will be lost"
end
function EditableTitle(BoxX, BoxY, BoxW, BoxH, TextFont,Scaling)
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil or TextFont==nil or Scaling==nil or SetTitle==nil then
        print("In EditableTitle() BoxX is reporting as: "..tostring(BoxX))
        print("In EditableTitle() BoxY is reporting as: "..tostring(BoxY))
        print("In EditableTitle() BoxW is reporting as: "..tostring(BoxW))
        print("In EditableTitle() BoxH is reporting as: "..tostring(BoxH))
        print("In EditableTitle() TextFont is reporting as: "..tostring(TextFont))
        print("In EditableTitle() Scaling is reporting as: "..tostring(Scaling))
        print("In EditableTitle() SetTitle is reporting as: "..tostring(SetTitle))
        return
    end
    love.graphics.setFont(TextFont)
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
    end
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    if Selected then
        love.graphics.setColor(255, 153, 0)
        EditActivitySelectedTerm = nil
        EditActivitySelectedDefinition = nil
        function love.textinput(t)
            SetTitle=SetTitle..t
        end
        SetTitle=BackspaceController(SetTitle,1,0.1)
    else
        function love.textinput(t)
        end 
    end
    local Text=SetTitle
    local TH = TextFont:getHeight() * #Text / BoxW -- Estimate height based on wrapping
    local _, wrappedText = TextFont:getWrap(Text, BoxW)
    local wrappedHeight = #wrappedText * TextFont:getHeight()
    -- Coordinates for the text
    local textY = BoxY + (BoxH - wrappedHeight) / 2  -- Center the text vertically
    love.graphics.printf(Text, BoxX, textY, BoxW, "center")  -- Print wrapped and centered text
    love.graphics.setLineWidth(MediumLine)
    if Selected then
        love.graphics.setColor(255, 255, 255)
    else
        love.graphics.setColor(255, 153, 0)
    end
    love.graphics.rectangle("line", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setLineWidth(ThinLine)
    love.graphics.setColor(255, 255, 255)
end