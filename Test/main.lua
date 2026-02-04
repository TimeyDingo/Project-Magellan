function love.load()
    LargeBodyFontBold=love.graphics.newFont("Fonts/Exo2-Bold.ttf", 28)
end
function love.update(dt)

end
function love.draw()
    H=love.graphics.getHeight()
    W=love.graphics.getWidth()
    x, y = love.mouse.getPosition( )
    down = love.mouse.isDown(1)
    x=tostring(x)
    y=tostring(y)
    down=tostring(down)
    Test=x..","..y..","..down
    CenterText(0,0,Test,LargeBodyFontBold)
end

function CenterText(X,Y,Text,TextFont)
    love.graphics.setFont(TextFont)
    if Text==nil or TextFont==nil or X==nil or Y==nil then
        print("In CenterText() X is reporting as: "..tostring(X))
        print("In CenterText() Y is reporting as: "..tostring(Y))
        print("In CenterText() Text is reporting as: "..tostring(Text))
        print("In CenterText() TextFont is reporting as: "..tostring(TextFont))
        return
    end
    local TW=TextFont:getWidth(Text)
    local TH=TextFont:getHeight(Text)
    love.graphics.print(Text,((W-TW)/2)+X,((H-TH)/2)+Y)--Screen Width minus text width divided by 2 + change in x
end