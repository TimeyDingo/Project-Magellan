function SaveSettings(Settings)
    local file = io.open("Settings.txt", "w")
    if file then
        -- Write each setting in the format key=value
        file:write("XRes=" .. tostring(Settings.XRes) .. "\n")
        file:write("YRes=" .. tostring(Settings.YRes) .. "\n")
        file:write("MSAA=" .. tostring(Settings.MSAA) .. "\n")
        file:write("Fullscreen=" .. tostring(Settings.Fullscreen) .. "\n")
        file:write("FontModRaw=" .. tostring(Settings.FontModRaw) .. "\n")
        file:write("FontModPercent=" .. tostring(Settings.FontModPercent) .. "\n")
        file:write("LineModifier=" .. tostring(Settings.LineModifier) .. "\n")
        file:write("AudioRaw=".. tostring(Settings.AudioRaw) .. "\n")
        file:write("AudioPercent=".. tostring(Settings.AudioPercent) .. "\n")
        file:write("DarkMode=".. tostring(Settings.DarkMode) .. "\n")
        file:write("ReducedFlicker=".. tostring(Settings.ReducedFlicker) .. "\n")
        file:write("FontSelected=".. tostring(Settings.FontSelected) .. "\n")
        file:close() -- Close the file
        return 1 -- Success
    else
        return 0 -- Error
    end
end
function LoadSettingsIO(Settings)
    local file = io.open("Settings.txt", "r")
    if file then
        line=file:read("*l")
        Settings.XRes=tonumber(line:match("=(.+)"))
        line=file:read("*l")
        Settings.YRes=tonumber(line:match("=(.+)"))
        line=file:read("*l")
        Settings.MSAA=tonumber(line:match("=(.+)"))
        line=file:read("*l")
        Settings.Fullscreen=toboolean(line:match("=(.+)"))
        line=file:read("*l")
        Settings.FontModRaw=tonumber(line:match("=(.+)"))
        line=file:read("*l")
        Settings.FontModPercent=tonumber(line:match("=(.+)"))
        line=file:read("*l")
        Settings.LineModifier=tonumber(line:match("=(.+)"))
        line=file:read("*l")
        Settings.AudioRaw=tonumber(line:match("=(.+)"))
        line=file:read("*l")
        Settings.AudioPercent=tostring(line:match("=(.+)"))
        line=file:read("*l")
        Settings.DarkMode=toboolean(line:match("=(.+)"))
        line=file:read("*l")
        Settings.ReducedFlicker=toboolean(line:match("=(.+)"))
        line=file:read("*l")
        Settings.FontSelected=tostring(line:match("=(.+)"))
        file:close()
        return 1 -- Success
    else
        print("Error in LoadSettingsIO, file could not be opened")
        return 0 -- Error: file couldn't be opened
    end
end
function CheckSavedSets()
    local file=io.open("SavedSets/Sets.txt", "r")
    if file==nil then
        print("In CheckSavedSets() file is reporting as: "..tostring(file))
        return
    end 
    local NumberofSets=0
    NumberofSets=file:read("n")
    io.close(file)
    local Confirmation=false
    local TrueAmount=0
    Confirmation, TrueAmount=ConfirmAmountOfSetsIsValid(NumberofSets)
    if Confirmation==true then
        return NumberofSets
    end
    if Confirmation==false then
        print("In CheckSavedSets() amount of sets is reporting as: "..tostring(NumberofSets))
        print("In CheckSavedSets() trueamount of sets is reporting as: "..tostring(TrueAmount))
        file=io.open("SavedSets/Sets.txt", "w")
        if file then
            file:write(tonumber(TrueAmount))
            io.close(file)
        end
        return TrueAmount
    end
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
        file:write(NumberofSets - 1)
    end
    io.close(file)
