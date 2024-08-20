function SaveSettings(Settings)
    local file = io.open("Settings.txt", "w")
    if file then--? Check if successful open
        for i, value in ipairs(Settings) do
            file:write(tostring(value) .. "\n")--? each indice to new line
        end
        file:close() -- Close the file
        return 1--?Success!
    else
        return 0--?Error!
    end
end
function LoadSettingsIO(Settings)
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
function RemoveOneFromSavedSetCount()
    local file = io.open("SavedSets/Sets.txt", "r+")
    local NumberofSets = 0
    
    if file then
        NumberofSets = file:read("*n") or 0
        file:seek("set")  -- Move file pointer back to the beginning for writing
    else
        file = io.open("SavedSets/Sets.txt", "w")  -- Create file if it doesn't exist
    end
    
    file:write(NumberofSets - 1)
    io.close(file)
end
function ImportAQuizletSet(Title, SetData)
    local CurrentSetCount=0
    CurrentSetCount=CheckSavedSets()
    local NewFileName="SavedSets/Set" .. (CurrentSetCount + 1) .. ".txt"
    local file=io.open(NewFileName,"w")
    local TextToWrite=Title.."--"..SetData
    file:write(TextToWrite)
    io.close(file)
    AddOneToSavedSetCount()
end
function LoadSavedSetsIntoMemory()
    local NumberofSets = CheckSavedSets()
    local SetData = {}
    if NumberofSets > 0 then
        for i = 1, NumberofSets do
            local Filename = "SavedSets/Set" .. i .. ".txt"
            local file = io.open(Filename, "r")
            if file then
                local line = file:read("*l") -- Read the first line
                file:close()

                if line then
                    local title, data = line:match("^(.-)%-%-(.+)$")
                    local dataSet = {}

                    if data then
                        for item in data:gmatch("[^::]+") do
                            local subData = {}
                            for subItem in item:gmatch("[^;;]+") do
                                table.insert(subData, subItem)
                            end
                            table.insert(dataSet, subData)
                        end
                    end

                    table.insert(SetData, {title, dataSet})
                end
            end
        end
    end
    return SetData
    --[[
    SetData = {
    { 
        "Set1Title", 
        {
            { "Item1.1", "Item1.2" }, 
            { "Item2.1", "Item2.2" }
        }
    },
    { 
        "Set2Title", 
        {
            { "ItemA.1", "ItemA.2", "ItemA.3" }, 
            { "ItemB.1" }
        }
    }
        ]]
    --https://chatgpt.com/c/1103cb13-78ec-4355-ba4b-3ac590cb4d2c
end
function SaveSetsToFile(SetData, Filename)
    local file = io.open(Filename, "w")
    if not file then
        error("Could not open file for writing: " .. Filename)
    end

    for _, set in ipairs(SetData) do
        local title = set[1]
        local dataSet = set[2]
        local dataStrings = {}

        for _, data in ipairs(dataSet) do
            table.insert(dataStrings, table.concat(data, ";;"))
        end

        local line = title .. "--" .. table.concat(dataStrings, "::")
        file:write(line .. "\n")
    end

    file:close()
end
function LoadIndividualSet(SetToLoad)
    local filename = "SavedSets/Set" .. SetToLoad .. ".txt"
    local SetData = {}
    local Title
    local Num=0
    local NumberofSets = CheckSavedSets()
    if SetToLoad > NumberofSets then
        return nil
    end
    local file = io.open(filename, "r")
    if file then
        local line = file:read("*l")
        file:close()
        if line then
            local title, data = line:match("^(.-)%-%-(.+)$")
            Title=title
            if data then
                for item in data:gmatch("[^::]+") do
                    local subData = {}
                    for subItem in item:gmatch("[^;;]+") do
                        table.insert(subData, subItem)
                    end
                    table.insert(SetData, subData)
                    Num=Num+1
                end
            end
        end
    end
    return Title, SetData, Num
end
function SaveIndividualSet(SetTitle, SetDataTable, SetToSave)
    local filename = "SavedSets/Set" .. SetToSave .. ".txt"
    local file = io.open(filename, "w")
    if file then
        local dataToSave = SetTitle .. "--"
        for i, subData in ipairs(SetDataTable) do
            dataToSave = dataToSave .. table.concat(subData, ";;")
            if i < #SetDataTable then
                dataToSave = dataToSave .. "::"
            end
        end
        file:write(dataToSave)
        file:close()
        return true
    else
        return false
    end
end

function DeleteSet()
    Deleting=true
    local NumberofSets=CheckSavedSets()
    local SetToRemove="SavedSets/Set" .. SetToPreview .. ".txt"
    os.remove(SetToRemove)
    RemoveOneFromSavedSetCount()
    for i=SetToPreview, NumberofSets do
        local NameToChange="SavedSets/Set" .. i .. ".txt"
        local Rename="SavedSets/Set" .. i-1 .. ".txt"
        os.rename(NameToChange, Rename)
    end
    SetToPreview=0
    --os.rename (oldname, newname)
    --SetToPreview=0
    Deleting=false
end
function CreateNewSet()
    Deleting=true
    local AmountOfSets=CheckSavedSets()
    local BlankSet={{"Definition","Term"}}
    SaveIndividualSet("Title Here", BlankSet, AmountOfSets+1)
    AddOneToSavedSetCount()
    SetToPreview=CheckSavedSets()
    StateMachine ="Edit"
    Deleting=false
end