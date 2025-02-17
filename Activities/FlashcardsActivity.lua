function FlashcardActivity()
    SetTitle, SetData = LoadIndividualSet(SetToPreview)
    if FlashCardActivityFlashCardSide==nil or SetTitle==nil or SetData==nil then
        print("In FlashcardActivity() FlashCardActivityFlashCardSide is reporting as: "..tostring(FlashCardActivityFlashCardSide))
        print("In FlashcardActivity() SetTitle is reporting as: "..tostring(SetTitle))
        print("In FlashcardActivity() SetData is reporting as: "..tostring(SetData))
        return
    end
    N5BoxHighlight(830, 143, 240, 50, true, {255,255,255}, true, SmallHeaderBold, tostring(FlashCardActivityFlashCard).."/"..tostring(#SetData))
    N5BoxHighlight(660, 198, 600, 50, true, {255,255,255}, true, SmallHeaderBold, SetTitle)--145, 90
    --CenterText(0,0,tostring(SetData[2][2]),Exo24)
    DisplayFlashCard(scaling(578,1920,Settings.XRes),scaling(308,1080,Settings.YRes),scaling(763,1920,Settings.XRes),scaling(464,1080,Settings.YRes),tostring(SetData[FlashCardActivityFlashCard][FlashCardActivityFlashCardSide]),BodyFontBold)
    FlashCardKeyboardControls()
    N5Button(578, 800, 763, 100, true, "FlashCardChangeDisplaySideFirst()", true, BodyFontBold,"Swap Display Order")
    --ButtonStyle1Mod3(1341,308,500,464,"Note here", Exo24Bold, true) !! Add note thing here
    --!! flickering on flashcard flip sides
end
function DisplayFlashCard(BoxX, BoxY, BoxW, BoxH, Text, TextFont)
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil or Text==nil or TextFont==nil then
        print("In DisplayFlashCard() BoxX is reporting as: "..tostring(BoxX))
        print("In DisplayFlashCard() BoxY is reporting as: "..tostring(BoxY))
        print("In DisplayFlashCard() BoxW is reporting as: "..tostring(BoxW))
        print("In DisplayFlashCard() BoxH is reporting as: "..tostring(BoxH))
        print("In DisplayFlashCard() Text is reporting as: "..tostring(Text))
        print("In DisplayFlashCard() TextFont is reporting as: "..tostring(TextFont))
        return
    end
    if FlashCardActivityFlashCardSide==1 then
        love.graphics.setColor(255, 255, 255)
    else
        love.graphics.setColor(180, 180, 180)
    end
    --95 box background
    love.graphics.rectangle("fill", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setColor(0,0,0)--text color
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight() * #Text / BoxW -- Estimate height based on wrapping
    local _, wrappedText = TextFont:getWrap(Text, BoxW)
    local wrappedHeight = #wrappedText * TextFont:getHeight()
    
    -- Check if mouse is over the box
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    
    -- Coordinates for the text
    local textY = BoxY + (BoxH - wrappedHeight) / 2  -- Center the text vertically
    
    love.graphics.printf(Text, BoxX, textY, BoxW, "center")  -- Print wrapped and centered text
    love.graphics.setLineWidth(MediumLine)
    if Selected then
        function love.mousepressed(x, y, button, istouch, presses)
            if button == 1 then  -- Check for left mouse button
                FlipCard()
            end
        end
    end
    --95 box border
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
function FlashCardKeyboardControls()
    if ButtonDebounce("left", 0.5) or YScroll>0 then
        if FlashCardActivityFlashCard==1 then
            FlashCardActivityFlashCard=#SetData
            YScroll=0
        else
            FlashCardActivityFlashCard=FlashCardActivityFlashCard-1
            YScroll=0
        end
        FlashCardActivityFlashCardSide=FlashCardActivityDisplaySideFirst
    end
    if ButtonDebounce("right", 0.5) or YScroll<0 then
        if FlashCardActivityFlashCard==#SetData then
            FlashCardActivityFlashCard=1
            YScroll=0
        else
            FlashCardActivityFlashCard=FlashCardActivityFlashCard+1
            YScroll=0
        end
        FlashCardActivityFlashCardSide=FlashCardActivityDisplaySideFirst
    end
    if ButtonDebounce("up", 0.5) then
        FlipCard()
    end
    if ButtonDebounce("down", 0.5) then
        FlipCard()
    end
end
function FlipCard()
    if FlashCardActivityFlashCardSide==1 then
        FlashCardActivityFlashCardSide=2
    else
        FlashCardActivityFlashCardSide=1
    end
end
function FlashCardChangeDisplaySideFirst()
    FlashCardActivityDisplaySideFirst = (FlashCardActivityDisplaySideFirst == 1) and 2 or 1
end