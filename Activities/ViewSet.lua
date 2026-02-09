function ViewActivity()
    --SetTitle, SetData = LUASetRead(SetToPreview)
    SetData = LUASetRead(SetToPreview)
    if SetData==nil or ViewActivityScroll==nil then
        print("In ViewActivity() SetData is reporting as: "..tostring(SetData))
        print("In ViewActivity() ViewActivityScroll is reporting as: "..tostring(ViewActivityScroll))
        return
    end
    N5BoxHighlight(660, 145, 600, 50, true, {255,255,255}, true, SmallHeaderBold, SetData.Title)
    N5Button(830, 90, 240, 50, true, 'SetStateMachine("Edit"); EditActivityScroll=0', false, BodyFontBold,"-> Edit Mode")
    local TermFont=BodyFont
    local DefinitionFont=SmallBodyFont
    local NumberOfTerms=SetData.Terms
    love.graphics.setColor(40,40,40)
    love.graphics.rectangle("fill",scaling(940,1920,Settings.XRes),scaling(200,1080,Settings.YRes),scaling(40,1920,Settings.XRes),scaling(950,1080,Settings.YRes))
    love.graphics.setColor(255,255,255)
    N5BoxHighlight(390, 145, 240, 50, true, {255,255,255}, true, SmallHeaderBold, "Terms")
    N5BoxHighlight(1305, 145, 240, 50, true, {255,255,255}, true, SmallHeaderBold, "Definitions")
    if NumberOfTerms>0 then
        N5BoxHighlight(20, 200+MediumLine, 910, 200, true, {255,255,255}, true, TermFont, SetData[1+ViewActivityScroll].Term)
        N5BoxHighlight(990, 200+MediumLine, 910, 200, true, {255,255,255}, true, DefinitionFont, SetData[1+ViewActivityScroll].Definition)
    end
    if NumberOfTerms>1 then
        N5BoxHighlight(20, 420+MediumLine, 910, 200, true, {255,255,255}, true, TermFont, SetData[2+ViewActivityScroll].Term)
        N5BoxHighlight(990, 420+MediumLine, 910, 200, true, {255,255,255}, true, DefinitionFont, SetData[2+ViewActivityScroll].Definition)
    end
    if NumberOfTerms>2 then
        N5BoxHighlight(20, 640+MediumLine, 910, 200, true, {255,255,255}, true, TermFont, SetData[3+ViewActivityScroll].Term)
        N5BoxHighlight(990, 640+MediumLine, 910, 200, true, {255,255,255}, true, DefinitionFont, SetData[3+ViewActivityScroll].Definition)
    end
    if NumberOfTerms>3 then
        N5BoxHighlight(20, 860+MediumLine, 910, 200, true, {255,255,255}, true, TermFont, SetData[4+ViewActivityScroll].Term)
        N5BoxHighlight(990, 860+MediumLine, 910, 200, true, {255,255,255}, true, DefinitionFont, SetData[4+ViewActivityScroll].Definition)
        ViewActivityScroll=N5ScrollBar(940,200-MediumLine,40,750,4,NumberOfTerms,ViewActivityScroll,true)
    end
    love.graphics.setColor(255,255,255)
end