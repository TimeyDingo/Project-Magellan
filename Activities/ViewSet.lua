function ViewActivity()
    SetTitle, SetData = LoadIndividualSet(SetToPreview)
    CenterText(0,scaling(-450,1080,Settings[2]),SetTitle,Exo32Bold)
    love.graphics.setColor(40,40,40)
    love.graphics.rectangle("fill",scaling(940,1920,Settings[1]),scaling(130,1080,Settings[2]),scaling(40,1920,Settings[1]),scaling(950,1080,Settings[2]))
    love.graphics.setColor(255,255,255)
end