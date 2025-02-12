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
        N5Button(ButtonX, 172, ButtonWidth, ButtonHeight, true, "SetToPreview=1+MainMenuScroll" , true ,Exo24,tostring(SetData[1+MainMenuScroll][1]))
    end
    if NumberofSets>1 then
        if SetData[2+MainMenuScroll]==nil then
            MainMenuScroll=0
            return
        end
        N5Button(ButtonX, 266, ButtonWidth, ButtonHeight, true, "SetToPreview=2+MainMenuScroll" , true ,Exo24,tostring(SetData[2+MainMenuScroll][1]))
    end
    if NumberofSets>2 then
        if SetData[3+MainMenuScroll]==nil then
            MainMenuScroll=0
            return
        end
        N5Button(ButtonX, 359, ButtonWidth, ButtonHeight, true, "SetToPreview=3+MainMenuScroll" , true ,Exo24,tostring(SetData[3+MainMenuScroll][1]))
    end
    if NumberofSets>3 then
        if SetData[4+MainMenuScroll]==nil then
            MainMenuScroll=0
            return
        end
        N5Button(ButtonX, 452, ButtonWidth, ButtonHeight, true, "SetToPreview=4+MainMenuScroll" , true ,Exo24,tostring(SetData[4+MainMenuScroll][1]))
    end
    if NumberofSets>4 then
        if SetData[5+MainMenuScroll]==nil then
            MainMenuScroll=0
            return
        end
        N5Button(ButtonX, 545, ButtonWidth, ButtonHeight, true, "SetToPreview=5+MainMenuScroll" , true ,Exo24,tostring(SetData[5+MainMenuScroll][1]))
    end
    if NumberofSets>5 then
        if SetData[6+MainMenuScroll]==nil then
            MainMenuScroll=0
            return
        end
        N5Button(ButtonX, 638, ButtonWidth, ButtonHeight, true, "SetToPreview=6+MainMenuScroll" , true ,Exo24,tostring(SetData[6+MainMenuScroll][1]))
    end
    if NumberofSets>6 then
        if SetData[7+MainMenuScroll]==nil then
            MainMenuScroll=0
            return
        end
        N5Button(ButtonX, 731, ButtonWidth, ButtonHeight, true, "SetToPreview=7+MainMenuScroll" , true ,Exo24,tostring(SetData[7+MainMenuScroll][1]))
    end
    --Space between top and bottom is 17, space between buttons is 93
    if NumberofSets>6 then --?? scroll bar
        MainMenuScroll=ScrollBar(935,136,17,542,7,NumberofSets,MainMenuScroll,true)
    end
    love.graphics.setColor(255,255,255)
end
function SetPreview()
    local x = scaling(976,1920,Settings.XRes)  -- Starting X position for text drawing
    local y = scaling(156,1080,Settings.YRes)  -- Starting Y position for text drawing
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
        CenteredTextBox(scaling(976,1920,Settings.XRes), scaling(135,1080,Settings.YRes), scaling(673,1920,Settings.XRes), scaling(59,1080,Settings.YRes), tostring(setTitle), Exo28Bold)
        love.graphics.setFont(Exo24)
        y = y + scaling(25,1080,Settings.YRes)  -- Move to the next line
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
            WrapDistance = CenteredTextBoxWithWrapping(x, y, scaling(673,1920,Settings.XRes), term, Exo20Bold)
            y = y + WrapDistance + scaling(0,1080,Settings.YRes)  -- Move to the next line after wrapping
            if y > scaling(850,1080,Settings.YRes) then
                love.graphics.setColor(255,255,255,0)
            end
            -- Wrap the definition as you already have
            WrapDistance = CenteredTextBoxWithWrapping(x, y, scaling(673,1920,Settings.XRes), definition, Exo20)
            y = y + WrapDistance  -- Move to the next line
            if y > scaling(850,1080,Settings.YRes) then
                love.graphics.setColor(255,255,255,0)
            end
        end
        love.graphics.setColor(255,255,255,255)
        ButtonStyle1Mod3(x + scaling(80,1920,Settings.XRes), scaling(895,1080,Settings.YRes) + scaling(35,1080,Settings.YRes), scaling(673,1920,Settings.XRes) - scaling(160,1920,Settings.XRes), scaling(50,1080,Settings.YRes), "Delete Set", Exo24Bold, false, "DeleteSet()")
    end
    love.graphics.setColor(255,255,255,255)
    love.graphics.setFont(Exo24)
end
function ImportMenuTitle()
    CenterText(scaling(201,1920,Settings.XRes),scaling(-288,1080,Settings.YRes),Input,Exo28)
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

        love.graphics.setFont(Exo24)
        y = y + scaling(20,1080,Settings.YRes)  -- Move to the next line

        for i, section in ipairs(sections) do
            -- Split each section into definition and term based on '::'
            local definition, term = section:match("(.+)::(.+)")
            
            if definition and term then
                -- Draw the definition text box with wrapping
                WrapDistance = CenteredTextBoxWithWrapping(x, y, scaling(673,1920,Settings.XRes), definition, Exo20Bold)
                y = y + WrapDistance  -- Move to the next line after wrapping
                
                -- Draw the term text box with wrapping
                WrapDistance = CenteredTextBoxWithWrapping(x, y, scaling(673,1920,Settings.XRes), term, Exo20)
                y = y + WrapDistance  -- Move to the next line after wrapping

                -- Check for overflow and hide text if necessary
                if y > scaling(800,1080,Settings.YRes) then
                    love.graphics.setColor(255, 255, 255, 0)  -- Hide text if it goes too far down the screen
                end
            end
        end

        love.graphics.setColor(255, 255, 255, 255)  -- Reset the color after hiding
        love.graphics.setFont(Exo24)
    end