end
function ImportAQuizletSet(Title, SetData)
    if Title == nil or SetData == nil then
        print("In ImportAQuizletSet() Title is reporting as: " .. tostring(Title))
        print("In ImportAQuizletSet() SetData is reporting as: " .. tostring(SetData))
        return
    end
    --?? string processing to remove newlines and errant ; or :
    SetData = SetData:gsub("[%c]", " ")
    for i = 1, #SetData do
        local char = string.sub(SetData, i, i)
        if (char == ";" or char == ":") and i < #SetData then
            local char2 = string.sub(SetData, i + 1, i + 1)
            local charback = string.sub(SetData, i - 1, i - 1)
            if char2 ~= char and charback~=char then
                SetData = string.sub(SetData, 1, i - 1) .. "|" .. string.sub(SetData, i + 1)
            end
        end
    end
    local CurrentSetCount = 0
    CurrentSetCount = CheckSavedSets()
    local NewFileName = "SavedSets/Set" .. (CurrentSetCount + 1) .. ".txt"
    local file = io.open(NewFileName, "w")
    local TextToWrite = Title .. "--" .. SetData
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
    if SetData==nil or Filename==nil then
        print("In SaveSetsToFile() SetData is reporting as: "..tostring(SetData))
        print("In SaveSetsToFile() Filename is reporting as: "..tostring(Filename))
        return
    end
    local file = io.open(Filename, "w")
    if file==nil then
        print("In SaveSetsToFile() file is reporting as: "..tostring(file))
        return
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
    if SetToLoad==nil then
        print("In LoadIndividualSet() SetToLoad is reporting as: "..tostring(SetToLoad))
        return
    end
    local filename = "SavedSets/Set" .. SetToLoad .. ".txt"
    local SetData = {}
    local Title
    local Num=0
    local NumberofSets = CheckSavedSets()
    if SetToLoad > NumberofSets then
        print("In LoadIndividualSet() SetToLoad is greater then NumberofSets")
        return
    end
    local file = io.open(filename, "r")
    if file==nil then
        print("In LoadIndividualSet() file is reporting as: "..tostring(file))
        return
    end
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
    return Title, SetData, Num
end
function SaveIndividualSet(SetTitle, SetDataTable, SetToSave)
    if SetTitle==nil or SetDataTable==nil or SetToSave==nil then
        print("In SaveIndividualSet() SetTitle is reporting as: "..tostring(SetTitle))
        print("In SaveIndividualSet() SetDataTable is reporting as: "..tostring(SetDataTable))
        print("In SaveIndividualSet() SetToSave is reporting as: "..tostring(SetToSave))
        return
    end
    local filename = "SavedSets/Set" .. SetToSave .. ".txt"
    local file = io.open(filename, "w")
    if file==nil then
        print("In SaveIndividualSet() file is reporting as: "..tostring(file))
        return
    end
    local dataToSave = SetTitle .. "--"
    for i, subData in ipairs(SetDataTable) do
        dataToSave = dataToSave .. table.concat(subData, ";;")
        if i < #SetDataTable then
            dataToSave = dataToSave .. "::"
        end
    end
    file:write(dataToSave)
    file:close()
end
function DeleteSet()
    if SetToPreview==nil then
        print("In DeleteSet() SetToPreview is reporting as: "..tostring(SetToPreview))
        return
    end
    Deleting=true
    local NumberofSets=CheckSavedSets()
    if SetToPreview>NumberofSets then
        print("In DeleteSet() SetToPreview is larger then NumberofSets")
        return
    end
    local SetToRemove="SavedSets/Set" .. SetToPreview .. ".txt"
    local Removed=os.remove(SetToRemove)
    if Removed==true then
        RemoveOneFromSavedSetCount()
        for i=SetToPreview, NumberofSets do
            local NameToChange="SavedSets/Set" .. i .. ".txt"
            local Rename="SavedSets/Set" .. i-1 .. ".txt"
            local Renamed=os.rename(NameToChange, Rename)
        end
        SetToPreview=0
    end
    YScroll=0
    Deleting=false
end
function CreateNewSet()
    Deleting=true
    local AmountOfSets=CheckSavedSets()
    local BlankSet={{"Definition","Term"}}
    SaveIndividualSet("Title Here", BlankSet, AmountOfSets+1)
    AddOneToSavedSetCount()
    SetToPreview=CheckSavedSets()
    Deleting=false
end
function ConfirmAmountOfSetsIsValid(NumOfSets)
    local TrueAmount=0
    for i=1, NumOfSets do
        local Filename="SavedSets/Set"..i..".txt"
        if file_exists(Filename)==false then
            return false, TrueAmount
        else
            TrueAmount=TrueAmount+1
        end
    end
    return true, TrueAmount
end
function file_exists(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
 end