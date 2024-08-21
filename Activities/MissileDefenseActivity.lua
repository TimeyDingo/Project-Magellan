function MissileDefenseActivity()
    
    love.graphics.setLineWidth(MediumLine)
    MissileDefenseDisplay()
    MissileDefenseDisplayChallenges()
    MissileDefenseResponse()
end
function MissileDefenseDisplayChallenges()
    ButtonStyle1(1320,65,600,300,"Challenge 1",Exo24,true)
    ButtonStyle1(1320,415,600,300,"Challenge 2",Exo24,true)
    ButtonStyle1(1320,765,600,300,"Challenge 3",Exo24,true)
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
end
function MissileDefenseDisplay()
    love.graphics.setColor(255,153,0)
    love.graphics.rectangle("line", 0, scaling(65,1080, Settings[2]), scaling(1320, 1920, Settings[1]), scaling(850, 1080, Settings[2]))
    love.graphics.setColor(255,255,255)
    local flattenedPoints = {}
    for _, TerrainPoints in ipairs(TerrainPoints) do
        table.insert(flattenedPoints, TerrainPoints[1])
        table.insert(flattenedPoints, TerrainPoints[2])
    end
    -- Draw the polygon
    love.graphics.polygon('line', unpack(flattenedPoints))
end