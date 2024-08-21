function MissileDefenseActivity()
    SetTitle, SetData=LoadIndividualSet(SetToPreview)
    love.graphics.setLineWidth(MediumLine)
    MissileDefenseDisplay()
    MissileDefenseDisplayChallenges()
    MissileDefenseResponse()
end
function MissileDefenseDisplayChallenges()
    CenterText(0,0,MissileDefenseTimer,Exo24)
    local ChallengeQuestion
    if MissileDefenseTimer>200 then
        if MissileDefenseChallengeCount<3 then
            MissileDefenseChallengeCount=MissileDefenseChallengeCount+1
            ChallengeQuestion=SetData[math.random(1, #SetData)][1]
            MissileDefenseChallenges[MissileDefenseChallengeCount]=ChallengeQuestion
        end
        MissileDefenseTimer=0
    end
    if MissileDefenseChallengeCount>0 then
        DisplayChallenge(1320,65,600,300,MissileDefenseChallenges[1],true)
    end
    if MissileDefenseChallengeCount>1 then
        DisplayChallenge(1320,415,600,300,MissileDefenseChallenges[2],true)
    end
    if MissileDefenseChallengeCount>2 then
        DisplayChallenge(1320,765,600,300,MissileDefenseChallenges[3],true)
    end
end
function MissileDefenseResponse()--!! add manual button to confirm response and enter button to also confirm
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
end
function DisplayChallenge(BoxX, BoxY, BoxW, BoxH, Text, Scaling)
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