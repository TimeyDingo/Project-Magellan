function ViewActivity()
    SetTitle, SetData = LoadIndividualSet(SetToPreview)
    if SetTitle==nil or SetData==nil or ViewActivityScroll==nil then
        print("In ViewActivity() SetTitle is reporting as: "..tostring(SetTitle))
        print("In ViewActivity() SetData is reporting as: "..tostring(SetData))
        print("In ViewActivity() ViewActivityScroll is reporting as: "..tostring(ViewActivityScroll))
        return
    end
    CenterText(0,scaling(-450,1080,Settings[2]),SetTitle,Exo32Bold)
    ButtonStyle1Mod3(830, 0, 240, 55, "-> Edit Mode", Exo24Bold, true, 'StateMachine="Edit"')
    local TermFont=Exo24
    local DefinitionFont=Exo20
    local NumberOfTerms=#SetData
    love.graphics.setColor(40,40,40)
    love.graphics.rectangle("fill",scaling(940,1920,Settings[1]),scaling(200,1080,Settings[2]),scaling(40,1920,Settings[1]),scaling(950,1080,Settings[2]))
    love.graphics.setColor(255,255,255)
    CenterText(scaling(-485,1920,Settings[1]),scaling(-380,1080,Settings[2]),"Terms",Exo24Bold)
    CenterText(scaling(485,1920,Settings[1]),scaling(-380,1080,Settings[2]),"Definitions",Exo24Bold)
    if NumberOfTerms>0 then
        DisplayTerm(20,200+MediumLine,910,200,SetData[1+ViewActivityScroll][2],TermFont,true)
        DisplayDefinition(990,200+MediumLine,910,200,SetData[1+ViewActivityScroll][1],DefinitionFont,true)
    end
    if NumberOfTerms>1 then
        DisplayTerm(20,420+MediumLine,910,200,SetData[2+ViewActivityScroll][2],TermFont,true)
        DisplayDefinition(990,420+MediumLine,910,200,SetData[2+ViewActivityScroll][1],DefinitionFont,true)
    end
    if NumberOfTerms>2 then
        DisplayTerm(20,640+MediumLine,910,200,SetData[3+ViewActivityScroll][2],TermFont,true)
        DisplayDefinition(990,640+MediumLine,910,200,SetData[3+ViewActivityScroll][1],DefinitionFont,true)
    end
    if NumberOfTerms>3 then
        DisplayTerm(20,860+MediumLine,910,200,SetData[4+ViewActivityScroll][2],TermFont,true)
        DisplayDefinition(990,860+MediumLine,910,200,SetData[4+ViewActivityScroll][1],DefinitionFont,true)
        ViewActivityScroll=ScrollBar(940,200-MediumLine,40,750,4,NumberOfTerms,ViewActivityScroll,true)
    end
    love.graphics.setColor(255,255,255)
end
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
        BoxX=scaling(BoxX,1920,Settings[1])
        BoxY=scaling(BoxY,1080,Settings[2])
        BoxW=scaling(BoxW,1920,Settings[1])
        BoxH=scaling(BoxH,1080,Settings[2])
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
        BoxX=scaling(BoxX,1920,Settings[1])
        BoxY=scaling(BoxY,1080,Settings[2])
        BoxW=scaling(BoxW,1920,Settings[1])
        BoxH=scaling(BoxH,1080,Settings[2])
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