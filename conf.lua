function love.conf(t)
    t.window.title = "M.O.S.S"
    t.window.icon = nil
    t.window.width = 1024
    t.window.height = 576
    t.window.borderless = false
    t.window.resizable = false
    t.window.msaa = 2
    t.window.fullscreen=false
    t.console = true
    t.highdpi = false
    t.graphics.lowpower = true
    
    
    t.modules.joystick = false
    t.modules.physics = false
    t.modules.touch = true
    t.modules.video = true
end