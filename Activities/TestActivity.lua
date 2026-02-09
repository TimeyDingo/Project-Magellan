function TestActivity()
    TestActivityCheckIfEnoughTerms()
    local TermFont=BodyFont
    local DefinitionFont=SmallBodyFont
    love.graphics.setColor(40,40,40)
    love.graphics.rectangle("fill",scaling(940,1920,Settings.XRes),scaling(200,1080,Settings.YRes),scaling(40,1920,Settings.XRes),scaling(950,1080,Settings.YRes))
    love.graphics.setColor(255,255,255)
    N5BoxHighlight(390, 145, 240, 50, true, {255,255,255}, true, SmallHeaderBold, "Terms")
    N5BoxHighlight(1305, 145, 240, 50, true, {255,255,255}, true, SmallHeaderBold, "Definitions")
    local AnsweredCount, TotalQuestions = TestActivityCalculateHowManyHaveBeenAnswered()
    if AnsweredCount==nil or TotalQuestions==nil or TestActivityTestTable==nil then
        print("In TestActivity() AnsweredCount is reporting as: "..tostring(AnsweredCount))
        print("In TestActivity() TotalQuestions is reporting as: "..tostring(TotalQuestions))
        print("In TestActivity() TestActivityTestTable is reporting as: "..tostring(TestActivityTestTable))
    end
    N5BoxHighlight(660, 145, 600, 50, true, {255,255,255}, true, SmallHeaderBold, SetTitle)
    N5BoxHighlight(830, 90, 240, 50, true, {255,255,255}, true, SmallHeaderBold, AnsweredCount.."/"..TotalQuestions)
    N5BoxHighlight(20,530+MediumLine,910,200, true, {255,255,255}, true, TermFont, TestActivityTestTable[1+TestActivityScroll].TermToTest)
    TestActivityDisplayDefinition(990,TestActivityTestTable[1+TestActivityScroll].CorrectAnswerPos,910,200,TestActivityTestTable[1+TestActivityScroll].CorrectAnswer,DefinitionFont,true)
    TestActivityDisplayDefinition(990,TestActivityTestTable[1+TestActivityScroll].WrongAnswer1Pos,910,200,TestActivityTestTable[1+TestActivityScroll].WrongAnswer1,DefinitionFont,true)
    TestActivityDisplayDefinition(990,TestActivityTestTable[1+TestActivityScroll].WrongAnswer2Pos,910,200,TestActivityTestTable[1+TestActivityScroll].WrongAnswer2,DefinitionFont,true)
    TestActivityDisplayDefinition(990,TestActivityTestTable[1+TestActivityScroll].WrongAnswer3Pos,910,200,TestActivityTestTable[1+TestActivityScroll].WrongAnswer3,DefinitionFont,true)
    N5Button(20, 120, 300, 80, true, 'TestActivityCheckAnswers()', true,BodyFontBold,"Check Answers")
    TestActivityScroll=N5ScrollBar(940,200,40,680,1,NumberOfTerms,TestActivityScroll,true)
    love.graphics.setColor(255,255,255)
