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
        ButtonStyle1Mod3(830, 0, 240, 55, "-> View Mode", Exo24Bold, true, 'SaveIndividualSet(SetTitle, SetData, SetToPreview); StateMachine="View Set"; EditActivityScroll=0')
        local TermFont=Exo24
        local DefinitionFont=Exo20
        love.graphics.setColor(40,40,40)
        love.graphics.rectangle("fill",scaling(940,1920,Settings.XRes),scaling(200-MediumLine,1080,Settings.YRes),scaling(40,1920,Settings.XRes),scaling(950,1080,Settings.YRes))
        love.graphics.setColor(255,255,255)
        CenterText(scaling(-485,1920,Settings.XRes),scaling(-380,1080,Settings.YRes),"Terms",Exo24Bold)
        CenterText(scaling(485,1920,Settings.XRes),scaling(-380,1080,Settings.YRes),"Definitions",Exo24Bold)
        ButtonStyle1Mod3(850, 120, 220, 80, "Save Set", Exo24Bold, true, 'SaveIndividualSet(SetTitle, SetData, SetToPreview)')
        ButtonStyle1Mod3(1090, 120, 80, 80, "+++", Exo24Bold, true, 'table.insert(SetData, {" "," "});NumberOfTerms=NumberOfTerms+1')
        if NumberOfTerms>0 then
            EditableDisplayTerm(20,200+MediumLine,870,200,1+EditActivityScroll,TermFont,true)
            EditableDisplayDefinition(990,200+MediumLine,910,200,1+EditActivityScroll,DefinitionFont,true)
            ButtonStyle1Mod3(890, 200+MediumLine, 40, 200, "X", Exo24Bold, true, 'EditActivityRemoveTerm(1+EditActivityScroll)')
        end
        if NumberOfTerms>1 then
            EditableDisplayTerm(20,420+MediumLine,870,200,2+EditActivityScroll,TermFont,true)
            EditableDisplayDefinition(990,420+MediumLine,910,200,2+EditActivityScroll,DefinitionFont,true)
            ButtonStyle1Mod3(890, 420+MediumLine, 40, 200, "X", Exo24Bold, true, 'EditActivityRemoveTerm(2+EditActivityScroll)')
        end
        if NumberOfTerms>2 then
            EditableDisplayTerm(20,640+MediumLine,870,200,3+EditActivityScroll,TermFont,true)
            EditableDisplayDefinition(990,640+MediumLine,910,200,3+EditActivityScroll,DefinitionFont,true)
            ButtonStyle1Mod3(890, 640+MediumLine, 40, 200, "X", Exo24Bold, true, 'EditActivityRemoveTerm(3+EditActivityScroll)')
        end
        if NumberOfTerms>3 then
            EditableDisplayTerm(20,860+MediumLine,870,200,4+EditActivityScroll,TermFont,true)
            EditableDisplayDefinition(990,860+MediumLine,910,200,4+EditActivityScroll,DefinitionFont,true)
            ButtonStyle1Mod3(890, 860+MediumLine, 40, 200, "X", Exo24Bold, true, 'EditActivityRemoveTerm(4+EditActivityScroll)')
            EditActivityScroll=ScrollBar(940,200-MediumLine,40,750,4,NumberOfTerms,EditActivityScroll,true)
        end
    end
    love.graphics.setColor(255,255,255)
end
function EditableDisplayTerm(BoxX, BoxY, BoxW, BoxH, TermToDisplayAndEdit, TextFont, Scaling)
    -- Scaling logic
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
    end

    -- Check if the mouse is over the box
    local isHovered = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    
    -- Check for mouse click to select the box
    if isHovered and love.mouse.isDown(1) then
        EditActivitySelectedTerm = TermToDisplayAndEdit
        EditActivitySelectedDefinition = nil
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
            SetData[TermToDisplayAndEdit][2] = SetData[TermToDisplayAndEdit][2] .. t
        end
        SetData[TermToDisplayAndEdit][2] = BackspaceController(SetData[TermToDisplayAndEdit][2], 0.5, 0.1)
        if ButtonDebounce("v", 1) and love.keyboard.isDown('lctrl') == true then
            SetData[TermToDisplayAndEdit][2] = SetData[TermToDisplayAndEdit][2] .. love.system.getClipboardText()
        end
    end

    -- Draw the text inside the box
    local Text = SetData[TermToDisplayAndEdit][2]
    local _, wrappedText = TextFont:getWrap(Text, BoxW)
    local wrappedHeight = #wrappedText * TextFont:getHeight()
    local textY = BoxY + (BoxH - wrappedHeight) / 2
    love.graphics.printf(Text, BoxX, textY, BoxW, "center")
    
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
            SetData[TermToDisplayAndEdit][1] = SetData[TermToDisplayAndEdit][1] .. t
        end
        SetData[TermToDisplayAndEdit][1] = BackspaceController(SetData[TermToDisplayAndEdit][1], 0.5, 0.1)
        if ButtonDebounce("v", 1) and love.keyboard.isDown('lctrl') == true then
            SetData[TermToDisplayAndEdit][1] = SetData[TermToDisplayAndEdit][1] .. love.system.getClipboardText()
        end
    end

    -- Draw the text inside the box
    local Text = SetData[TermToDisplayAndEdit][1]
    local _, wrappedText = TextFont:getWrap(Text, BoxW)
    local wrappedHeight = #wrappedText * TextFont:getHeight()
    local textY = BoxY + (BoxH - wrappedHeight) / 2
    love.graphics.printf(Text, BoxX, textY, BoxW, "center")

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