end
function ActivityBackdrop()
    BackdropDraw(GameBarBackdrop)
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(Exo60Black)
    love.graphics.print(StateMachine, scaling(596,1920,Settings.XRes), scaling(1,1080,Settings.YRes))
    love.graphics.setFont(Exo24)
end
function SettingResolutionButtons(BoxX,BoxY,BoxW,BoxH,Text,TextFont,ClickedValue,Scaling)
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil or Text==nil or TextFont==nil or ClickedValue==nil then
        print("In SettingResolutionButtons() BoxX is reporting as: "..tostring(BoxX))
        print("In SettingResolutionButtons() BoxY is reporting as: "..tostring(BoxY))
        print("In SettingResolutionButtons() BoxW is reporting as: "..tostring(BoxW))
        print("In SettingResolutionButtons() BoxH is reporting as: "..tostring(BoxH))
        print("In SettingResolutionButtons() Text is reporting as: "..tostring(Text))
        print("In SettingResolutionButtons() TextFont is reporting as: "..tostring(TextFont))
        print("In SettingResolutionButtons() ClickedValue is reporting as: "..tostring(ClickedValue))
        return
    end
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight(Text)
    local TW = TextFont:getWidth(Text)
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
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
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil or Text==nil or TextFont==nil or ClickedValue==nil then
        print("In SettingsFullscreenButtons() BoxX is reporting as: "..tostring(BoxX))
        print("In SettingsFullscreenButtons() BoxY is reporting as: "..tostring(BoxY))
        print("In SettingsFullscreenButtons() BoxW is reporting as: "..tostring(BoxW))
        print("In SettingsFullscreenButtons() BoxH is reporting as: "..tostring(BoxH))
        print("In SettingsFullscreenButtons() Text is reporting as: "..tostring(Text))
        print("In SettingsFullscreenButtons() TextFont is reporting as: "..tostring(TextFont))
        print("In SettingsFullscreenButtons() ClickedValue is reporting as: "..tostring(ClickedValue))
        return
    end
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight(Text)
    local TW = TextFont:getWidth(Text)
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
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
function ResolutionDropDownMenuMk1(BoxX,BoxY,BoxW,BoxH,TextFont,Scaling)
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil or Scaling==nil then
        print("In DropDownMenuMk1() BoxX is reporting as: "..tostring(BoxX))
        print("In DropDownMenuMk1() BoxY is reporting as: "..tostring(BoxY))
        print("In DropDownMenuMk1() BoxW is reporting as: "..tostring(BoxW))
        print("In DropDownMenuMk1() BoxH is reporting as: "..tostring(BoxH))
        print("In DropDownMenuMk1() Scaling is reporting as: "..tostring(Scaling))
        return 0
    end
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
    end
    local BoxXX=BoxX
    local BoxYY=BoxY
    local BoxWW=BoxW
    local BoxHH=BoxH
    Text=Settings.XRes.." x "..Settings.YRes
    local TW=TextFont:getWidth(Text)
    local TH=TextFont:getHeight(Text)
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW+scaling(500,1920,Settings.XRes), BoxH)

    -- Coordinates for the text
    local textX = BoxX + (BoxW - TW) / 2  -- Center the text horizontally
    local textY = BoxY + (BoxH - TH) / 2  -- Center the text vertically
    
    love.graphics.print(Text, textX, textY)
    love.graphics.setLineWidth(MediumLine)
    if Selected or SettingsResolutionDropDownClicked then
        love.graphics.setColor(255, 255, 255)
        if love.mouse.isDown(1) and love.mouse.isDown("1") then -- Button clicked
            SettingsResolutionDropDownClicked=true
        end
    else
        love.graphics.setColor(255, 153, 0)
    end
    if SettingsResolutionDropDownClicked then
        local XScale=scaling(20,1920,Settings.XRes)
        local YSpacing=scaling(5,1080,Settings.YRes)
        local MiniBoxHeight=BoxHH/3.7
        ResolutionDropDownButton(BoxXX+XScale, BoxYY+BoxH+YSpacing, BoxWW, MiniBoxHeight, "854 x 480", Exo24, false, "ApplyResolutionSettings(854,480)")
        ResolutionDropDownButton(BoxXX+XScale, BoxYY+BoxHH+YSpacing+MiniBoxHeight*1, BoxWW, MiniBoxHeight, "1024 x 576", Exo24, false, "ApplyResolutionSettings(1024,576)")
        ResolutionDropDownButton(BoxXX+XScale, BoxYY+BoxHH+YSpacing+MiniBoxHeight*2, BoxWW, MiniBoxHeight, "1128 x 634", Exo24, false, "ApplyResolutionSettings(1128,634)")
        ResolutionDropDownButton(BoxXX+XScale, BoxYY+BoxHH+YSpacing+MiniBoxHeight*3, BoxWW, MiniBoxHeight, "1280 x 720", Exo24, false, "ApplyResolutionSettings(1280,720)")
        ResolutionDropDownButton(BoxXX+XScale, BoxYY+BoxHH+YSpacing+MiniBoxHeight*4, BoxWW, MiniBoxHeight, "1366 x 768", Exo24, false, "ApplyResolutionSettings(1366,768)")
        ResolutionDropDownButton(BoxXX+XScale, BoxYY+BoxHH+YSpacing+MiniBoxHeight*5, BoxWW, MiniBoxHeight, "1440 x 810", Exo24, false, "ApplyResolutionSettings(1440,810)")
        ResolutionDropDownButton(BoxXX+XScale, BoxYY+BoxHH+YSpacing+MiniBoxHeight*6, BoxWW, MiniBoxHeight, "1600 x 900", Exo24, false, "ApplyResolutionSettings(1600,900)")
        ResolutionDropDownButton(BoxXX+XScale, BoxYY+BoxHH+YSpacing+MiniBoxHeight*7, BoxWW, MiniBoxHeight, "1680 x 1050", Exo24, false, "ApplyResolutionSettings(168,1050)")
        ResolutionDropDownButton(BoxXX+XScale, BoxYY+BoxHH+YSpacing+MiniBoxHeight*8, BoxWW, MiniBoxHeight, "1760 x 990", Exo24, false, "ApplyResolutionSettings(1760,990)")
        ResolutionDropDownButton(BoxXX+XScale, BoxYY+BoxHH+YSpacing+MiniBoxHeight*9, BoxWW, MiniBoxHeight, "1920 x 1080", Exo24, false, "ApplyResolutionSettings(1920,1080)")
        ResolutionDropDownButton(BoxXX+XScale, BoxYY+BoxHH+YSpacing+MiniBoxHeight*10, BoxWW, MiniBoxHeight, "2560 x 1440", Exo24, false, "ApplyResolutionSettings(2560,1440)")
        ResolutionDropDownButton(BoxXX+XScale, BoxYY+BoxHH+YSpacing+MiniBoxHeight*11, BoxWW, MiniBoxHeight, "2732 x 1536", Exo24, false, "ApplyResolutionSettings(2732,1536)")
        ResolutionDropDownButton(BoxXX+XScale, BoxYY+BoxHH+YSpacing+MiniBoxHeight*12, BoxWW, MiniBoxHeight, "3840 x 2160", Exo24, false, "ApplyResolutionSettings(3840,2160)")
    end
    love.graphics.rectangle("line", BoxX, BoxY, BoxW+scaling(500,1920,Settings.XRes), BoxH)
    love.graphics.setLineWidth(ThinLine)
    love.graphics.setColor(255, 255, 255)
