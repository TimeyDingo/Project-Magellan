function ViewActivity()
    SetTitle, SetData = LoadIndividualSet(SetToPreview)
    if SetTitle==nil or SetData==nil or ViewActivityScroll==nil then
        print("In ViewActivity() SetTitle is reporting as: "..tostring(SetTitle))
        print("In ViewActivity() SetData is reporting as: "..tostring(SetData))
        print("In ViewActivity() ViewActivityScroll is reporting as: "..tostring(ViewActivityScroll))
        return
    end
    N5BoxHighlight(660, 145, 600, 50, true, {255,255,255}, true, SmallHeaderBold, SetTitle)
    N5Button(830, 90, 240, 50, true, 'StateMachine="Edit"; EditActivityScroll=0', false, BodyFontBold,"-> Edit Mode")
    local TermFont=BodyFont
    local DefinitionFont=SmallBodyFont
    local NumberOfTerms=#SetData
    love.graphics.setColor(40,40,40)
    love.graphics.rectangle("fill",scaling(940,1920,Settings.XRes),scaling(200,1080,Settings.YRes),scaling(40,1920,Settings.XRes),scaling(950,1080,Settings.YRes))
    love.graphics.setColor(255,255,255)
    N5BoxHighlight(390, 145, 240, 50, true, {255,255,255}, true, SmallHeaderBold, "Terms")
    N5BoxHighlight(1305, 145, 240, 50, true, {255,255,255}, true, SmallHeaderBold, "Definitions")
    if NumberOfTerms>0 then
        N5BoxHighlight(20, 200+MediumLine, 910, 200, true, {255,255,255}, true, TermFont, SetData[1+ViewActivityScroll][2])
        N5BoxHighlight(990, 200+MediumLine, 910, 200, true, {255,255,255}, true, DefinitionFont, SetData[1+ViewActivityScroll][1])
    end
    if NumberOfTerms>1 then
        N5BoxHighlight(20, 420+MediumLine, 910, 200, true, {255,255,255}, true, TermFont, SetData[2+ViewActivityScroll][2])
        N5BoxHighlight(990, 420+MediumLine, 910, 200, true, {255,255,255}, true, DefinitionFont, SetData[2+ViewActivityScroll][1])
    end
    if NumberOfTerms>2 then
        N5BoxHighlight(20, 640+MediumLine, 910, 200, true, {255,255,255}, true, TermFont, SetData[3+ViewActivityScroll][2])
        N5BoxHighlight(990, 640+MediumLine, 910, 200, true, {255,255,255}, true, DefinitionFont, SetData[3+ViewActivityScroll][1])
    end
    if NumberOfTerms>3 then
        N5BoxHighlight(20, 860+MediumLine, 910, 200, true, {255,255,255}, true, TermFont, SetData[4+ViewActivityScroll][2])
        N5BoxHighlight(990, 860+MediumLine, 910, 200, true, {255,255,255}, true, DefinitionFont, SetData[4+ViewActivityScroll][1])
        ViewActivityScroll=N5ScrollBar(940,200-MediumLine,40,750,4,NumberOfTerms,ViewActivityScroll,true)
    end
    love.graphics.setColor(255,255,255)
end
--[[ old display
        --DisplayTerm(20,420+MediumLine,910,200,SetData[2+ViewActivityScroll][2],TermFont,true)
        --DisplayDefinition(990,420+MediumLine,910,200,SetData[2+ViewActivityScroll][1],DefinitionFont,true)
function DisplayTerm(BoxX, BoxY, BoxW, BoxH, Text, TextFont,Scaling)
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil or Text==nil or TextFont==nil then
        print("In DisplayTerm() BoxX is reporting as: "..tostring(BoxX))
        print("In DisplayTerm() BoxY is reporting as: "..tostring(BoxY))
        print("In DisplayTerm() BoxW is reporting as: "..tostring(BoxW))
        print("In DisplayTerm() BoxH is reporting as: "..tostring(BoxH))
        print("In DisplayTerm() Text is reporting as: "..tostring(Text))
        print("In DisplayTerm() TextFont is reporting as: "..tostring(TextFont))
        return
    end
    love.graphics.setFont(TextFont)
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
    end
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
function DisplayDefinition(BoxX, BoxY, BoxW, BoxH, Text, TextFont,Scaling)
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil or Text==nil or TextFont==nil then
        print("In DisplayDefinition() BoxX is reporting as: "..tostring(BoxX))
        print("In DisplayDefinition() BoxY is reporting as: "..tostring(BoxY))
        print("In DisplayDefinition() BoxW is reporting as: "..tostring(BoxW))
        print("In DisplayDefinition() BoxH is reporting as: "..tostring(BoxH))
        print("In DisplayDefinition() Text is reporting as: "..tostring(Text))
        print("In DisplayDefinition() TextFont is reporting as: "..tostring(TextFont))
        return
    end
    love.graphics.setFont(TextFont)
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
    end
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
]]