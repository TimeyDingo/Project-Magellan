function MissileDefenseActivity()
    SetTitle, SetData=LoadIndividualSet(SetToPreview)
    love.graphics.setLineWidth(MediumLine)
    MissileDefenseSurviveTimer=MissileDefenseSurviveTimer+love.timer.getDelta()
    if MissileDefenseSurviveTimer<0.1 then
        Sounds.MissileDefenseStart:play()
    end
    if Deleting==false then
        MissileDefenseDisplay()
        MissileDefenseDisplayChallenges()
        MissileDefenseResponse()
        local ChallengeFailedPassThrough=MissileDefenseCheckLives()
        if MissileDefenseCorrectResponses>4 then
            MissileDefenseCorrectResponses=0
            MissileDefenseSpeedFactor=MissileDefenseSpeedFactor+1
            MissileDefenseLevelUp=true
        end
        if MissileDefenseAChallengeFailed==true then
            if MissileDefenseChallengeFailedStep1Timer<1 then
                Sounds.MissileHit:play()
            end
            MissileDefenseChallengeFailedStep1Timer=MissileDefenseChallengeFailedStep1Timer+1
        end
        if MissileDefenseChallengeFailedStep1Timer>160 then
            MissileDefenseChallengeFailedStep2(ChallengeFailedPassThrough)
        end
        if MissileDefenseLivesRemaining<=0 then
            MissileDefenseFailed()
        end
    end
    if MissileDefenseLevelUp==true then
        MissileDefenseLevelUp1()
        MissileDefenseDisplay()
    end
    if MissileDefenseLevelUpTimer>2.5 then
        MissileDefenseLevelUp2()
    end
    love.graphics.setColor(0,0,0)
    CenterText(scaling(-296,1920,Settings.XRes),scaling(-440,1080,Settings.YRes),"Survived Time: "..string.format("%.1f",tostring(MissileDefenseSurviveTimer)),BodyFontBold)
    CenterText(scaling(-296,1920,Settings.XRes),scaling(-400,1080,Settings.YRes),"Lives Remaining: "..tostring(MissileDefenseLivesRemaining),BodyFontBold)
    CenterText(scaling(-296,1920,Settings.XRes),scaling(-360,1080,Settings.YRes),"Level: "..tostring(MissileDefenseSpeedFactor),BodyFontBold)
    love.graphics.setColor(255,255,255)
