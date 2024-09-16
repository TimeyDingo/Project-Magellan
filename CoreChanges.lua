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
function BackspaceController(String,HoldDelay, ShortHoldDelay)
    String=tostring(String)
    local Held
    if love.keyboard.isDown("backspace") then
        HeldTime=HeldTime+love.timer.getDelta()
    else
        HeldTime=0
    end
    if ShortHoldDelay==nil then
        ShortHoldDelay=0.1
    end
    if love.keyboard.isDown("backspace") and DebounceTimer>ShortHoldDelay and Held~=true then
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
function generateUniqueNumbersExclude(count, maxValue, exclude)
    local uniqueNumbers = {}
    local uniqueList = {}
    
    while #uniqueList < count do
        local num = math.random(1, maxValue)
        
        if num ~= exclude and not uniqueNumbers[num] then
            uniqueNumbers[num] = true
            table.insert(uniqueList, num)
        end
    end
    
    return uniqueList
end
function generateUniqueNumbers(count, maxValue)
    local uniqueNumbers = {}
    local uniqueList = {}
    
    while #uniqueList < count do
        local num = math.random(1, maxValue)
        
        if not uniqueNumbers[num] then
            uniqueNumbers[num] = true
            table.insert(uniqueList, num)
        end
    end
    
    return uniqueList
end
function ShuffleTableCopy(original)
    -- Create a new table and copy the contents of the original table
    local copy = {}
    for i, v in ipairs(original) do
        copy[i] = v
    end
    
    -- Shuffle the new table
    local n = #copy
    for i = n, 2, -1 do
        local j = math.random(i)
        copy[i], copy[j] = copy[j], copy[i]
    end
    
    return copy
end
function SmudgeColor(colorA, colorB, percent)
    local r, g, b = colorA.r-(colorA.r-colorB.r)*percent, colorA.g-(colorA.g-colorB.g)*percent, colorA.b-(colorA.b-colorB.b)*percent
    return {r=r,g=g,b=b}
  end
   