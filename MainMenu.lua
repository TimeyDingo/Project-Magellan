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
        ButtonStyle1Mod2(ButtonX,scaling(173,1080,Settings[2]),ButtonWidth,ButtonHeight,tostring(SetData[1+MainMenuScroll][1]),Exo24,1+MainMenuScroll)
    end
    if NumberofSets>1 then
        ButtonStyle1Mod2(ButtonX,scaling(266,1080,Settings[2]),ButtonWidth,ButtonHeight,tostring(SetData[2+MainMenuScroll][1]),Exo24,2+MainMenuScroll) 
    end
    if NumberofSets>2 then
        ButtonStyle1Mod2(ButtonX,scaling(359,1080,Settings[2]),ButtonWidth,ButtonHeight,tostring(SetData[3+MainMenuScroll][1]),Exo24,3+MainMenuScroll)
    end
    if NumberofSets>3 then
        ButtonStyle1Mod2(ButtonX,scaling(452,1080,Settings[2]),ButtonWidth,ButtonHeight,tostring(SetData[4+MainMenuScroll][1]),Exo24,4+MainMenuScroll)
    end
    if NumberofSets>4 then
        ButtonStyle1Mod2(ButtonX,scaling(545,1080,Settings[2]),ButtonWidth,ButtonHeight,tostring(SetData[5+MainMenuScroll][1]),Exo24,5+MainMenuScroll)
    end
    if NumberofSets>5 then
        ButtonStyle1Mod2(ButtonX,scaling(638,1080,Settings[2]),ButtonWidth,ButtonHeight,tostring(SetData[6+MainMenuScroll][1]),Exo24,6+MainMenuScroll)
    end
    if NumberofSets>6 then
        ButtonStyle1Mod2(ButtonX,scaling(731,1080,Settings[2]),ButtonWidth,ButtonHeight, tostring(SetData[7+MainMenuScroll][1]),Exo24,7+MainMenuScroll)
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
    end
    love.graphics.setColor(255,255,255,255)
    love.graphics.setFont(Exo24)
end
function ImportMenuBackdrop()
    love.graphics.draw(BackdropImport,0,0,0,1,1,0,0)
end
function ImportMenuTitle()
    CenterText(201,-288,Input,Exo28)
    function love.textinput(t)
        Input=Input..t
    end
    function love.keypressed(key)
        if key == "backspace" then
            -- get the byte offset to the last UTF-8 character in the string.
            local byteoffset = utf8.offset(Input, -1)
    
            if byteoffset then
                -- remove the last UTF-8 character.
                -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
                Input = string.sub(Input, 1, byteoffset - 1)
            end
        end
    end
end
function ImportMenuSetPastingAndPreview()
    if love.keyboard.isDown('v')==true and love.keyboard.isDown('lctrl')==true then
        Paste=love.system.getClipboardText()
    end
    if Paste~="" then
        local x = 825  -- Starting X position for text drawing
        local y = 340  -- Starting Y position for text drawing
        local WrapDistance = 0

        -- Split the inputString into individual sections based on ';;'
        local sections = {}
        for section in string.gmatch(Paste, "[^;;]+") do
            table.insert(sections, section)
        end

        love.graphics.setFont(Exo24)
        y = y + 20  -- Move to the next line

        for i, section in ipairs(sections) do
            -- Split each section into definition and term based on '::'
            local definition, term = section:match("(.+)::(.+)")
            
            if definition and term then
                CenteredTextBox(x, y, 673, 30, definition, Exo20Bold)
                y = y + 20
                WrapDistance = CenteredTextBoxWithWrapping(x, y, 673, term, Exo20)
                y = y + WrapDistance  -- Move to the next line
                if y > 800 then
                    love.graphics.setColor(255, 255, 255, 0)
                end
            end
        end

        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.setFont(Exo24)
    end
end
function ActivityBackdrop()
    love.graphics.draw(GameBar,0,0,0,1,1,0,0)
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(Exo60Black)
    love.graphics.print(StateMachine, 596, 1)
    love.graphics.setFont(Exo24)
end
function SetOptionsBackdrop()
    love.graphics.draw(BackdropSelectAction,0,0,0,1,1,0,0)
    CenterText(0,-350,SetTitle,Exo32Bold)
    love.graphics.setFont(Exo24)
end