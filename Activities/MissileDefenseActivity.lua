function MissileDefenseActivity()
    SetTitle, SetData=LoadIndividualSet(SetToPreview)
    love.graphics.setLineWidth(MediumLine)
    MissileDefenseSurviveTimer=MissileDefenseSurviveTimer+1
    CenterText(scaling(-296,1920,Settings[1]),scaling(-450,1080,Settings[2]),"Survived Time: "..string.format("%.1f",tostring(MissileDefenseSurviveTimer/60)),Exo24Bold)
    CenterText(scaling(-296,1920,Settings[1]),scaling(-410,1080,Settings[2]),"Lives Remaining: "..tostring(MissileDefenseLivesRemaining),Exo24Bold)
    if Deleting==false then
        MissileDefenseDisplay()
        MissileDefenseDisplayChallenges()
        MissileDefenseResponse()
        local ChallengeFailedPassThrough=MissileDefenseCheckLives()
        if MissileDefenseAChallengeFailed==true then
            MissileDefenseChallengeFailedStep1Timer=MissileDefenseChallengeFailedStep1Timer+1
        end
        if MissileDefenseChallengeFailedStep1Timer>160 then
            MissileDefenseChallengeFailedStep2(ChallengeFailedPassThrough)
        end
        if MissileDefenseLivesRemaining<=0 then
            MissileDefenseFailed()
        end
    end
end
function MissileDefenseDisplayChallenges()
    local ChallengeQuestion=""
    local ChallengeAnswer=""
    local RandomChallenge=1
    if MissileDefenseTimer>200 then
        if MissileDefenseChallengeCount<3 then
            MissileDefenseChallengeCount=MissileDefenseChallengeCount+1
            RandomChallenge=math.random(1, #SetData)
            if RandomChallenge==nil then
                return
            end
            ChallengeQuestion=SetData[RandomChallenge][1]
            ChallengeAnswer=SetData[RandomChallenge][2]
            MissileDefenseChallenges[MissileDefenseChallengeCount][1]=ChallengeQuestion
            MissileDefenseChallenges[MissileDefenseChallengeCount][2]=ChallengeAnswer
        end
        MissileDefenseTimer=0
    end
    if MissileDefenseChallengeCount>0 then
        MissileDefenseDisplayChallenge(1320,65,600,300,MissileDefenseChallenges[1][1],true,MissileDefenseChallenge1Failed)
        if MissileDefenseChallenge1Failed==false then
            MissileDefenseChallenges[1][3]=MissileDefenseChallenges[1][3]+1
        end
        CenterText(100,-100,"First: "..MissileDefenseChallenges[1][3],Exo24)
    end
    if MissileDefenseChallengeCount>1 then
        MissileDefenseDisplayChallenge(1320,415,600,300,MissileDefenseChallenges[2][1],true,MissileDefenseChallenge2Failed)
        if MissileDefenseChallenge2Failed==false then
            MissileDefenseChallenges[2][3]=MissileDefenseChallenges[2][3]+1
        end
        CenterText(100,0,"Second: "..MissileDefenseChallenges[2][3],Exo24)
    end
    if MissileDefenseChallengeCount>2 then
        MissileDefenseDisplayChallenge(1320,765,600,300,MissileDefenseChallenges[3][1],true,MissileDefenseChallenge3Failed)
        if MissileDefenseChallenge3Failed==false then
            MissileDefenseChallenges[3][3]=MissileDefenseChallenges[3][3]+1 --update timer that its been on screen
        end
        CenterText(100,100,"Third: "..MissileDefenseChallenges[3][3],Exo24)
    end
end
function MissileDefenseResponse()
    local TextFont=Exo32Bold
    love.graphics.setFont(TextFont)
    local BoxX=0
    local BoxY=915
    local BoxW=1320
    local BoxH=165
    local Scaling=true
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings[1])
        BoxY=scaling(BoxY,1080,Settings[2])
        BoxW=scaling(BoxW,1920,Settings[1])
        BoxH=scaling(BoxH,1080,Settings[2])
    end
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    love.graphics.setColor(255, 255, 255)
    function love.textinput(t)
        MissileDefenseTypedResponse=MissileDefenseTypedResponse..t
    end
    MissileDefenseTypedResponse=BackspaceController(MissileDefenseTypedResponse,30)
    Text=MissileDefenseTypedResponse
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
    if ButtonDebounce("return", 30) then
        MissileDefenseCheckResponse()
        MissileDefenseTypedResponse=""
    end
