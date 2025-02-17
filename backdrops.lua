function N5MainMenu()
    love.graphics.setColor(56,110,110)
    love.graphics.rectangle("fill",0,0,scaling(1920,1920,Settings.XRes),scaling(1080,1080,Settings.YRes))
    N5BoxHighlight(244, 79, 1431, 922, true, {195,199,203}, true,SExo24,"",true)
    love.graphics.setColor(0,0,170)
    love.graphics.rectangle("fill",scaling(253,1920,Settings.XRes),scaling(89,1080,Settings.YRes),scaling(1414,1920,Settings.XRes),scaling(63,1080,Settings.YRes))
    love.graphics.setColor(244,244,244)
    CenteredTextBox(scaling(270,1920,Settings.XRes),scaling(89,1080,Settings.YRes),scaling(1414,1920,Settings.XRes),scaling(63,1080,Settings.YRes),"Magellan Offline Study System",SmallHeaderBold,false,"left")
end
function N5SelectMenu()
    love.graphics.setColor(56,110,110)
    love.graphics.rectangle("fill",0,0,scaling(1920,1920,Settings.XRes),scaling(1080,1080,Settings.YRes))
    N5BoxHighlight(244, 79, 1431, 922, true, {195,199,203}, true,SExo24,"",true)
    love.graphics.setColor(0,0,170)
    love.graphics.rectangle("fill",scaling(253,1920,Settings.XRes),scaling(89,1080,Settings.YRes),scaling(1414,1920,Settings.XRes),scaling(63,1080,Settings.YRes))
    love.graphics.setColor(244,244,244)
    CenteredTextBox(scaling(270,1920,Settings.XRes),scaling(89,1080,Settings.YRes),scaling(1414,1920,Settings.XRes),scaling(63,1080,Settings.YRes),"Main Menu > Select Activity",SmallHeaderBold,false,"left",{{244,244,244,1},"Main Menu ",{0.949, 0.733, 0.020,1},">",{244,244,244,1}," Select Activity"})
end
function N5SettingMenu()
    love.graphics.setColor(56,110,110)
    love.graphics.rectangle("fill",0,0,scaling(1920,1920,Settings.XRes),scaling(1080,1080,Settings.YRes))
    N5BoxHighlight(244, 79, 1431, 922, true, {195,199,203}, true,SExo24,"",true)
    love.graphics.setColor(0,0,170)
    love.graphics.rectangle("fill",scaling(253,1920,Settings.XRes),scaling(89,1080,Settings.YRes),scaling(1414,1920,Settings.XRes),scaling(63,1080,Settings.YRes))
    love.graphics.setColor(244,244,244)
    CenteredTextBox(scaling(270,1920,Settings.XRes),scaling(89,1080,Settings.YRes),scaling(1414,1920,Settings.XRes),scaling(63,1080,Settings.YRes),"Main Menu > Select Activity",SmallHeaderBold,false,"left",{{244,244,244,1},"Main Menu ",{0.949, 0.733, 0.020,1},">",{244,244,244,1}," Settings"})
end
function N5ImportMenu()
    love.graphics.setColor(56,110,110)
    --background
    love.graphics.rectangle("fill",0,0,scaling(1920,1920,Settings.XRes),scaling(1080,1080,Settings.YRes))
    N5BoxHighlight(450, 79, 1431, 922, true, {195,199,203}, true,SExo24,"",true)
    --blue box
    love.graphics.setColor(0,0,170)
    love.graphics.rectangle("fill",scaling(459,1920,Settings.XRes),scaling(89,1080,Settings.YRes),scaling(1414,1920,Settings.XRes),scaling(63,1080,Settings.YRes))
    love.graphics.setColor(244,244,244)
    --header
    CenteredTextBox(scaling(479,1920,Settings.XRes),scaling(89,1080,Settings.YRes),scaling(1414,1920,Settings.XRes),scaling(63,1080,Settings.YRes),"Main Menu > Import Quizlet Set",SmallHeaderBold,false,"left",{{244,244,244,1},"Main Menu ",{0.949, 0.733, 0.020,1},">",{244,244,244,1}," Import Quizlet Set"})
    --title area
    N5BoxWithTitle(670,183,992,106,true,"Set Title","")
    --set preview area
    N5BoxWithTitle(670,326,992,353,true,"Set Preview: CTRL-V Export","")
    --export settings area
    love.graphics.setColor(195,199,203)
    love.graphics.rectangle("fill",scaling(46,1920,Settings.XRes),scaling(229,1080,Settings.YRes),scaling(357,1920,Settings.XRes),scaling(297,1080,Settings.YRes))
    N5BoxWithTitle(46,229,357,297,true,"","1.Between term and definition is set as custom ;; \n2.Between rows is set as custom ::")
    love.graphics.setColor(0,0,170)
    love.graphics.rectangle("fill",scaling(46,1920,Settings.XRes)-MediumLine,scaling(169,1080,Settings.YRes),scaling(357,1920,Settings.XRes)+MediumLine*2,scaling(63,1080,Settings.YRes))
    love.graphics.setColor(244,244,244)
    CenteredTextBox(scaling(46,1920,Settings.XRes)-MediumLine,scaling(169,1080,Settings.YRes),scaling(357,1920,Settings.XRes)+MediumLine*2,scaling(63,1080,Settings.YRes),"Export Settings",SmallHeaderBold,false)
    love.graphics.setColor(244,244,244)
end
function N5GameBar(Game)
    --background
    love.graphics.setColor(195,199,203)
    love.graphics.rectangle("fill",0,0,scaling(1920,1920,Settings.XRes),scaling(1080,1080,Settings.YRes))
    --blue box
    love.graphics.setColor(0,0,170)
    love.graphics.rectangle("fill",0,0,scaling(1920,1920,Settings.XRes),scaling(86,1080,Settings.YRes))
    love.graphics.setColor(244,244,244)
    --header
    CenteredTextBox(0,0,scaling(1920,1920,Settings.XRes),scaling(86,1080,Settings.YRes),
    "Main Menu > Select Activity > "..Game,SmallHeaderBold,false,"left",
    {{244,244,244,1},"Main Menu ",{0.949, 0.733, 0.020,1},">",{244,244,244,1}," Select Activity ",{0.949, 0.733, 0.020,1},"> ",{244,244,244,1},Game})
end