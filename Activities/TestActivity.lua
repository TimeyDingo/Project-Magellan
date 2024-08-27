function TestActivity()--! potential scrolling bug with the positioning of the scroll bar vertically when bottoming out the position
    
    TestActivityCheckIfEnoughTerms()
    CenterText(0,scaling(-450,1080,Settings[2]),SetTitle,Exo32Bold)
    local TermFont=Exo24
    local DefinitionFont=Exo20
    love.graphics.setColor(40,40,40)
    love.graphics.rectangle("fill",scaling(940,1920,Settings[1]),scaling(200,1080,Settings[2]),scaling(40,1920,Settings[1]),scaling(950,1080,Settings[2]))
    love.graphics.setColor(255,255,255)
    CenterText(scaling(-485,1920,Settings[1]),scaling(-380,1080,Settings[2]),"Term",Exo24Bold)
    CenterText(scaling(485,1920,Settings[1]),scaling(-380,1080,Settings[2]),"Definitions",Exo24Bold)
    
    TestActivityDisplayTerm(20,530+MediumLine,910,200,TestActivityTestTable[1+TestActivityScroll].TermToTest,TermFont,true)
    TestActivityDisplayDefinition(990,TestActivityTestTable[1+TestActivityScroll].CorrectAnswerPos,910,200,TestActivityTestTable[1+TestActivityScroll].CorrectAnswer,DefinitionFont,true)
    TestActivityDisplayDefinition(990,TestActivityTestTable[1+TestActivityScroll].WrongAnswer1Pos,910,200,TestActivityTestTable[1+TestActivityScroll].WrongAnswer1,DefinitionFont,true)
    TestActivityDisplayDefinition(990,TestActivityTestTable[1+TestActivityScroll].WrongAnswer2Pos,910,200,TestActivityTestTable[1+TestActivityScroll].WrongAnswer2,DefinitionFont,true)
    TestActivityDisplayDefinition(990,TestActivityTestTable[1+TestActivityScroll].WrongAnswer3Pos,910,200,TestActivityTestTable[1+TestActivityScroll].WrongAnswer3,DefinitionFont,true)
    --? Scrolling stuff below
    love.graphics.setColor(255, 153, 0)
    local ScrollingOrigin=scaling(950,1080,Settings[2])
    love.graphics.rectangle("fill",scaling(940,1920,Settings[1]),scaling(200,1080,Settings[2])+(ScrollingOrigin/NumberOfTerms)*TestActivityScroll,scaling(40,1920,Settings[1]),ScrollingOrigin/NumberOfTerms)
    love.graphics.setColor(255,255,255)
    if ButtonDebounce("up", 30) and TestActivityScroll > 0 then
        TestActivityScroll = TestActivityScroll - 1
    end
    if ButtonDebounce("down", 30) and TestActivityScroll < NumberOfTerms-1 then
        TestActivityScroll = TestActivityScroll + 1
    end
    love.graphics.setColor(255,255,255)
end
function TestActivityDisplayTerm(BoxX, BoxY, BoxW, BoxH, Text, TextFont,Scaling)
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
function TestActivityDisplayDefinition(BoxX, Position, BoxW, BoxH, Text, TextFont, Scaling)
    if Position==1 then
        BoxY=200+MediumLine
    end
    if Position==2 then
        BoxY=420+MediumLine
    end
    if Position==3 then
        BoxY=640+MediumLine
    end
    if Position==4 then
        BoxY=860+MediumLine
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
function TestActivityCheckIfEnoughTerms()
    if NumberOfTerms<4 then
        StateMachine="Set Options"
        PopupCall = true
        PopupAction = 'StateMachine = "Set Options"; PopupCall=false'
        PopUpMessage = "Too few terms, 4 or more is needed"
        BackoutAction= 'PopupCall=false'
    end
end