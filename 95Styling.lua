function N5Button(BoxX, BoxY, BoxW, BoxH, Scaling, Action, Fill,TextFont,Text)--Used to highlight a button like the X or <- in 95 style
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil then
        print("In ButtonStyle1Mod3() BoxX is reporting as: "..tostring(BoxX))
        print("In ButtonStyle1Mod3() BoxY is reporting as: "..tostring(BoxY))
        print("In ButtonStyle1Mod3() BoxW is reporting as: "..tostring(BoxW))
        print("In ButtonStyle1Mod3() BoxH is reporting as: "..tostring(BoxH))
        return
    end
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
    end
    if Fill then
        love.graphics.setColor(195, 199, 203) -- white
        love.graphics.rectangle("fill", BoxX,BoxY,BoxW,BoxH)
    end
    if TextFont and Text then
        love.graphics.setColor(0,0,0)
        local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)
        love.graphics.setFont(TextFont)
        local TH = TextFont:getHeight(Text)
        local TW = TextFont:getWidth(Text)
            -- Coordinates for the text
        local textX = BoxX + (BoxW - TW) / 2  -- Center the text horizontally
        local textY = BoxY + (BoxH - TH) / 2        -- Center the text vertically
        love.graphics.print(Text, textX, textY)
    end
    local Selected = isMouseOverBox(BoxX, BoxY, BoxW, BoxH)    -- Check if mouse is over the box
    love.graphics.setLineWidth(MediumLine)
    if Selected then
        love.graphics.setColor(255, 255, 255) -- white
        love.graphics.line( BoxX, BoxY, BoxX+BoxW, BoxY) -- horizontal top
        love.graphics.line( BoxX, BoxY, BoxX, BoxY+BoxH) -- vertical left
        love.graphics.line( BoxX, BoxY+BoxH, BoxX+BoxW, BoxY+BoxH) -- horizontal bottom
        love.graphics.line( BoxX+BoxW, BoxY, BoxX+BoxW, BoxY+BoxH) -- vertical right
        love.graphics.setColor(0, 0, 0) -- black
        love.graphics.line( BoxX, BoxY, BoxX+BoxW, BoxY) -- horizontal top
        love.graphics.line( BoxX, BoxY, BoxX, BoxY+BoxH) -- vertical left
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
        love.graphics.setColor(255, 255, 255) -- white
        love.graphics.line( BoxX, BoxY, BoxX+BoxW, BoxY) -- horizontal top
        love.graphics.line( BoxX, BoxY, BoxX, BoxY+BoxH) -- vertical left
        love.graphics.setColor(0, 0, 0) -- black
        love.graphics.line( BoxX, BoxY+BoxH, BoxX+BoxW, BoxY+BoxH) -- horizontal bottom
        love.graphics.line( BoxX+BoxW, BoxY, BoxX+BoxW, BoxY+BoxH) -- vertical right
    end
    love.graphics.setColor(255, 255, 255)
    love.graphics.setLineWidth(1)
end
function N5BoxHighlight(BoxX, BoxY, BoxW, BoxH, fill, FillColor, Scaling)--Used to highlight a box like the X or <- in 95 style
    if BoxX==nil or BoxY==nil or BoxW==nil or BoxH==nil then
        print("In ButtonStyle1Mod3() BoxX is reporting as: "..tostring(BoxX))
        print("In ButtonStyle1Mod3() BoxY is reporting as: "..tostring(BoxY))
        print("In ButtonStyle1Mod3() BoxW is reporting as: "..tostring(BoxW))
        print("In ButtonStyle1Mod3() BoxH is reporting as: "..tostring(BoxH))
        return
    end
    if Scaling==true then
        BoxX=scaling(BoxX,1920,Settings.XRes)
        BoxY=scaling(BoxY,1080,Settings.YRes)
        BoxW=scaling(BoxW,1920,Settings.XRes)
        BoxH=scaling(BoxH,1080,Settings.YRes)
    end
    if fill==true then
        love.graphics.setColor(FillColor[1],FillColor[2],FillColor[3])
        love.graphics.rectangle("fill", BoxX, BoxY, BoxW, BoxH)
    end
    love.graphics.setLineWidth(MediumLine)
    love.graphics.setColor(255, 255, 255) -- white
    love.graphics.line( BoxX, BoxY+BoxH, BoxX+BoxW, BoxY+BoxH) -- horizontal bottom
    love.graphics.line( BoxX+BoxW, BoxY, BoxX+BoxW, BoxY+BoxH) -- vertical right
    love.graphics.setColor(0, 0, 0) -- black
    love.graphics.line( BoxX, BoxY, BoxX+BoxW, BoxY) -- horizontal top
    love.graphics.line( BoxX, BoxY, BoxX, BoxY+BoxH) -- vertical left
    love.graphics.setColor(255, 255, 255)
    love.graphics.setLineWidth(1)
end
