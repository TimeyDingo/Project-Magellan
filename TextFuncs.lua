function TextBox(X,Y,Text,TextFont,Alignment,SoftCorners,backgroundR,backgroundG,backgroundB,TextR,TextG,TextB,PaddingLR,PaddingUD,OverRidePadding,OverrideX,OverrideY,Selected)
    love.graphics.setFont(TextFont)
    local TW=0
    local TH=0
    if OverRidePadding=="false" then
        TW=TextFont:getWidth(Text)
        TH=TextFont:getHeight(Text)
    end
    if OverRidePadding=="true" then
        TW=OverrideX
        TH=OverrideY
    end
    if Alignment=="left" then
        AlignmentFactor=PaddingLR/-2
        --add alignments, add padding amounts on each side to the box
    end
    if Alignment=="right" then
        AlignmentFactor=PaddingLR/2
    end
    if Alignment=="center" then
        AlignmentFactor=0
    end
    if SoftCorners=="true" then
        local rx=5
        local ry=5
    else if SoftCorners=="false" then
        local rx=0
        local ry=0
    end
    end
    love.graphics.setColor(backgroundR,backgroundG,backgroundB)
    love.graphics.rectangle("fill",X+((W-TW-PaddingLR)/2),Y+((H-TH-PaddingUD)/2),TW+PaddingLR,TH+PaddingUD,rx,ry)
    love.graphics.setColor(TextR,TextG,TextB)
    love.graphics.print(Text,(((W-TW-PaddingLR)/2)+X+PaddingLR/2)+AlignmentFactor,((H-TH+PaddingUD)/2)+Y-PaddingUD/2)
    local TopLeftX=X+((W-TW-PaddingLR)/2)
    local TopLeftY=Y+((H-TH-PaddingUD)/2)
    local BottomRightX=(X+((W-TW-PaddingLR)/2))+TW+PaddingLR
    local BottomRightY=(Y+((H-TH-PaddingUD)/2))+TH+PaddingUD
    if Selected==true then
        love.graphics.setColor(backgroundR,backgroundG,backgroundB)
        love.graphics.setLineWidth(3)
        love.graphics.rectangle("line",TopLeftX-10,TopLeftY-10,BottomRightX+20-TopLeftX,BottomRightY+20-TopLeftY)
    end
    return TopLeftX,TopLeftY,BottomRightX,BottomRightY
end
function CenterText(X,Y,Text,TextFont)
    love.graphics.setFont(TextFont)
    local TW=TextFont:getWidth(Text)
    local TH=TextFont:getHeight(Text)
    love.graphics.print(Text,((W-TW)/2)+X,((H-TH)/2)+Y)--Screen Width minus text width divided by 2 + change in x
end
function MapNumber(Number,InMin,InMax,OutMin,OutMax)
    local Map = (Number - InMin) / (InMax - InMin) * (OutMax - OutMin) + OutMin
    return Map
end
