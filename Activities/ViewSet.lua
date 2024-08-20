function ViewActivity()
    SetTitle, SetData = LoadIndividualSet(SetToPreview)
    CenterText(0,scaling(-450,1080,Settings[2]),SetTitle,Exo32Bold)
    local TermFont=Exo24
    local DefinitionFont=Exo20
    local NumberOfTerms=#SetData
    love.graphics.setColor(40,40,40)
    love.graphics.rectangle("fill",scaling(940,1920,Settings[1]),scaling(130,1080,Settings[2]),scaling(40,1920,Settings[1]),scaling(950,1080,Settings[2]))
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
        --? Scrolling stuff below
        love.graphics.setColor(255, 153, 0)
        local ScrollingOrigin=scaling(950,1080,Settings[2])
        love.graphics.rectangle("fill",scaling(940,1920,Settings[1]),scaling(130,1080,Settings[2])+(ScrollingOrigin/NumberOfTerms)*ViewActivityScroll,scaling(40,1920,Settings[1]),ScrollingOrigin/NumberOfTerms*4)
        love.graphics.setColor(255,255,255)
        if ButtonDebounce("up", 30) and ViewActivityScroll > 0 then
            ViewActivityScroll = ViewActivityScroll - 1
        end
        if ButtonDebounce("down", 30) and ViewActivityScroll < NumberOfTerms-4 then
            ViewActivityScroll = ViewActivityScroll + 1
        end
    end
    love.graphics.setColor(255,255,255)
end
function DisplayTerm(BoxX, BoxY, BoxW, BoxH, Text, TextFont,Scaling)
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