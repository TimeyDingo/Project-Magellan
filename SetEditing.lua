function SetOptionsMenu(SelectedSet)
    CenterText(0,-20,"SetOptionsMenu",Exo24)
    local SetTitle, SetData={}
    SetTitle, SetData = LoadIndividualSet(SelectedSet)
    CenterText(0,20,SetTitle,Exo24Bold)
end