end
function MissileDefenseDisplay()
    love.graphics.setColor(255,153,0)
    love.graphics.rectangle("line", 0, scaling(65,1080, Settings[2]), scaling(1320, 1920, Settings[1]), scaling(850, 1080, Settings[2]))
    love.graphics.setColor(255,255,255)
    --? Terrain
    local flattenedPoints = {}
    for _, TerrainPoints in ipairs(TerrainPoints) do
        table.insert(flattenedPoints, TerrainPoints[1])
        table.insert(flattenedPoints, TerrainPoints[2])
    end
    love.graphics.polygon('line', unpack(flattenedPoints))
    --?
    --? inbound missiles
    if MissileDefenseChallengeCount>0 then
        --missile 1
        love.graphics.setColor(255,0,0,255)
        love.graphics.points(Missile1Points[MissileDefenseChallenges[1][3]+1][1], Missile1Points[MissileDefenseChallenges[1][3]+1][2])
        love.graphics.setColor(255,255,255)
    end
    if MissileDefenseChallengeCount>1 then
        love.graphics.setColor(0,255,0,255)
        love.graphics.points(Missile2Points[MissileDefenseChallenges[2][3]+1][1], Missile2Points[MissileDefenseChallenges[2][3]+1][2])
        love.graphics.setColor(255,255,255)
    end
    if MissileDefenseChallengeCount>2 then
        love.graphics.setColor(0,0,255,255)
        love.graphics.points(Missile3Points[MissileDefenseChallenges[3][3]+1][1], Missile3Points[MissileDefenseChallenges[3][3]+1][2])
        love.graphics.setColor(255,255,255)
    end
    --??
end
function MissileDefenseDisplayChallenge(BoxX, BoxY, BoxW, BoxH, Text, Scaling, Failed)
    if Failed==false then
        local InitialFont=Exo28
        local newSize=28
        if Scaling==true then
            BoxX=scaling(BoxX,1920,Settings[1])
            BoxY=scaling(BoxY,1080,Settings[2])
            BoxW=scaling(BoxW,1920,Settings[1])
            BoxH=scaling(BoxH,1080,Settings[2])
        end
        local function getWrappedHeight(font, text, width)
            local _, wrappedText = font:getWrap(text, width)
            return #wrappedText * font:getHeight()
        end
        
        while getWrappedHeight(InitialFont, Text, BoxW) > BoxH do
            -- Reduce the font size
            newSize = newSize - 2  -- Reduce by 10% or adjust as needed
            InitialFont = love.graphics.newFont("Fonts/Exo2.ttf", newSize)
        end
        love.graphics.setFont(InitialFont)
        local TH = InitialFont:getHeight() * #Text / BoxW -- Estimate height based on wrapping
        local _, wrappedText = InitialFont:getWrap(Text, BoxW)
        local wrappedHeight = #wrappedText * InitialFont:getHeight()
        -- Coordinates for the text
        local textY = BoxY + (BoxH - wrappedHeight) / 2  -- Center the text vertically
        
        love.graphics.printf(Text, BoxX, textY, BoxW, "center")  -- Print wrapped and centered text
        love.graphics.setLineWidth(MediumLine)
        love.graphics.setColor(255, 153, 0)
        love.graphics.rectangle("line", BoxX, BoxY, BoxW, BoxH)
        love.graphics.setLineWidth(ThinLine)
        love.graphics.setColor(255, 255, 255)
    end
    if Failed==true then
        CenterText(300,0,"ChallengeFailed",Exo32Bold)
    end
