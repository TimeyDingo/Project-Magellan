function EditActivity()
    if EditActivityLoadOnce==false then
        SetTitle, SetData = LoadIndividualSet(SetToPreview)
        EditActivityLoadOnce=true
    end
    CenterText(0,0,SetTitle,Exo24)
end