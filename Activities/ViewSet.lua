function ViewActivity()
    SetTitle, SetData = LoadIndividualSet(SetToPreview)
    CenterText(0,scaling(-450,1080,Settings[2]),SetTitle,Exo32Bold)
    local NumberOfTerms=#SetData
    love.graphics.setColor(40,40,40)
    love.graphics.rectangle("fill",scaling(940,1920,Settings[1]),scaling(130,1080,Settings[2]),scaling(40,1920,Settings[1]),scaling(950,1080,Settings[2]))
    love.graphics.setColor(255,255,255)
    if NumberOfTerms>0 then
        DisplayTerm(20,130+MediumLine,910,200,"Test",Exo24,true)
    end
    if NumberOfTerms>1 then

    end
    if NumberOfTerms>2 then
        
    end
    if NumberOfTerms>3 then
       
    end
    if NumberOfTerms>4 then
        
    end
    if NumberOfTerms>5 then
        
    end
    if NumberOfTerms>6 then
        
    end
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