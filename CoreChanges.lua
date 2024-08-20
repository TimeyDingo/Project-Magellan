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
function IsClickInBox(ClickX,ClickY,boxX, boxY, boxWidth, boxHeight)
    return ClickX >= boxX and ClickX <= boxX + boxWidth and ClickY >= boxY and ClickY <= boxY + boxHeight
end
function MouseClickDebounce(DebouncePeriod)
    if love.mouse.isDown(1) and DebounceTimer>DebouncePeriod then
        DebounceTimer=0
        return true
    else
        return false
    end
end
function createToggleFlipFlop()
    local flipFlopState = false
    
    return function(pulse)
        if pulse then
            flipFlopState = not flipFlopState
        end
        return flipFlopState
    end
end
function toboolean(str)
    local bool = false
    if str == "true" then
        bool = true
    end
    return bool
end
function scaling(OriginalPos,OriginalResolution,NewResolution)
    return (OriginalPos*NewResolution)/OriginalResolution
end
function BackspaceController(String,HoldDelay)
    String=tostring(String)
    local Held
    if love.keyboard.isDown("backspace") then
        HeldTime=HeldTime+1
    else
        HeldTime=0
    end
    if love.keyboard.isDown("backspace") and DebounceTimer>5 and Held~=true then
        local byteoffset = utf8.offset(String, -1)
        if byteoffset then
            -- remove the last UTF-8 character.
            -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
            String = string.sub(String, 1, byteoffset - 1)
        end
        DebounceTimer=0
    end
    if HeldTime>HoldDelay then
        Held=true
        local byteoffset = utf8.offset(String, -1)
        if byteoffset then
            -- remove the last UTF-8 character.
            -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
            String = string.sub(String, 1, byteoffset - 1)
        end
    end
    return String
end
function ButtonDebounce(ButtonToDebounce, DebouncePeriod)
    if love.keyboard.isDown(ButtonToDebounce) and DebounceTimer>DebouncePeriod then
        DebounceTimer=0
        return true
    else
        return false
    end
end