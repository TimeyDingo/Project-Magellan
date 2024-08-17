function ListofSets()
    SetData = LoadSavedSetsIntoMemory()
    local TopLeftX=scaling(267,1920,Settings[1])
    local TopLeftY=scaling(156,1080,Settings[2])
    local Width=scaling(656,1920,Settings[1])
    local Height=scaling(651,1080,Settings[2])
    love.graphics.setLineWidth(ThickLine)
    love.graphics.setColor(22, 22, 22)
    love.graphics.rectangle("line", TopLeftX,TopLeftY,Width,Height)
    love.graphics.setColor(255,255,255)
    love.graphics.setLineWidth(ThinLine)
    local NumberofSets=CheckSavedSets()
    local ButtonX=scaling(283,1920,Settings[1])
    local ButtonWidth=scaling(624,1920,Settings[1])
    local ButtonHeight=scaling(59,1080,Settings[2])
    if NumberofSets>0 then
        MainMenuSetListButtons(ButtonX,scaling(173,1080,Settings[2]),ButtonWidth,ButtonHeight,tostring(SetData[1+MainMenuScroll][1]),Exo24,1+MainMenuScroll)
    end
    if NumberofSets>1 then
        MainMenuSetListButtons(ButtonX,scaling(266,1080,Settings[2]),ButtonWidth,ButtonHeight,tostring(SetData[2+MainMenuScroll][1]),Exo24,2+MainMenuScroll) 
    end
    if NumberofSets>2 then
        MainMenuSetListButtons(ButtonX,scaling(359,1080,Settings[2]),ButtonWidth,ButtonHeight,tostring(SetData[3+MainMenuScroll][1]),Exo24,3+MainMenuScroll)
    end
    if NumberofSets>3 then
        MainMenuSetListButtons(ButtonX,scaling(452,1080,Settings[2]),ButtonWidth,ButtonHeight,tostring(SetData[4+MainMenuScroll][1]),Exo24,4+MainMenuScroll)
    end
    if NumberofSets>4 then
        MainMenuSetListButtons(ButtonX,scaling(545,1080,Settings[2]),ButtonWidth,ButtonHeight,tostring(SetData[5+MainMenuScroll][1]),Exo24,5+MainMenuScroll)
    end
    if NumberofSets>5 then
        MainMenuSetListButtons(ButtonX,scaling(638,1080,Settings[2]),ButtonWidth,ButtonHeight,tostring(SetData[6+MainMenuScroll][1]),Exo24,6+MainMenuScroll)
    end
    if NumberofSets>6 then
        MainMenuSetListButtons(ButtonX,scaling(731,1080,Settings[2]),ButtonWidth,ButtonHeight, tostring(SetData[7+MainMenuScroll][1]),Exo24,7+MainMenuScroll)
    end
    --Space between top and bottom is 17, space between buttons is 93
    if NumberofSets>6 then --?? scroll bar
        love.graphics.setColor(255, 153, 0)
        local ScrollingOrigin=scaling(678,1080,Settings[2])
        love.graphics.rectangle("fill",scaling(935,1920,Settings[1]),scaling(136,1080,Settings[2])+(ScrollingOrigin/NumberofSets)*MainMenuScroll,scaling(17,1920,Settings[1]),ScrollingOrigin/NumberofSets*7)
        love.graphics.setColor(255,255,255)
        function love.keypressed(key)
            if key == "up" and MainMenuScroll > 0 then
                MainMenuScroll = MainMenuScroll - 1
            end
            if key == "down" and MainMenuScroll < NumberofSets-7 then
                MainMenuScroll = MainMenuScroll + 1
            end
        end
    end
    love.graphics.setColor(255,255,255)
end
function SetPreview()
    local x = scaling(976,1920,Settings[1])  -- Starting X position for text drawing
    local y = scaling(156,1080,Settings[2])  -- Starting Y position for text drawing
    local WrapDistance=0

    if SetToPreview > 0 and SetData[SetToPreview] then
        local setTitle = SetData[SetToPreview][1]
        local dataSet = SetData[SetToPreview][2]
        CenteredTextBox(scaling(976,1920,Settings[1]),scaling(135,1080,Settings[2]), scaling(673,1920,Settings[1]), scaling(59,1080,Settings[2]), tostring(setTitle), Exo28Bold)
        love.graphics.setFont(Exo24)
        y = y + scaling(25,1080,Settings[2])  -- Move to the next line

        for i, item in ipairs(dataSet) do
            local definition = item[1]
            local term = item[2]
            CenteredTextBox(x,y,scaling(673,1920,Settings[1]),scaling(30,1080,Settings[2]),term,Exo20Bold)
            y=y+scaling(20,1080,Settings[2])
            WrapDistance=CenteredTextBoxWithWrapping(x,y,scaling(673,1920,Settings[1]),definition,Exo20)
            y = y + WrapDistance  -- Move to the next line
            if y>scaling(905,1080,Settings[2]) then
                love.graphics.setColor(255,255,255,0)
            end
        end
        love.graphics.setColor(255,255,255)
        --CenteredTextBox(x,scaling(905,1080,Settings[2])+scaling(35,1080,Settings[2]),scaling(673,1920,Settings[1]),scaling(30,1080,Settings[2]),"Delete Term",Exo20Bold)
        ButtonStyle1Mod3(x+scaling(80,1920,Settings[1]),scaling(895,1080,Settings[2])+scaling(35,1080,Settings[2]),scaling(673,1920,Settings[1])-scaling(160,1920,Settings[1]),scaling(50,1080,Settings[2]),"Delete Set",Exo24Bold,false,"DeleteSet()")
    end
    love.graphics.setColor(255,255,255,255)
    love.graphics.setFont(Exo24)
