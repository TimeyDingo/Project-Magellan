function EditActivity()
    EditableTitle(660, 60, 600, 60, Exo32Bold,true)
    local TermFont=Exo24
    local DefinitionFont=Exo20
    love.graphics.setColor(40,40,40)
    love.graphics.rectangle("fill",scaling(940,1920,Settings[1]),scaling(200-MediumLine,1080,Settings[2]),scaling(40,1920,Settings[1]),scaling(950,1080,Settings[2]))
    love.graphics.setColor(255,255,255)
    CenterText(scaling(-485,1920,Settings[1]),scaling(-380,1080,Settings[2]),"Terms",Exo24Bold)
    CenterText(scaling(485,1920,Settings[1]),scaling(-380,1080,Settings[2]),"Definitions",Exo24Bold)
    ButtonStyle1Mod3(850, 120, 220, 80, "Save Set", Exo24Bold, true, 'SaveIndividualSet(SetTitle, SetData, SetToPreview)')
    ButtonStyle1Mod3(1090, 120, 80, 80, "+++", Exo24Bold, true, 'table.insert(SetData, {"",""});NumberOfTerms=NumberOfTerms+1')
    if Deleting==false then
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
            --? Scrolling stuff below
            love.graphics.setColor(255, 153, 0)
            local ScrollingOrigin=scaling(950,1080,Settings[2])
            love.graphics.rectangle("fill",scaling(940,1920,Settings[1]),scaling(200-MediumLine,1080,Settings[2])+(ScrollingOrigin/NumberOfTerms)*EditActivityScroll,scaling(40,1920,Settings[1]),ScrollingOrigin/NumberOfTerms*4)
            love.graphics.setColor(255,255,255)
            if ButtonDebounce("up", 30) and EditActivityScroll > 0 then
                EditActivityScroll = EditActivityScroll - 1
            end
            if ButtonDebounce("down", 30) and EditActivityScroll < NumberOfTerms-4 then
                EditActivityScroll = EditActivityScroll + 1
            end
        end
    end
    love.graphics.setColor(255,255,255)
end
function EditableDisplayTerm(BoxX, BoxY, BoxW, BoxH, TermToDisplayAndEdit, TextFont,Scaling)
    love.graphics.setFont(TextFont)
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings[1])
        BoxY=scaling(BoxY,1080,Settings[2])
        BoxW=scaling(BoxW,1920,Settings[1])
        BoxH=scaling(BoxH,1080,Settings[2])
    end
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    if Selected then
        love.graphics.setColor(255, 255, 255)
        function love.textinput(t)
            SetData[TermToDisplayAndEdit][2]=SetData[TermToDisplayAndEdit][2]..t
        end
        SetData[TermToDisplayAndEdit][2]=BackspaceController(SetData[TermToDisplayAndEdit][2],30)
    else
        love.graphics.setColor(255, 153, 0)
    end
    Text=SetData[TermToDisplayAndEdit][2]
    local TH = TextFont:getHeight() * #Text / BoxW -- Estimate height based on wrapping
    local _, wrappedText = TextFont:getWrap(Text, BoxW)
    local wrappedHeight = #wrappedText * TextFont:getHeight()
    -- Coordinates for the text
    local textY = BoxY + (BoxH - wrappedHeight) / 2  -- Center the text vertically
    love.graphics.printf(Text, BoxX, textY, BoxW, "center")  -- Print wrapped and centered text
    love.graphics.setLineWidth(MediumLine)
    love.graphics.setColor(255, 153, 0)
    love.graphics.rectangle("line", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setLineWidth(ThinLine)
    love.graphics.setColor(255, 255, 255)
end
function EditableDisplayDefinition(BoxX, BoxY, BoxW, BoxH, TermToDisplayAndEdit, TextFont,Scaling)
    love.graphics.setFont(TextFont)
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings[1])
        BoxY=scaling(BoxY,1080,Settings[2])
        BoxW=scaling(BoxW,1920,Settings[1])
        BoxH=scaling(BoxH,1080,Settings[2])
    end
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    if Selected then
        love.graphics.setColor(255, 255, 255)
        function love.textinput(t)
            SetData[TermToDisplayAndEdit][1]=SetData[TermToDisplayAndEdit][1]..t
        end
        SetData[TermToDisplayAndEdit][1]=BackspaceController(SetData[TermToDisplayAndEdit][1],30)
    else
        love.graphics.setColor(255, 153, 0)
    end
    Text=SetData[TermToDisplayAndEdit][1]
    local TH = TextFont:getHeight() * #Text / BoxW -- Estimate height based on wrapping
    local _, wrappedText = TextFont:getWrap(Text, BoxW)
    local wrappedHeight = #wrappedText * TextFont:getHeight()
    -- Coordinates for the text
    local textY = BoxY + (BoxH - wrappedHeight) / 2  -- Center the text vertically
    love.graphics.printf(Text, BoxX, textY, BoxW, "center")  -- Print wrapped and centered text
    love.graphics.setLineWidth(MediumLine)
    love.graphics.setColor(255, 153, 0)
    love.graphics.rectangle("line", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setLineWidth(ThinLine)
    love.graphics.setColor(255, 255, 255)
end
function EditActivityRemoveTerm(TermToRemove)
    Deleting=true
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
        return
    end
    love.graphics.setFont(TextFont)
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings[1])
        BoxY=scaling(BoxY,1080,Settings[2])
        BoxW=scaling(BoxW,1920,Settings[1])
        BoxH=scaling(BoxH,1080,Settings[2])
    end
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    if Selected then
        love.graphics.setColor(255, 255, 255)
        function love.textinput(t)
            SetTitle=SetTitle..t
        end
        SetTitle=BackspaceController(SetTitle,30)
    else
        love.graphics.setColor(255, 153, 0)
    end
    Text=SetTitle
    local TH = TextFont:getHeight() * #Text / BoxW -- Estimate height based on wrapping
    local _, wrappedText = TextFont:getWrap(Text, BoxW)
    local wrappedHeight = #wrappedText * TextFont:getHeight()
    -- Coordinates for the text
    local textY = BoxY + (BoxH - wrappedHeight) / 2  -- Center the text vertically
    love.graphics.printf(Text, BoxX, textY, BoxW, "center")  -- Print wrapped and centered text
    love.graphics.setLineWidth(MediumLine)
    love.graphics.setColor(255, 153, 0)
    love.graphics.rectangle("line", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setLineWidth(ThinLine)
    love.graphics.setColor(255, 255, 255)
end