end
function ResolutionDropDownButton(BoxX, BoxY, BoxW, BoxH, Text, TextFont, Scaling, Action)--Be able to run a function
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil or Text==nil or TextFont==nil then
        print("In ButtonStyle1Mod3() BoxX is reporting as: "..tostring(BoxX))
        print("In ButtonStyle1Mod3() BoxY is reporting as: "..tostring(BoxY))
        print("In ButtonStyle1Mod3() BoxW is reporting as: "..tostring(BoxW))
        print("In ButtonStyle1Mod3() BoxH is reporting as: "..tostring(BoxH))
        print("In ButtonStyle1Mod3() Text is reporting as: "..tostring(Text))
        print("In ButtonStyle1Mod3() TextFont is reporting as: "..tostring(TextFont))
        return
    end
    love.graphics.setFont(TextFont)
    local TH = TextFont:getHeight(Text)
    local TW = TextFont:getWidth(Text)
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
    end
    -- Check if mouse is over the box
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW+scaling(480,1920,Settings.XRes), BoxH)
    
    -- Coordinates for the text
    local textX = BoxX + (BoxW - TW) / 2  -- Center the text horizontally
    local textY = BoxY + (BoxH - TH) / 2  -- Center the text vertically
    
    love.graphics.print(Text, textX, textY)
    love.graphics.setLineWidth(MediumLine)
    if Selected then
        love.graphics.setColor(255, 255, 255)
        if love.mouse.isDown(1) and MouseClickDebounce(0.5) then -- Button clicked
            if Action then
                local actionFunc, err = load(Action)
                if actionFunc then
                    actionFunc()
                else
                    print("Error in action string: " .. err)
                end
            end
            return true
        end
    else
        love.graphics.setColor(255, 153, 0)
        if DetectedRes==Text then
            love.graphics.setColor(0,255,0)
        end
    end
    love.graphics.rectangle("line", BoxX, BoxY, BoxW+scaling(480,1920,Settings.XRes), BoxH)
    love.graphics.setLineWidth(ThinLine)
    love.graphics.setColor(255, 255, 255)
end