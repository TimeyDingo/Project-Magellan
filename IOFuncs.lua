function SaveSettings(Settings)
    local file = io.open("Settings.txt", "w")
    if file then--? Check if successful open
        for i, value in ipairs(Settings) do
            file:write(value .. "\n")--? each indice to new line
        end
        file:close() -- Close the file
        return 1--?Success!
    else
        return 0--?Error!
    end
end
function LoadSettings(Settings)
    local file = io.open("Settings.txt", "r")
    if file then
        local index = 1
        for line in file:lines() do
            Settings[index] = tonumber(line) or line -- Store the value in the Settings table
            index = index + 1
        end
        file:close()
        return 1 -- Success
    else
        return 0 -- Error
    end
end
function CheckSavedSets()
    local file=io.open("SavedSets/Sets.txt", "r")
    local NumberofSets=0
    if file then
        NumberofSets=file:read("n")
    end
    io.close(file)
    return NumberofSets
end