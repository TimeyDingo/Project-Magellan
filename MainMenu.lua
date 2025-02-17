function ListofSets()
    if Settings==nil or MainMenuScroll==nil then
        print("In ListofSets() Settings is reporting as: "..tostring(Settings))
        print("In ListofSets() MainMenuScroll is reporting as: "..tostring(MainMenuScroll))
        return
    end
    N5BoxHighlight(267, 156, 656, 651, true, {255,255,255} ,true)
    love.graphics.setLineWidth(ThinLine)
    local NumberofSets=CheckSavedSets()
    if NumberofSets==nil or SetData==nil then
        print("In ListofSets() NumberofSets is reporting as: "..tostring(NumberofSets))
        print("In ListofSets() SetData is reporting as: "..tostring(SetData))
        return
    end
    local ButtonX=283
    local ButtonWidth=624
    local ButtonHeight=59
    if NumberofSets>0 then
        if SetData[1+MainMenuScroll]==nil then
            MainMenuScroll=0
            return
        end
        N5Button(ButtonX, 172, ButtonWidth, ButtonHeight, true, "SetToPreview=1+MainMenuScroll" , true ,BodyFont,tostring(SetData[1+MainMenuScroll][1]))
    end
    if NumberofSets>1 then
        if SetData[2+MainMenuScroll]==nil then
            MainMenuScroll=0
            return
        end
        N5Button(ButtonX, 266, ButtonWidth, ButtonHeight, true, "SetToPreview=2+MainMenuScroll" , true ,BodyFont,tostring(SetData[2+MainMenuScroll][1]))
    end
    if NumberofSets>2 then
        if SetData[3+MainMenuScroll]==nil then
            MainMenuScroll=0
            return
        end
        N5Button(ButtonX, 359, ButtonWidth, ButtonHeight, true, "SetToPreview=3+MainMenuScroll" , true ,BodyFont,tostring(SetData[3+MainMenuScroll][1]))
    end
    if NumberofSets>3 then
        if SetData[4+MainMenuScroll]==nil then
            MainMenuScroll=0
            return
        end
        N5Button(ButtonX, 452, ButtonWidth, ButtonHeight, true, "SetToPreview=4+MainMenuScroll" , true ,BodyFont,tostring(SetData[4+MainMenuScroll][1]))
    end
    if NumberofSets>4 then
        if SetData[5+MainMenuScroll]==nil then
            MainMenuScroll=0
            return
        end
        N5Button(ButtonX, 545, ButtonWidth, ButtonHeight, true, "SetToPreview=5+MainMenuScroll" , true ,BodyFont,tostring(SetData[5+MainMenuScroll][1]))
    end
    if NumberofSets>5 then
        if SetData[6+MainMenuScroll]==nil then
            MainMenuScroll=0
            return
        end
        N5Button(ButtonX, 638, ButtonWidth, ButtonHeight, true, "SetToPreview=6+MainMenuScroll" , true ,BodyFont,tostring(SetData[6+MainMenuScroll][1]))
    end
    if NumberofSets>6 then
        if SetData[7+MainMenuScroll]==nil then
            MainMenuScroll=0
            return
        end
        N5Button(ButtonX, 731, ButtonWidth, ButtonHeight, true, "SetToPreview=7+MainMenuScroll" , true ,BodyFont,tostring(SetData[7+MainMenuScroll][1]))
    end
    --Space between top and bottom is 17, space between buttons is 93
    if NumberofSets>6 then --?? scroll bar
        MainMenuScroll=N5ScrollBar(935,156,17,497,7,NumberofSets,MainMenuScroll,true)
    end
    love.graphics.setColor(255,255,255)
