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
        local line=file:read("*l")
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
function LUASetRead(SetToLoad)
    if SetToLoad==nil then
        print("In LUASetRead() SetToLoad is reporting as: "..tostring(SetToLoad))
        return
    end
    local filename = "SavedSets/Set" .. SetToLoad .. ".lua"
    local NumberofSets = GetSavedSetCount()
    if SetToLoad > NumberofSets then
        print("In LUASetRead() SetToLoad is greater then NumberofSets")
        return
    end
    local file = io.open(filename, "r")
    if file==nil then
        print("In LUASetRead() file is reporting as: "..tostring(file))
        return
    end
    local line
    line = file:read("*a")    
    file:close()
    if line then
        local actionFunc, err = load(line)
        if actionFunc then
            return actionFunc()
        else
            print("Error in action string: " .. err)
        end
    end
end
function LUASetWrite(SetToSave,SetTable)
    if SetToSave==nil or SetTable==nil then
        print("In LUAFileWrite() SetToSave is reporting as: "..tostring(SetToSave))
        print("In LUAFileWrite() SetTable is reporting as: "..tostring(SetTable))
        return
    end
    local filename = "SavedSets/Set" .. SetToSave .. ".lua"
    local file = io.open(filename, "w")
    if file==nil then
        print("In LUAFileWrite() file is reporting as: "..tostring(file))
        return
    end
    SaveString="return {\n".."Title=".."'"..SetTable.Title.."', "
    SaveString=SaveString.."Terms="..SetTable.Terms..",\n"
    for i = 1, SetTable.Terms do
        SaveString=SaveString.."{Term=".."'"..SetTable[i].Term.."',"
        SaveString=SaveString.."Definition=".."'"..SetTable[i].Definition.."',"
        SaveString=SaveString.."UserSeenTimes="..SetTable[i].UserSeenTimes..","
        SaveString=SaveString.."UserCorrectTimes="..SetTable[i].UserCorrectTimes..","
        SaveString=SaveString.."Image="..tostring(SetTable[i].Image).."},"
    end
    SaveString=SaveString.."}"
    file:write(SaveString)
    file:close()
    SetDataCollated = LUALoadAllSets()
    NumberofSets=GetSavedSetCount()
    if SetToPreview then
        SetData = LUASetRead(SetToPreview)
    end
end
function CreateNewSet()
    Deleting=true
    local AmountOfSets=GetSavedSetCount()
    if AmountOfSets then
        
    end
    local BlankSet={Title=AmountOfSets+1, Terms=1, {Term=' ',Definition=' ',UserSeenTimes=0,UserCorrectTimes=0,Image=false}}
    LUASetWrite(AmountOfSets+1,BlankSet)
    --incriment set counter
    local SetCount=GetSavedSetCount()
    local filename = "SavedSets/Sets.lua"
    local file = io.open(filename, "w")
    if file==nil then
        print("In AddOneToSavedSetCount() file is reporting as: "..tostring(file))
        return
    end
    SaveString="return "..tostring(SetCount+1)
    file:write(SaveString)
    file:close()
    --
    SetToPreview=AmountOfSets
    NumberofSets=GetSavedSetCount()
    SetDataCollated = LUALoadAllSets()
    Deleting=false
end
function DeleteSet()
    if SetToPreview==nil then
        print("In DeleteSet() SetToPreview is reporting as: "..tostring(SetToPreview))
        return
    end
    Deleting=true
    local NumberofSets=GetSavedSetCount()
    if SetToPreview>NumberofSets then
        print("In DeleteSet() SetToPreview is larger then NumberofSets")
        return
    end
    local SetToRemove="SavedSets/Set" .. SetToPreview .. ".lua"
    local Removed=os.remove(SetToRemove)
    if Removed==true then
        --remove one from the set count
        local SetCount=GetSavedSetCount()
        local filename = "SavedSets/Sets.lua"
        local file = io.open(filename, "w")
        if file==nil then
            print("In RemoveOneFromSavedSetCount() file is reporting as: "..tostring(file))
            return
        end
        SaveString="return "..tostring(SetCount-1)
        file:write(SaveString)
        file:close()
        --
        for i=SetToPreview, NumberofSets do --update file titles if one is removed from the middle
            local NameToChange="SavedSets/Set" .. i .. ".lua"
            local Rename="SavedSets/Set" .. i-1 .. ".lua"
            local Renamed=os.rename(NameToChange, Rename)
        end
        SetToPreview=0
    end
    YScroll=0
    NumberofSets=GetSavedSetCount()
    SetDataCollated = LUALoadAllSets()
    Deleting=false
end
function GetSavedSetCount()
    local filename = "SavedSets/Sets.lua"
    local file = io.open(filename, "r")
    if file==nil then
        print("In GetSavedSetCount() file is reporting as: "..tostring(file))
        return
    end
    local line
    line = file:read("*a")    
    file:close()
    if line then
        local actionFunc, err = load(line)
        if actionFunc then
            return actionFunc()
        else
            print("Error in action string: " .. err)
        end
    end
end
function ImportAQuizletSet(Title, SetString)
    print(SetString)
    if Title == nil or SetString == nil then
        print("In ImportAQuizletSet() Title is reporting as: " .. tostring(Title))
        print("In ImportAQuizletSet() SetString is reporting as: " .. tostring(SetString))
        return
    end
    --? clean up text entry
    SetString = SetString:gsub("[%c]", " ") --? sub out control characters for blank spaces so new lines are gone, etc
    for i = 1, #SetString do
        local char = string.sub(SetString, i, i) --? get individual characters
        if (char == ";" or char == ":") and i < #SetString then
            local char2 = string.sub(SetString, i + 1, i + 1)
            local charback = string.sub(SetString, i - 1, i - 1)
            if char2 ~= char and charback~=char then
                SetString = string.sub(SetString, 1, i - 1) .. "|" .. string.sub(SetString, i + 1) --? replace individual ; or : with |
            end
        end
    end
    --
    --? convert text to proper format
    local DataToSave={Title=Title, Terms=0}
    if SetString then
        for item in SetString:gmatch("[^::]+") do
            local subData = {}
            for subItem in item:gmatch("[^;;]+") do
                table.insert(subData, subItem)
            end
            local PreSub={Term=subData[1],Definition=subData[2],UserSeenTimes=0,UserCorrectTimes=0,Image=false}
            table.insert(DataToSave, PreSub)
            DataToSave.Terms=DataToSave.Terms+1
        end
    end
    --
    CreateNewSet()
    local SetToOverwrite=GetSavedSetCount()
    LUASetWrite(SetToOverwrite,DataToSave)
end
function LUALoadAllSets()
    local Data={}
    local NumberofSets = GetSavedSetCount()
    if NumberofSets > 0 then
        for i = 1, NumberofSets do
            local Temp=LUASetRead(i)
            table.insert(Data,Temp)
        end
    end
    return Data
end