end
function ImportMenuTitle()
    CenterText(scaling(201,1920,Settings[1]),scaling(-288,1080,Settings[2]),Input,Exo28)
    function love.textinput(t)
        Input=Input..t
    end
    Input=BackspaceController(Input,30)
end
function ImportMenuSetPastingAndPreview()
    if love.keyboard.isDown('v')==true and love.keyboard.isDown('lctrl')==true then
        Paste=love.system.getClipboardText()
    end
    if Paste~="" then
        local x = scaling(825,1920,Settings[1])  -- Starting X position for text drawing
        local y = scaling(340,1080,Settings[2])  -- Starting Y position for text drawing
        local WrapDistance = 0

        -- Split the inputString into individual sections based on ';;'
        local sections = {}
        for section in string.gmatch(Paste, "[^;;]+") do
            table.insert(sections, section)
        end

        love.graphics.setFont(Exo24)
        y = y + scaling(20,1080,Settings[2])  -- Move to the next line

        for i, section in ipairs(sections) do
            -- Split each section into definition and term based on '::'
            local definition, term = section:match("(.+)::(.+)")
            
            if definition and term then
                CenteredTextBox(x, y, scaling(673,1920,Settings[1]), scaling(30,1080,Settings[2]), definition, Exo20Bold)
                y = y + scaling(20,1080,Settings[2])
                WrapDistance = CenteredTextBoxWithWrapping(x, y, scaling(673,1920,Settings[1]), term, Exo20)
                y = y + WrapDistance  -- Move to the next line
                if y > scaling(800,1080,Settings[2]) then
                    love.graphics.setColor(255, 255, 255, 0)
                end
            end
        end

        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.setFont(Exo24)
    end
end
function ActivityBackdrop()
    BackdropDraw(GameBarBackdrop)
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(Exo60Black)
    love.graphics.print(StateMachine, scaling(596,1920,Settings[1]), scaling(1,1080,Settings[2]))
    love.graphics.setFont(Exo24)
end
function MainMenuSetListButtons(BoxX,BoxY,BoxW,BoxH,Text,TextFont,ClickedValue,Scaling)
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight(Text)
    local TW = TextFont:getWidth(Text)
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings[1])
        BoxY=scaling(BoxY,1080,Settings[2])
        BoxW=scaling(BoxW,1920,Settings[1])
        BoxH=scaling(BoxH,1080,Settings[2])
    end
    -- Check if mouse is over the box
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    
    -- Coordinates for the text
    local textX = BoxX + (BoxW - TW) / 2  -- Center the text horizontally
    local textY = BoxY + (BoxH - TH) / 2        -- Center the text vertically
    
    love.graphics.print(Text, textX, textY)
    love.graphics.setLineWidth(MediumLine)
    if Selected or SetToPreview==ClickedValue then
        love.graphics.setColor(255, 255, 255)
        if love.mouse.isDown(1) then --! clicked
            SetToPreview=ClickedValue
        end
    else
        love.graphics.setColor(255, 153, 0)
    end
    love.graphics.rectangle("line", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setLineWidth(ThinLine)
    love.graphics.setColor(255, 255, 255)
end
function SettingResolutionButtons(BoxX,BoxY,BoxW,BoxH,Text,TextFont,ClickedValue,Scaling)
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight(Text)
    local TW = TextFont:getWidth(Text)
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings[1])
        BoxY=scaling(BoxY,1080,Settings[2])
        BoxW=scaling(BoxW,1920,Settings[1])
        BoxH=scaling(BoxH,1080,Settings[2])
    end
    -- Check if mouse is over the box
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    
    -- Coordinates for the text
    local textX = BoxX + (BoxW - TW) / 2  -- Center the text horizontally
    local textY = BoxY + (BoxH - TH) / 2        -- Center the text vertically
    
    love.graphics.print(Text, textX, textY)
    love.graphics.setLineWidth(MediumLine)
    if Selected or SettingsResolution==ClickedValue then
        love.graphics.setColor(255, 255, 255)
        if love.mouse.isDown(1) then --! clicked
            SettingsResolution=ClickedValue
        end
    else
        love.graphics.setColor(255, 153, 0)
    end
    love.graphics.rectangle("line", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setLineWidth(ThinLine)
    love.graphics.setColor(255, 255, 255)
end
function SettingsFullscreenButtons(BoxX,BoxY,BoxW,BoxH,Text,TextFont,ClickedValue,Scaling)
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight(Text)
    local TW = TextFont:getWidth(Text)
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings[1])
        BoxY=scaling(BoxY,1080,Settings[2])
        BoxW=scaling(BoxW,1920,Settings[1])
        BoxH=scaling(BoxH,1080,Settings[2])
    end
    -- Check if mouse is over the box
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
    
    -- Coordinates for the text
    local textX = BoxX + (BoxW - TW) / 2  -- Center the text horizontally
    local textY = BoxY + (BoxH - TH) / 2        -- Center the text vertically
    
    love.graphics.print(Text, textX, textY)
    love.graphics.setLineWidth(MediumLine)
    if Selected or SettingsFullscreen==ClickedValue then
        love.graphics.setColor(255, 255, 255)
        if love.mouse.isDown(1) then --! clicked
            SettingsFullscreen=ClickedValue
        end
    else
        love.graphics.setColor(255, 153, 0)
    end
    love.graphics.rectangle("line", BoxX, BoxY, BoxW, BoxH)
    love.graphics.setLineWidth(ThinLine)
    love.graphics.setColor(255, 255, 255)
end