end
function MissileDefenseCheckResponse()
    Deleting=true
    local LowerCaseResponse=string.lower(MissileDefenseTypedResponse)
    --MissileDefenseTypedResponse
    if MissileDefenseChallengeCount>0 then
        if LowerCaseResponse==string.lower(MissileDefenseChallenges[1][2]) then
            MissileDefenseChallengeCount=MissileDefenseChallengeCount-1
            table.remove(MissileDefenseChallenges, 1)
            table.insert(MissileDefenseChallenges, {"","",0})
        end
    end
    if MissileDefenseChallengeCount>1 then
        if LowerCaseResponse==string.lower(MissileDefenseChallenges[2][2]) then
            MissileDefenseChallengeCount=MissileDefenseChallengeCount-1
            table.remove(MissileDefenseChallenges, 2)
            table.insert(MissileDefenseChallenges, {"","",0})
        end
    end
    if MissileDefenseChallengeCount>2 then
        if LowerCaseResponse==string.lower(MissileDefenseChallenges[3][2]) then
            MissileDefenseChallengeCount=MissileDefenseChallengeCount-1
            table.remove(MissileDefenseChallenges, 3)
            table.insert(MissileDefenseChallenges, {"","",0})
        end
    end
    Deleting=false
end
function MissileDefenseCheckLives()
    local ReturnValue=0
    if MissileDefenseChallenges[1][3]>600 then
        ReturnValue=MissileDefenseChallengeFailedStep1(1)
    end
    if MissileDefenseChallenges[2][3]>600 then
        ReturnValue=MissileDefenseChallengeFailedStep1(2)
    end
    if MissileDefenseChallenges[3][3]>600 then
        ReturnValue=MissileDefenseChallengeFailedStep1(3)
    end
    return ReturnValue
end
function MissileDefenseChallengeFailedStep1(ChallengeThatWasFailed)
    if ChallengeThatWasFailed==1 then
        MissileDefenseChallenge1Failed=true
        MissileDefenseAChallengeFailed=true
    end
    if ChallengeThatWasFailed==2 then
        MissileDefenseChallenge2Failed=true
        MissileDefenseAChallengeFailed=true
    end
    if ChallengeThatWasFailed==3 then
        MissileDefenseChallenge3Failed=true
        MissileDefenseAChallengeFailed=true
    end
    return ChallengeThatWasFailed
end
function MissileDefenseChallengeFailedStep2(ChallengeThatWasFailed)
    Deleting=true
    MissileDefenseChallengeCount=MissileDefenseChallengeCount-1
    table.remove(MissileDefenseChallenges, ChallengeThatWasFailed)
    table.insert(MissileDefenseChallenges, {"","",0})
    Deleting=false
    if ChallengeThatWasFailed==1 then
        MissileDefenseChallenge1Failed=false
    end
    if ChallengeThatWasFailed==2 then
        MissileDefenseChallenge2Failed=false
    end
    if ChallengeThatWasFailed==3 then
        MissileDefenseChallenge3Failed=false
    end
    MissileDefenseChallengeFailedStep1Timer=0
    MissileDefenseAChallengeFailed=false
    MissileDefenseChallenges[ChallengeThatWasFailed][3]=0
    MissileDefenseLivesRemaining=MissileDefenseLivesRemaining-1
end
function MissileDefenseFailed()
    StateMachine="Set Options"
    PopupCall = true
    PopupAction = 'StateMachine = "Missile Defense"; LoadMissileDefense(); PopupCall=false'
    PopUpMessage = "You Failed, Survived: "..string.format("%.1f",tostring(MissileDefenseSurviveTimer/60))
    BackoutAction= 'PopupCall=false'
end