end
function SetPreview()
    local x = scaling(976,1920,Settings.XRes)  -- Starting X position for text drawing
    local y = scaling(360,1080,Settings.YRes)  -- Starting Y position for text drawing
    local WrapDistance = 0
    if SetToPreview == nil or SetData == nil or Settings == nil then
        print("In SetPreview() SetToPreview is reporting as: "..tostring(SetToPreview))
        print("In SetPreview() SetData is reporting as: "..tostring(SetData))
        print("In SetPreview() Settings is reporting as: "..tostring(Settings))
        return
    end
    if SetToPreview > 0 and SetData[SetToPreview] then
        local setTitle = SetData[SetToPreview][1]
        local dataSet = SetData[SetToPreview][2]
        --clean this shit up
        N5BoxHighlight(976, 180, 673, 100, false, {}, true)-- box around title
        love.graphics.setColor(195,199,203)--title cover
        love.graphics.rectangle("fill",scaling(1226,1920,Settings.XRes),scaling(155,1080,Settings.YRes),scaling(174,1920,Settings.XRes),scaling(110,1080,Settings.YRes))--title cover
        N5BoxHighlight(986, 210, 653, 59, true, {255,255,255}, true, LargeBodyFontBold, tostring(setTitle))--title
        love.graphics.setColor(0,0,0,255)
        CenteredTextBox(1176,120,273,110,"Set Title", MediumHeaderBold, true)--title
        love.graphics.setFont(BodyFont)
        N5BoxHighlight(976, 320, 673, 585, false, {}, true)-- box around preview
        love.graphics.setColor(195,199,203)--title cover
        love.graphics.rectangle("fill",scaling(1240,1920,Settings.XRes),scaling(295,1080,Settings.YRes),scaling(150,1920,Settings.XRes),scaling(110,1080,Settings.YRes))--preview cover
        love.graphics.setColor(0,0,0,255)
        CenteredTextBox(1176,260,273,110," Preview ", MediumHeaderBold, true)--preview title
        N5BoxHighlight(986, 350, 653, 545, true, {255,255,255}, true)--white box
        -- or at least comment it
        love.graphics.setColor(0,0,0,255)
        --y = y + scaling(25,1080,Settings.YRes)  -- Move to the next line
        if dataSet == nil then
            print("In SetPreview() dataSet is reporting as: "..tostring(dataSet))
            return
        end
        for i, item in ipairs(dataSet) do
            local definition = item[1]
            local term = item[2]
            if y > scaling(850,1080,Settings.YRes) then
                love.graphics.setColor(255,255,255,0)
            end
            -- Add wrapping for the term text box
            WrapDistance = CenteredTextBoxWithWrapping(x, y, scaling(673,1920,Settings.XRes), term, SmallBodyFontBold)
            y = y + WrapDistance + scaling(0,1080,Settings.YRes)  -- Move to the next line after wrapping
            if y > scaling(850,1080,Settings.YRes) then
                love.graphics.setColor(255,255,255,0)
            end
            -- Wrap the definition as you already have
            WrapDistance = CenteredTextBoxWithWrapping(x, y, scaling(673,1920,Settings.XRes), definition, SmallBodyFont)
            y = y + WrapDistance  -- Move to the next line
            if y > scaling(850,1080,Settings.YRes) then
                love.graphics.setColor(255,255,255,0)
            end
        end
        love.graphics.setColor(255,255,255,255)
        N5Button(x + scaling(80,1920,Settings.XRes), scaling(895,1080,Settings.YRes) + scaling(35,1080,Settings.YRes), scaling(673,1920,Settings.XRes) - scaling(160,1920,Settings.XRes), scaling(50,1080,Settings.YRes), false, "DeleteSet()", false,BodyFontBold,"Delete Set")
    end
    love.graphics.setColor(255,255,255,255)
    love.graphics.setFont(BodyFont)
end
function ImportMenuTitle()
    love.graphics.setColor(0,0,0)
    CenterText(scaling(201,1920,Settings.XRes),scaling(-293,1080,Settings.YRes),Input,LargeBodyFont)
    function love.textinput(t)
        Input=Input..t
    end
    Input=BackspaceController(Input,2,0.1)
end
function ImportMenuSetPastingAndPreview()
    if Paste==nil or Settings==nil then
        print("In ImportMenuSetPastingAndPreview() Paste is reporting as: "..tostring(Paste))
        print("In ImportMenuSetPastingAndPreview() Settings is reporting as: "..tostring(Settings))
        return
    end
    if love.keyboard.isDown('v')==true and love.keyboard.isDown('lctrl')==true then
        Paste=love.system.getClipboardText()
    end
    if Paste~="" then
        local x = scaling(825,1920,Settings.XRes)  -- Starting X position for text drawing
        local y = scaling(340,1080,Settings.YRes)  -- Starting Y position for text drawing
        local WrapDistance = 0

        -- Split the inputString into individual sections based on ';;'
        local sections = {}
        for section in string.gmatch(Paste, "[^;;]+") do
            table.insert(sections, section)
        end

        love.graphics.setFont(BodyFont)
        y = y + scaling(20,1080,Settings.YRes)  -- Move to the next line

        for i, section in ipairs(sections) do
            -- Split each section into definition and term based on '::'
            local definition, term = section:match("(.+)::(.+)")
            
            if definition and term then
                -- Draw the definition text box with wrapping
                WrapDistance = CenteredTextBoxWithWrapping(x, y, scaling(673,1920,Settings.XRes), definition, SmallBodyFontBold)
                y = y + WrapDistance  -- Move to the next line after wrapping
                
                -- Draw the term text box with wrapping
                WrapDistance = CenteredTextBoxWithWrapping(x, y, scaling(673,1920,Settings.XRes), term, SmallBodyFont)
                y = y + WrapDistance  -- Move to the next line after wrapping

                -- Check for overflow and hide text if necessary
                if y > scaling(650,1080,Settings.YRes) then
                    love.graphics.setColor(255, 255, 255, 0)  -- Hide text if it goes too far down the screen
                end
            end
        end

        love.graphics.setColor(255, 255, 255, 255)  -- Reset the color after hiding
        love.graphics.setFont(BodyFont)
    end
end
function ActivityBackdrop()
    BackdropDraw(GameBarBackdrop)
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(LargeHeader)
    love.graphics.print(StateMachine, scaling(1150,1920,Settings.XRes), scaling(3,1080,Settings.YRes))
    love.graphics.setFont(BodyFont)
end