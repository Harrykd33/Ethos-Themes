-- Apply the registered Ethos toolbar bitmap to older KevD header layouts.
local bridge = assert(loadfile("SCRIPTS:/Themes/header_bridge.lua"))()
return function(boxes, background)
    local image = bridge.getToolbarBackground()
    if not image then return end
    local banner = boxes[2]
    banner.col, banner.colspan = 1, 7
    banner.type, banner.subtype = "func", "func"
    banner.bgcolor = background
    banner.paint = function(x, y, w, h)
        w = lcd.getWindowSize() - x
        lcd.color(background)
        lcd.drawFilledRectangle(x, y, w, h)
        lcd.drawBitmap(x, y, image, w, h)
    end
    boxes[1], boxes[2] = banner, boxes[1]
    for i = 2, #boxes do boxes[i].bgcolor = "transparent" end
end
