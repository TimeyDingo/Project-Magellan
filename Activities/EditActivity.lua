function EditActivity()
    if toboolean(EditActivityLoadOnce)==false then
        SetTitle, SetData=LoadIndividualSet(SetToPreview)
        EditActivityLoadOnce=true
    end
    CenterText(0,scaling(-450,1080,Settings[2]),SetTitle,Exo32Bold)
end
function EditActivityEditableBox(BoxX, BoxY, BoxW, Text, TextFont,TermOrDefinition,TermOrDefinitionToEdit, Scaling)
    love.graphics.setFont(TextFont)
    local textHeight = TextFont:getHeight()  -- Height of a single line of text
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings[1])
        BoxY=scaling(BoxY,1080,Settings[2])
        BoxW=scaling(BoxW,1920,Settings[1])
        BoxH=scaling(BoxH,1080,Settings[2])
    end
    -- Calculate the wrapped text and the number of lines
    local wrappedText, lines = TextFont:getWrap(Text, BoxW)
    local totalHeight = #lines * textHeight

    -- Calculate the Y position to vertically center the text
    local textY = BoxY

    -- Print the wrapped and centered text
    love.graphics.printf(Text, BoxX, textY, BoxW, "center")

    return totalHeight
end