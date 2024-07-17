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
function AddOneToSavedSetCount()
    local file = io.open("SavedSets/Sets.txt", "r+")
    local NumberofSets = 0
    
    if file then
        NumberofSets = file:read("*n") or 0
        file:seek("set")  -- Move file pointer back to the beginning for writing
    else
        file = io.open("SavedSets/Sets.txt", "w")  -- Create file if it doesn't exist
    end
    
    file:write(NumberofSets + 1)
    io.close(file)
end
function ImportAQuizletSet(Title, SetData)
    local CurrentSetCount=0
    local CurrentSetCount=CheckSavedSets()
    local NewFileName="SavedSets/Set" .. (CurrentSetCount + 1) .. ".txt"
    local file=io.open(NewFileName,"w")
    local TextToWrite=Title.."--"..SetData
    file:write(TextToWrite)
    io.close(file)
    AddOneToSavedSetCount()
end
