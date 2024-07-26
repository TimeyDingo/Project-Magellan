love.graphics.setColorF = love.graphics.setColor
function love.graphics.setColor(r,g,b,a) --! converting love2D shitty color space to rgb color
	r, g, b = r/255, g/255, b/255
	love.graphics.setColorF(r,g,b,a)
end
function isMouseOverBox(boxX, boxY, boxWidth, boxHeight)
    return MouseX >= boxX and MouseX <= boxX + boxWidth and MouseY >= boxY and MouseY <= boxY + boxHeight
end
function MapNumber(Number,InMin,InMax,OutMin,OutMax)
    local Map = (Number - InMin) / (InMax - InMin) * (OutMax - OutMin) + OutMin
    return Map
end