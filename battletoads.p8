pico-8 cartridge // http://www.pico-8.com
version 27
__lua__

function _init()

  is_moving_forward = false
  speed = 1
  first_row = {}


  start_motion = false

  init_first_row()
end

function init_first_row()
  for i = 0, 7 do
    local w = 16
    local x1 = i * w
    local x2 = x1 + w
    add(first_row, { x1 = x1, w = w, x2 = x2 })
  end
end

function debug(str, x, y, c)
  print(str,x,y, c)
end

function _draw()
 	cls()
  palt(0, false) -- make black visible
  palt(15, true) -- make peach transparent
  draw_grid()

  -- draw top row
  for i = 1, #first_row do
    if is_moving_forward then
      first_row[i].x1 -= speed
    end

    spr(64, first_row[i].x1, 0, 2, 2)
  end

end

function draw_grid()
  -- draw grid
  for i = 0, 8 do
    line(i * 16, 0, i* 16, 128, 6)
    line (0, i * 16, 128, i * 16, 6)
  end
end

function _update()
  if (btn(➡️)) then
    is_moving_forward = true
  else
  -- speed = 0
    is_moving_forward = false
  end

  if is_moving_forward then
    -- update values
    for i = 1, #first_row do
      first_row[i].x2 = first_row[i].x1 + first_row[i].w
    end

    if (first_row[1].x2 < 0) then
      del(first_row, first_row[1])
    end

    if (first_row[#first_row].x2 <= 129) then -- extra pixel (129) so it adds out of view
      local x1 = first_row[#first_row - 1].x2
      add(first_row, { x1 = x1, w = 16, x2 = x1 + 16 })
    end
  end
end


__gfx__
00000000fffffffffff00fffffffffffffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
00000000fffffffff00bb00fffffffffffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
00700700ffffffff0bbbbbb00fffffffffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
00077000fffffff0bbbbbbbbb00fffffffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
00077000ffffff0bbbbb0bb77370ffffffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
00700700ffffff0bbbbb00070700ffffffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
00000000ffffff0bbbbbb00000ee0fffffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
00000000ffffff0bbbbbb08eee880fffffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
00000000ffffff00b00000e88880ffffffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
00000000fffff0b0000000e000000fffffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
00000000ffff03b0b0000b000bbb30000fffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
00000000fff03bb333000bb0003b00cc0fffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
00000000fff03bbbbb00b0b00000ccdd0fffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
00000000ff03bbbbb0b0003bb000cd0000ffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
00000000ff033bbb300b303bb30cd000dd0fffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
00000000ff03333300b30003b30cd0ddddd0ffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
00000000ff00333333b30003b3ccddddd00c0fff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000ff0d00003b30330300ddddd00cccc0ff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000f0dddd003b3000300000000ccccccc0f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000ddd0b0b3000000000000ddccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000ddddd30b300000bbbbb30ddddccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000ddddd30bbb3333bb30003ddddddccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000ddddc03bbbbbbb0003bb0ddddddddc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000f0000003333333333b0330ddddddd00f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000f0dd0003300000000330000000000fff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000ffcc00300303300030033dddc000ffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000fffdd000c00cc0000ddddddcffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000fff0dddd0ff0dd00000ddd00ffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000ffff000fffff0ddd000000ffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000fffffffffffff000ffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000ffffffffffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000ffffffffffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeee8000000000000000000000000000000088888888888888888888888888888888000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeee0080008000000000000000000800000888888888888888888888888888888888000000000000000000000000000000000000000000000000
0eeeeeeeeeeeeee00800080000008000800080800088008888888888888888888888888888888888000000000000000000000000000000000000000000000000
e0eeeeeeeeeeee0e8000808880888800080008088080808888888888888888888888888888888888000000000000000000000000000000000000000000000000
ee0eeeeeeeeee0ee8080880888088888880808880888080888888888888888888888888888888888000000000000000000000000000000000000000000000000
eee0eeeeeeee0eee8808088808888888888080808080808088888888888888888888888888888888000000000000000000000000000000000000000000000000
eeee00eeee00eeee8080808888888808080808088888888888888888888888888888888888888888000000000000000000000000000000000000000000000000
eeeeee0000eeeeee8888888888888888888888888888888888888888808080808088888888080808000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeee8888888888888888888888888888888808080808080808888888888088808088000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeee8888888888888888888888888088888880808880888080888888808880880808000000000000000000000000000000000000000000000000
0eeeeeeeeeeeeee08888888888888888888888888088888888080808808000800088880888080008000000000000000000000000000000000000000000000000
f0eeeeeeeeeeee0f8888888888888888888888888008888888008800080800080008000000800080000000000000000000000000000000000000000000000000
ff00eeeeeeee00ff8888888888888000088888888808888880000080000000000000000008000800000000000000000000000000000000000000000000000000
ffff0eeeeee0ffff8888888888880088000888888808888800000000000000000000000000000000000000000000000000000000000000000000000000000000
fffff000000fffff8888888888880888880088888088888800000000000000000000000000000000000000000000000000000000000000000000000000000000
ffffffffffffffff8888888888800888888088800088888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888800000008888888000008888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888008888008888888808888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888088888888888888880888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888088888888880888888088888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888088888808808088888088888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888888888800888808888808888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888888888880088888888808888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888888888888808888888088888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888888888888888888888088888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888888888888888888880888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888888888888888888888888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888888888888888888888888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888888888888888888888888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888888888888888888888888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888888888888888888888888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888888888888888888888888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