end
function TestActivityDisplayDefinition(BoxX, Position, BoxW, BoxH, Text, TextFont, Scaling)
    if BoxX==nil or Position==nil or BoxW==nil or BoxH==nil or Text==nil or TextFont==nil or TestActivityTestTable==nil or TestActivityScroll==nil then
        print("In TestActivityDisplayDefinition() BoxX is reporting as: "..tostring(BoxX))
        print("In TestActivityDisplayDefinition() Position is reporting as: "..tostring(Position))
        print("In TestActivityDisplayDefinition() BoxW is reporting as: "..tostring(BoxW))
        print("In TestActivityDisplayDefinition() BoxH is reporting as: "..tostring(BoxH))
        print("In TestActivityDisplayDefinition() Text is reporting as: "..tostring(Text))
        print("In TestActivityDisplayDefinition() TextFont is reporting as: "..tostring(TextFont))
        print("In TestActivityDisplayDefinition() TestActivityTestTable is reporting as: "..tostring(TestActivityTestTable))
        print("In TestActivityDisplayDefinition() TestActivityScroll is reporting as: "..tostring(TestActivityScroll))
        return
    end
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
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
    end
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    if Selected or TestActivityTestTable[1+TestActivityScroll].SelectedAnswer==Position then
        if love.mouse.isDown(1)==true and TestActivityTestTable[1+TestActivityScroll].SelectedAnswer~=Position then
            TestActivityTestTable[1+TestActivityScroll].SelectedAnswer=Position
            love.graphics.setColor(255, 255, 255)
        end
        love.graphics.setColor(255, 255, 255)
    else
        love.graphics.setColor(180, 180, 180)
    end
    if Selected then
        love.graphics.setColor(200, 200, 200)  -- Lighter hover color
    end
    love.graphics.rectangle("fill", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setColor(0,0,0) -- black text
    local TH = TextFont:getHeight() * #Text / BoxW -- Estimate height based on wrapping
    local _, wrappedText = TextFont:getWrap(Text, BoxW)
    local wrappedHeight = #wrappedText * TextFont:getHeight()
    -- Coordinates for the text
    local textY = BoxY + (BoxH - wrappedHeight) / 2  -- Center the text vertically
    love.graphics.printf(Text, BoxX, textY, BoxW, "center")  -- Print wrapped and centered text
    love.graphics.setLineWidth(MediumLine)
    love.graphics.setColorF(0, 0, 0) -- black
    love.graphics.line( BoxX, BoxY+BoxH, BoxX+BoxW, BoxY+BoxH) -- horizontal bottom
    love.graphics.line( BoxX+BoxW, BoxY, BoxX+BoxW, BoxY+BoxH) -- vertical right
    love.graphics.setColorF(0, 0, 0) -- black
    love.graphics.setColorF(255, 255, 255) -- white
    love.graphics.line( BoxX, BoxY, BoxX+BoxW, BoxY) -- horizontal top
    love.graphics.line( BoxX, BoxY, BoxX, BoxY+BoxH) -- vertical left
    love.graphics.setColorF(255, 255, 255)
    love.graphics.setLineWidth(1)
end
function TestActivityCheckIfEnoughTerms()
    if NumberOfTerms<4 then
        SetStateMachine("Set Options")
        PopupCall = true
        PopupAction = 'StateMachine = "Set Options"; PopupCall=false'
        PopUpMessage = "Too few terms, 4 or more is needed"
        BackoutAction= 'PopupCall=false'
    end
end
function TestActivityCalculateHowManyHaveBeenAnswered()
    if TestActivityTestTable==nil then
        print("In TestActivityCalculateHowManyHaveBeenAnswered() TestActivityTestTable is reporting as: "..tostring(TestActivityTestTable))
        return
    end
    local AnsweredCount=0
    local TotalQuestions=#TestActivityTestTable
    for i=1, TotalQuestions do
        if TestActivityTestTable[i].SelectedAnswer~=0 then
            AnsweredCount=AnsweredCount+1
        end
    end
    return AnsweredCount, TotalQuestions
end
function TestActivityCheckAnswers()
    if TestActivityTestTable==nil then
        print("In TestActivityCheckAnswers() TestActivityTestTable is reporting as: "..tostring(TestActivityTestTable))
        return
    end
    local CorrectAnswers=0
    local TotalQuestions=#TestActivityTestTable
    for i=1, TotalQuestions do
        if TestActivityTestTable[i].SelectedAnswer==TestActivityTestTable[i].CorrectAnswerPos then
            CorrectAnswers=CorrectAnswers+1
        end
    end
    StateMachine="Set Options"
    SetStateMachine("Set Options")
    PopupCall = true
    PopupAction = 'StateMachine = "Set Options"; LoadTestActivity(); PopupCall=false'
    PopUpMessage = "You got: "..CorrectAnswers.."/"..TotalQuestions
    BackoutAction= 'PopupCall=false'
end