end
function MissileDefenseDisplayChallenges()
    local speedFactor=50
    if SetData==nil or MissileDefenseChallenges==nil or MissileDefenseChallengeCount==nil then
        print("In MissileDefenseDisplayChallenges() SetData is reporting as: "..tostring(SetData))
        print("In MissileDefenseDisplayChallenges() MissileDefenseChallenges is reporting as: "..tostring(MissileDefenseChallenges))
        print("In MissileDefenseDisplayChallenges() MissileDefenseChallengeCount is reporting as: "..tostring(MissileDefenseChallengeCount))
        return
    end
    local ChallengeQuestion=""
    local ChallengeAnswer=""
    local RandomChallenge=1
    if MissileDefenseTimer>3 then
        if MissileDefenseChallengeCount<3 then
            MissileDefenseChallengeCount=MissileDefenseChallengeCount+1
            RandomChallenge=math.random(1, #SetData)
            if RandomChallenge==nil then
                return
            end
            ChallengeQuestion=SetData[RandomChallenge][1]
            ChallengeAnswer=SetData[RandomChallenge][2]
            MissileDefenseChallenges[MissileDefenseChallengeCount].Challenge=ChallengeQuestion
            MissileDefenseChallenges[MissileDefenseChallengeCount].Answer=ChallengeAnswer
        end
        MissileDefenseTimer=0
    end
    if MissileDefenseChallengeCount>0 then
        MissileDefenseDisplayChallenge(1320,125,600,275,MissileDefenseChallenges[1].Challenge,true,MissileDefenseChallenge1Failed)
        if MissileDefenseChallenge1Failed==false then
            MissileDefenseChallenge1AccumulatedTime = MissileDefenseChallenge1AccumulatedTime + (love.timer.getDelta() * speedFactor)
            if MissileDefenseChallenge1AccumulatedTime >= 1 then
                MissileDefenseChallenges[1].IndividualTimer = MissileDefenseChallenges[1].IndividualTimer + MissileDefenseSpeedFactor
                if MissileDefenseChallenges[1].IndividualTimer % 20==0 then
                    local x = MissileDefenseChallenges[1].IncomingMissilePathingPoints[MissileDefenseChallenges[1].IndividualTimer+1][1]
                    local y = MissileDefenseChallenges[1].IncomingMissilePathingPoints[MissileDefenseChallenges[1].IndividualTimer+1][2]
                    table.insert(MissileDefenseChallenges[1].TrailPoints, x)
                    table.insert(MissileDefenseChallenges[1].TrailPoints, y)
                end
                MissileDefenseChallenge1AccumulatedTime = MissileDefenseChallenge1AccumulatedTime - 1  -- Keep any leftover time for the next frame
            end
        end
        MissileDefenseTimerDisplay(1320,85+ThickLine,40-ThickLine,true,1)
    end
    if MissileDefenseChallengeCount>1 then
        MissileDefenseDisplayChallenge(1320,440,600,300,MissileDefenseChallenges[2].Challenge,true,MissileDefenseChallenge2Failed)
        if MissileDefenseChallenge2Failed==false then
            MissileDefenseChallenge2AccumulatedTime = MissileDefenseChallenge2AccumulatedTime + (love.timer.getDelta() * speedFactor)
            if MissileDefenseChallenge2AccumulatedTime >= 1 then
                MissileDefenseChallenges[2].IndividualTimer = MissileDefenseChallenges[2].IndividualTimer + MissileDefenseSpeedFactor
                if MissileDefenseChallenges[2].IndividualTimer % 20==0 then
                    local x = MissileDefenseChallenges[2].IncomingMissilePathingPoints[MissileDefenseChallenges[2].IndividualTimer+1][1]
                    local y = MissileDefenseChallenges[2].IncomingMissilePathingPoints[MissileDefenseChallenges[2].IndividualTimer+1][2]
                    table.insert(MissileDefenseChallenges[2].TrailPoints, x)
                    table.insert(MissileDefenseChallenges[2].TrailPoints, y)
                end
                MissileDefenseChallenge2AccumulatedTime = MissileDefenseChallenge2AccumulatedTime - 1  -- Keep any leftover time for the next frame
            end
        end
        MissileDefenseTimerDisplay(1320,400+ThickLine,40-ThickLine,true,2)
    end
    if MissileDefenseChallengeCount>2 then
        MissileDefenseDisplayChallenge(1320,780,600,300,MissileDefenseChallenges[3].Challenge,true,MissileDefenseChallenge3Failed)
        if MissileDefenseChallenge3Failed==false then
            MissileDefenseChallenge3AccumulatedTime = MissileDefenseChallenge3AccumulatedTime + (love.timer.getDelta() * speedFactor)
            if MissileDefenseChallenge3AccumulatedTime >= 1 then
                MissileDefenseChallenges[3].IndividualTimer = MissileDefenseChallenges[3].IndividualTimer + MissileDefenseSpeedFactor
                
                if MissileDefenseChallenges[3].IndividualTimer % 20==0 then
                    local x = MissileDefenseChallenges[3].IncomingMissilePathingPoints[MissileDefenseChallenges[3].IndividualTimer+1][1]
                    local y = MissileDefenseChallenges[3].IncomingMissilePathingPoints[MissileDefenseChallenges[3].IndividualTimer+1][2]
                    table.insert(MissileDefenseChallenges[3].TrailPoints, x)
                    table.insert(MissileDefenseChallenges[3].TrailPoints, y)
                end

                MissileDefenseChallenge3AccumulatedTime = MissileDefenseChallenge3AccumulatedTime - 1  -- Keep any leftover time for the next frame
            end
        end
        MissileDefenseTimerDisplay(1320,740+ThickLine,40-ThickLine,true,3)
    end
end
function MissileDefenseResponse()
    if MissileDefenseTypedResponse==nil then
        print("In MissileDefenseResponse() MissileDefenseTypedResponse is reporting as: "..tostring(MissileDefenseTypedResponse))
        return
    end
    local TextFont=SmallHeaderBold
    love.graphics.setFont(TextFont)
    local BoxX=0
    local BoxY=930
    local BoxW=1320
    local BoxH=140
    local Scaling=true
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
    end
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("fill", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setColor(0, 0, 0)
    function love.textinput(t)
        MissileDefenseTypedResponse=MissileDefenseTypedResponse..t
    end
    MissileDefenseTypedResponse=BackspaceController(MissileDefenseTypedResponse,0.5,0.1)
    Text=MissileDefenseTypedResponse
    local TH = TextFont:getHeight() * #Text / BoxW -- Estimate height based on wrapping
    local _, wrappedText = TextFont:getWrap(Text, BoxW)
    local wrappedHeight = #wrappedText * TextFont:getHeight()
    -- Coordinates for the text
    local textY = BoxY + (BoxH - wrappedHeight) / 2  -- Center the text vertically
    love.graphics.printf(Text, BoxX, textY, BoxW, "center")  -- Print wrapped and centered text
    love.graphics.setLineWidth(MediumLine)
    love.graphics.setColorF(255, 255, 255) -- white
    love.graphics.line( BoxX, BoxY+BoxH, BoxX+BoxW, BoxY+BoxH) -- horizontal bottom
    love.graphics.line( BoxX+BoxW, BoxY, BoxX+BoxW, BoxY+BoxH) -- vertical right
    love.graphics.setColorF(0, 0, 0) -- black
    love.graphics.line( BoxX, BoxY, BoxX+BoxW, BoxY) -- horizontal top
    love.graphics.line( BoxX, BoxY, BoxX, BoxY+BoxH) -- vertical left
    love.graphics.setColorF(255, 255, 255)
    love.graphics.setLineWidth(1)
    if ButtonDebounce("return", 0.5) then
        MissileDefenseCheckResponse()
        MissileDefenseTypedResponse=""
    end
end
function MissileDefenseDisplay()
    if MissileDefenseChallenges==nil or TerrainPoints==nil then
        print("In MissileDefenseDisplay() MissileDefenseChallenges is reporting as: "..tostring(MissileDefenseChallenges))
        print("In MissileDefenseDisplay() TerrainPoints is reporting as: "..tostring(TerrainPoints))
        return
    end
    local LargePoint=10
    local TrailingPoint=2
    N5BoxHighlight(0, 88, 1320, 825, true, {200,200,200}, true)
    love.graphics.setColor(0,0,0)--terain color
    --? Terrain
    local flattenedPoints = {}
    for _, TerrainPoints in ipairs(TerrainPoints) do
        table.insert(flattenedPoints, TerrainPoints[1])
        table.insert(flattenedPoints, TerrainPoints[2])
    end
    love.graphics.polygon('line', unpack(flattenedPoints))
    --?
    --? inbound missiles
    if MissileDefenseLevelUp==false then
        if MissileDefenseChallenges[1].IndividualTimer>0 then
            --missile 1
            love.graphics.setPointSize(LargePoint)
            love.graphics.setColor(MissileDefenseChallenges[1].IncomingMissileRGB[1],MissileDefenseChallenges[1].IncomingMissileRGB[2],MissileDefenseChallenges[1].IncomingMissileRGB[3],255)
            love.graphics.points(MissileDefenseChallenges[1].IncomingMissilePathingPoints[MissileDefenseChallenges[1].IndividualTimer+1][1],MissileDefenseChallenges[1].IncomingMissilePathingPoints[MissileDefenseChallenges[1].IndividualTimer+1][2])
            love.graphics.setPointSize(TrailingPoint)
            love.graphics.points(MissileDefenseChallenges[1].TrailPoints)
            love.graphics.setColor(255,255,255)
            if MissileDefenseChallenges[1].IndividualTimer<5 then
                Sounds.MissileIncoming:play()
            end
        end
        if MissileDefenseChallenges[2].IndividualTimer>0 then
            love.graphics.setPointSize(LargePoint)
            love.graphics.setColor(MissileDefenseChallenges[2].IncomingMissileRGB[1],MissileDefenseChallenges[2].IncomingMissileRGB[2],MissileDefenseChallenges[2].IncomingMissileRGB[3],255)
            love.graphics.points(MissileDefenseChallenges[2].IncomingMissilePathingPoints[MissileDefenseChallenges[2].IndividualTimer+1][1], MissileDefenseChallenges[2].IncomingMissilePathingPoints[MissileDefenseChallenges[2].IndividualTimer+1][2])
            love.graphics.setPointSize(TrailingPoint)
            love.graphics.points(MissileDefenseChallenges[2].TrailPoints)
            love.graphics.setColor(255,255,255)
            if MissileDefenseChallenges[2].IndividualTimer<5 then
                Sounds.MissileIncoming:play()
            end
        end
        if MissileDefenseChallenges[3].IndividualTimer>0 then
            love.graphics.setPointSize(LargePoint)
            love.graphics.setColor(MissileDefenseChallenges[3].IncomingMissileRGB[1],MissileDefenseChallenges[3].IncomingMissileRGB[2],MissileDefenseChallenges[3].IncomingMissileRGB[3],255)
            love.graphics.points(MissileDefenseChallenges[3].IncomingMissilePathingPoints[MissileDefenseChallenges[3].IndividualTimer+1][1], MissileDefenseChallenges[3].IncomingMissilePathingPoints[MissileDefenseChallenges[3].IndividualTimer+1][2])
            love.graphics.setPointSize(TrailingPoint)
            love.graphics.points(MissileDefenseChallenges[3].TrailPoints)
            love.graphics.setColor(255,255,255)
            if MissileDefenseChallenges[3].IndividualTimer<5 then
                Sounds.MissileIncoming:play()
            end
        end
    end
    love.graphics.setPointSize(1)
    --??
end
function MissileDefenseDisplayChallenge(BoxX, BoxY, BoxW, BoxH, Text, Scaling, Failed)
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil or Text==nil or Failed==nil then
        print("In MissileDefenseDisplayChallenge() BoxX is reporting as: "..tostring(BoxX))
        print("In MissileDefenseDisplayChallenge() BoxY is reporting as: "..tostring(BoxY))
        print("In MissileDefenseDisplayChallenge() BoxW is reporting as: "..tostring(BoxW))
        print("In MissileDefenseDisplayChallenge() BoxH is reporting as: "..tostring(BoxH))
        print("In MissileDefenseDisplayChallenge() Text is reporting as: "..tostring(Text))
        print("In MissileDefenseDisplayChallenge() Failed is reporting as: "..tostring(Failed))
        return
    end
    local InitialFont=LargeBodyFont
    local newSize=28
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
    end
    local BoxR,BoxG,BoxB=255,153,0
    if Failed==true then
        Text="FAILED"
        BoxR,BoxG,BoxB=215,54,64
    else
        BoxR,BoxG,BoxB=200,200,200
    end
        love.graphics.setColor(BoxR,BoxG,BoxB)
        love.graphics.rectangle("fill", BoxX, BoxY, BoxW, BoxH)
        love.graphics.setColor(0,0,0)--text color
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
        love.graphics.setColorF(255, 255, 255) -- white
        love.graphics.line( BoxX, BoxY+BoxH, BoxX+BoxW, BoxY+BoxH) -- horizontal bottom
        love.graphics.line( BoxX+BoxW, BoxY, BoxX+BoxW, BoxY+BoxH) -- vertical right
        love.graphics.setColorF(0, 0, 0) -- black
        love.graphics.line( BoxX, BoxY, BoxX+BoxW, BoxY) -- horizontal top
        love.graphics.line( BoxX, BoxY, BoxX, BoxY+BoxH) -- vertical left
        love.graphics.setColorF(255, 255, 255)
        love.graphics.setLineWidth(1)

end
function MissileDefenseCheckResponse()
    if MissileDefenseTypedResponse==nil or MissileDefenseChallengeCount==nil or MissileDefenseChallenges==nil then
        print("In MissileDefenseCheckResponse() MissileDefenseTypedResponse is reporting as: "..tostring(MissileDefenseTypedResponse))
        print("In MissileDefenseCheckResponse() MissileDefenseChallengeCount is reporting as: "..tostring(MissileDefenseChallengeCount))
        print("In MissileDefenseCheckResponse() MissileDefenseChallenges is reporting as: "..tostring(MissileDefenseChallenges))
        return
    end
    Deleting=true
    local LowerCaseResponse=trim(string.lower(MissileDefenseTypedResponse))
    if MissileDefenseChallengeCount>0 then
        if LowerCaseResponse==trim(string.lower(MissileDefenseChallenges[1].Answer)) then
            Sounds.MissileDestroyed:play()
            MissileDefenseCorrectResponses=MissileDefenseCorrectResponses+1
            MissileDefenseChallengeCount=MissileDefenseChallengeCount-1
            local TransferTable=MissileDefenseChallenges[1].IncomingMissilePathingPoints
            local RGBTransfer=MissileDefenseChallenges[1].IncomingMissileRGB
            table.remove(MissileDefenseChallenges, 1)
            table.insert(MissileDefenseChallenges, {Challenge="",Answer="",IndividualTimer=0,IncomingMissilePathingPoints=TransferTable,IncomingMissileRGB=RGBTransfer,TrailPoints={0,0}})
        end
    end
    if MissileDefenseChallengeCount>1 then
        if LowerCaseResponse==trim(string.lower(MissileDefenseChallenges[2].Answer)) then
            Sounds.MissileDestroyed:play()
            MissileDefenseCorrectResponses=MissileDefenseCorrectResponses+1
            MissileDefenseChallengeCount=MissileDefenseChallengeCount-1
            local TransferTable=MissileDefenseChallenges[2].IncomingMissilePathingPoints
            local RGBTransfer=MissileDefenseChallenges[1].IncomingMissileRGB
            table.remove(MissileDefenseChallenges, 2)
            table.insert(MissileDefenseChallenges, {Challenge="",Answer="",IndividualTimer=0,IncomingMissilePathingPoints=TransferTable,IncomingMissileRGB=RGBTransfer,TrailPoints={0,0}})
        end
    end
    if MissileDefenseChallengeCount>2 then
        if LowerCaseResponse==trim(string.lower(MissileDefenseChallenges[3].Answer)) then
            Sounds.MissileDestroyed:play()
            MissileDefenseCorrectResponses=MissileDefenseCorrectResponses+1
            MissileDefenseChallengeCount=MissileDefenseChallengeCount-1
            local TransferTable=MissileDefenseChallenges[3].IncomingMissilePathingPoints
            local RGBTransfer=MissileDefenseChallenges[1].IncomingMissileRGB
            table.remove(MissileDefenseChallenges, 3)
            table.insert(MissileDefenseChallenges, {Challenge="",Answer="",IndividualTimer=0,IncomingMissilePathingPoints=TransferTable,IncomingMissileRGB=RGBTransfer,TrailPoints={0,0}})
        end
    end
    Deleting=false
end
function MissileDefenseCheckLives()
    if MissileDefenseChallenges==nil then
        print("In MissileDefenseCheckLives() MissileDefenseChallenges is reporting as: "..tostring(MissileDefenseChallenges))
        return
    end
    local ReturnValue=0
    if MissileDefenseChallenges[1].IndividualTimer>600 then
        ReturnValue=MissileDefenseChallengeFailedStep1(1)
    end
    if MissileDefenseChallenges[2].IndividualTimer>600 then
        ReturnValue=MissileDefenseChallengeFailedStep1(2)
    end
    if MissileDefenseChallenges[3].IndividualTimer>600 then
        ReturnValue=MissileDefenseChallengeFailedStep1(3)
    end
    return ReturnValue
end
function MissileDefenseChallengeFailedStep1(ChallengeThatWasFailed)
    if ChallengeThatWasFailed==nil then
        print("In MissileDefenseChallengeFailedStep1() ChallengeThatWasFailed is reporting as: "..tostring(ChallengeThatWasFailed))
        return
    end
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
    if ChallengeThatWasFailed<1 or MissileDefenseChallenges==nil or MissileDefenseChallengeCount==nil then
        print("In MissileDefenseChallengeFailedStep2() ChallengeThatWasFailed is reporting as: "..tostring(ChallengeThatWasFailed))
        print("In MissileDefenseChallengeFailedStep2() MissileDefenseChallenges is reporting as: "..tostring(MissileDefenseChallenges))
        print("In MissileDefenseChallengeFailedStep2() MissileDefenseChallengeCount is reporting as: "..tostring(MissileDefenseChallengeCount))
        return
    end
    Deleting=true
    MissileDefenseChallengeCount=MissileDefenseChallengeCount-1
    local TransferTable=MissileDefenseChallenges[ChallengeThatWasFailed].IncomingMissilePathingPoints
    local RGBTransfer=MissileDefenseChallenges[1].IncomingMissileRGB
    table.remove(MissileDefenseChallenges, ChallengeThatWasFailed)
    table.insert(MissileDefenseChallenges, {Challenge="",Answer="",IndividualTimer=0,IncomingMissilePathingPoints=TransferTable,IncomingMissileRGB=RGBTransfer, TrailPoints={0,0}})
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
    MissileDefenseLivesRemaining=MissileDefenseLivesRemaining-1
end
function MissileDefenseFailed()
    StateMachine="Set Options"
    PopupCall = true
    Sounds.GameEnd:play()
    PopupAction = 'StateMachine = "Missile Defense"; LoadMissileDefense(); PopupCall=false'
    PopUpMessage = "You Failed, Survived: "..string.format("%.1f",tostring(MissileDefenseSurviveTimer))
    BackoutAction= 'PopupCall=false'
end
function MissileDefenseTimerDisplay(BoxX,BoxY,BoxH,Scaling,Challenge)
    local Time=MissileDefenseChallenges[Challenge].IndividualTimer
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        Time=scaling(Time,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
    end
    local StartColor = {r = 132, g = 195, b = 24}
    local TargetColor = {r = 215, g = 54, b = 64}
    local color = SmudgeColor(StartColor, TargetColor, (Time/600)*2)
    love.graphics.setColor(color.r, color.g, color.b)
    love.graphics.rectangle("fill",BoxX,BoxY,Time,BoxH)
    love.graphics.setColor(255,255,255)
end
function MissileDefenseLevelUp1()
    local TerrainMinY=scaling(915,1920,Settings.XRes)
    CenterText(scaling(-296,1920,Settings.XRes),scaling(-300,1080,Settings.YRes),"Next Level",LargeHeader)
    Deleting=true
    table.remove(MissileDefenseChallenges,3)
    table.remove(MissileDefenseChallenges,2)
    table.remove(MissileDefenseChallenges,1)
    MissileDefenseLevelUpTimer=MissileDefenseLevelUpTimer+love.timer.getDelta()
end
function MissileDefenseLevelUp2()
    local TerrainMinY=scaling(915,1920,Settings.XRes)
    CenterText(scaling(-296,1920,Settings.XRes),scaling(-300,1080,Settings.YRes),"Next Level",LargeHeader)
    Deleting=true
    table.remove(MissileDefenseChallenges,3)
    table.remove(MissileDefenseChallenges,2)
    table.remove(MissileDefenseChallenges,1)
    local RGB3={255, 38, 179}
    local RGB2={248, 255, 38}
    local RGB1={255, 43, 28}
    local Points1=GenerateMissilePoints(scaling(196,1920, Settings.XRes), scaling(65,1080, Settings.YRes), scaling(664,1920, Settings.XRes), TerrainMinY-scaling(200,1080,Settings.YRes), 600)
    local Points2=GenerateMissilePoints(scaling(664,1920, Settings.XRes), scaling(65,1080, Settings.YRes), scaling(664,1920, Settings.XRes), TerrainMinY-scaling(200,1080,Settings.YRes), 600)
    local Points3=GenerateMissilePoints(scaling(1132,1920, Settings.XRes), scaling(65,1080, Settings.YRes), scaling(664,1920, Settings.XRes), TerrainMinY-scaling(200,1080,Settings.YRes), 600)
    table.insert(MissileDefenseChallenges,{Challenge="",Answer="",IndividualTimer=0,IncomingMissilePathingPoints=Points1,IncomingMissileRGB=RGB1,TrailPoints={0,0}})
    table.insert(MissileDefenseChallenges,{Challenge="",Answer="",IndividualTimer=0,IncomingMissilePathingPoints=Points2,IncomingMissileRGB=RGB2,TrailPoints={0,0}})
    table.insert(MissileDefenseChallenges,{Challenge="",Answer="",IndividualTimer=0,IncomingMissilePathingPoints=Points3,IncomingMissileRGB=RGB3,TrailPoints={0,0}})
    Deleting=false
    MissileDefenseLevelUp=false
    MissileDefenseLevelUpTimer=0
end