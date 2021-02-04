pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

function _init()

  is_moving_forward = true
  top_bg_speed = 6
  middle_bg_speed = 5
  land_speed = 8
  land_top = {}
  land_bottom = {}
  top_startX = 0
  middle_startX = 0
  bottom_startX = 0

  create_land()

  player = {
    x = 8,
    y = 70,
    spr = 1,
    size = 4,
    vy = 2
  }
end

function debug(str, x, y, c)
  print(str, x, y, c)
end

function _draw()
 	cls()
  palt(0, false) -- make black visible
  palt(1, true) -- make darkblue transparent

  -- draw_grid()

  for i = 0, 7 do
    -- top row 16x16
    spr(64, i * 16 + top_startX, 0, 2, 2)
    spr(64, i * 16 + top_startX + 128, 0, 2, 2)

    -- second row 32x32
    spr(66, i * 32 + top_startX, 16, 4, 4)

    -- third row 32x16
    spr(70, i * 32 + top_startX, 48, 4, 2)

    -- static middle row
    spr(96, i * 16, 64, 2, 2)
  end

  -- reset
  if (top_startX <= -128) top_startX = 0
  if (top_endX <= 0) top_endX = 128

  -- draw land
  draw_land()

  -- draw player
  spr(player.spr, player.x, player.y + sin(time() * 2) * 3, player.size, player.size)

  -- draw player shadow
  if land_top[1].x1 < 0 and land_top[#land_top].x1 > 0 then
    spr(9, player.x + 2, player.y + 32, 2, 2)
  end

  -- debug
  -- debug(startX, 0, 98, 7)
end

function draw_grid()
  -- draw grid
  for i = 0, 8 do
    line(i * 16, 0, i* 16, 128, 6)
    line (0, i * 16, 128, i * 16, 6)
  end
end

function create_land()
  for i = 0, 10 do
    add(land_top, { x1 = i * 32, w= 32, x2 = i * 32 + 32})
    add(land_bottom, { x1 = i * 32, w= 32, x2 = i * 32 + 32})
  end
end

function reset_land()
  for i = 1, #land_top do
    local start = i * 32 + 128
    land_top[i].x1 = start
    land_top[i].x2 = land_top[i].x1 + 32
    land_bottom[i].x1 = start
    land_bottom[i].x2 = land_top[i].x1 + 32
  end
end

function draw_land()
  for i = 1, #land_top do
    if is_moving_forward then
      land_top[i].x1 -= land_speed
      land_bottom[i].x1 -= land_speed
    end

    if i == 1 then
      spr(192, land_top[i].x1, 64, 4, 4) -- top end
      spr(232, land_bottom[i].x1, 96, 4, 2) -- bottom end
    elseif i == #land_top then
      spr(192, land_top[i].x1, 64, 4, 4, true) -- top end
      spr(232, land_bottom[i].x1, 96, 4, 2, true) -- bottom end
    else
    spr(196, land_top[i].x1, 64, 4, 4) -- top middle
    spr(200, land_bottom[i].x1, 96, 4, 2) -- bottom middle
    end
  end
end
end


function _update()
  top_startX -= top_bg_speed
  top_endX -= top_bg_speed

  if btn(2) and player.y + 6 > 38 then -- up
  -- + 6 so it looks like the player is driving close to the top edge
    player.y -= player.vy
  end

  if btn(3) and player.y < 72 then -- down
    player.y += player.vy
  end

  -- update land
  if is_moving_forward then
    for i = 1, #land_top do
      set_new_x2(land_top, i)
      set_new_x2(land_bottom, i)
    end

    if (is_offscreen_left(land_top[#land_top].x2)) reset_land()

  end -- end is_moving_forward
end

function add_bg_spr_to_end(tbl, w)
  local x1 = tbl[#tbl - 1].x2
  add(tbl, { x1 = x1, w = w, x2 = x1 + w })
end


function should_add_bg_spr(x)
  -- 148 smoother addition since it's out of view
  return x <= 148
end

function del_first_value(tbl)
  del(tbl, tbl[1])
end

function is_offscreen_left(x)
  return x <= 0
end

function set_new_x2(tbl, idx)
    tbl[idx].x2 = tbl[idx].x1 + tbl[idx].w
end

__gfx__
00000000111111111110011111111111111111111111111111100111111111111111111111144444444441111111111111111111000000000000000000000000
0000000011111111100bb001111111111111111111111111100bb001111111111111111114444444444444411111111111111111000000000000000000000000
00700700111111110bbbbbb00111111111111111111111110bbbbbb0011111111111111144444444444444441111111111111111000000000000000000000000
0007700011111111bbbbbbbbb00111111111111111111111bbbbbbbbb00111111111111114444444444444411111111111111111000000000000000000000000
0007700011111110bbbb0bb7737011111111111111111110bbbb0bb7737011111111111111144444444441111111111111111111000000000000000000000000
0070070011111110bbbb0007070011111111111111111110bbbb0007070011111111111111111111111111111111111111111111000000000000000000000000
0000000011111110bbbbb00000ee01111111111111111110bbbbb00000ee01111111111111111111111111111111111111111111000000000000000000000000
0000000011111110bbbbb08eee8801111111111111111110bbbbb08eee8801111111111111111111111111111111111111111111000000000000000000000000
0000000011111100b00000e8888011111111111111111100b00000e8888011111111111111111111111111111111111111111111000000000000000000000000
00000000111110b0000000e00000011111111111111110b0000000e0000001101111111111111111111111111111111111111111000000000000000000000000
00000000111103b0b0000b000bbb300001111111111103b0b0000b000bbb300c0111111111111111111111111111111111111111000000000000000000000000
0000000011103bb333000bb0003b00cc0111111111103bb333000bb0003b00ccc001111111111111111111111111111111111111000000000000000000000000
0000000011103bbbbb00b0b00000ccdd0111111111103bbbbb00b0b00000ccccc0c0111111111111111111111111111111111111000000000000000000000000
000000001103bbbbb0b0003bb000cd00001111111103bbbbb0b0003bb000cccc0ccc011111111111111111111111111111111111000000000000000000000000
0000000011033bbb300b303bb30cd000dd01111111033bbb300b303bb30dccc0ccccc01111111111111111111111111111111111000000000000000000000000
000000001103333300b30003b30cd0ddddd011111103333300b30003b30ddc0ccccccc0111111111111111111111111111111111000000000000000000000000
000000001100333333b30003b3ccddddd00c01111100333333b30003b3dd000cccccccc011111111111111111111111111111111000000000000000000000000
00000000110d00003b30330300ddddd00cccc011110300003b303303000dd0d00000000111111111111111111111111111111111000000000000000000000000
0000000010dddd003b3000300000000ccccccc0110dddc00000000000dddd0ddddddd01111111111111111111111111111111111000000000000000000000000
0000000000ddd0b0b3000000000000ddccccccc000ddd00000000ddddddd0ddddddd011111111111111111111111111111111111000000000000000000000000
000000000ddddd30b300000bbbbb30ddddccccc00ddd00000dddddddddd0dddd0000111111111111111111111111111111111111000000000000000000000000
000000000ddddd30bbb3333bb30003ddddddccc00dd0000dcccddddd000ddd00dd01111111111111111111111111111111111111000000000000000000000000
000000000ddddc03bbbbbbb0003bb0ddddddddc00ddddddcc00cccdd000000ddd011111111111111111111111111111111111111000000000000000000000000
0000000010000003333333333b0330ddddddd001000000000ccccccdd000dddd0111111111111111111111111111111111111111000000000000000000000000
0000000010dd00033000000003300000000001111000000000ccc00ddd0000001111111111111111111111111111111111111111000000000000000000000000
0000000011cc00300303300030033dddc0001111111dddd00000000ccdd000011111111111111111111111111111111111111111000000000000000000000000
00000000111dd000c00cc0000ddddddc111111111110ddddddd011100ddd00111111111111111111111111111111111111111111000000000000000000000000
000000001110dddd0110dd00000ddd0d1111111111110ccddd011111100001111111111111111111111111111111111111111111000000000000000000000000
000000001111000111110ddd0000001111111111111110ddd0111111111111111111111111111111111111111111111111111111000000000000000000000000
00000000111111111111100011111111111111111111110001111111111111111111111111111111111111111111111111111111000000000000000000000000
00000000111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111000000000000000000000000
00000000111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111000000000000000000000000
222222222222222280000000000000000000000000000000888e8808888888888888888888808888000000000000000000000000000000000000000000000000
2222e2222222e2220080008000000000000000000800000888e88088808888e8ee80888888088ee8000000000000000000000000000000000000000000000000
02022222222e2020080008000000800080008080008800888e8808880888008e880888008808e888000000000000000000000000000000000000000000000000
202020222ee2220280008088808888000800080880808088888808888800880800888088008e8888000000000000000000000000000000000000000000000000
2e02022eee2220e28080880888088808880808880888080888888088888888808888888888888888000000000000000000000000000000000000000000000000
e02022022222020e8808088808888088888080808080808088888888888888888888888888888888000000000000000000000000000000000000000000000000
02220022220022208080808888888808080808080888888888888888888888888888888888888888000000000000000000000000000000000000000000000000
22222200002222228888888888e88888888888088088888880888888808080808080888088080808000000000000000000000000000000000000000000000000
022e222222222e2288888888ee8888e8088888808888888808080808080808880888080808808088000000000000000000000000000000000000000000000000
2022e222222222028888808888808e88800888880880880880808880888080088080808080880808000000000000000000000000000000000000000000000000
02202222222e2220888e88008808e888888080888088088088080808808000800008000808080000000000000000000000000000000000000000000000000000
102202022ee222010888e888008e88888e8808888088888808008800080800080000800000800080000000000000000000000000000000000000000000000000
110020202222001180888ee888ee880008e8888e8808888880000080000000000008000000000800000000000000000000000000000000000000000000000000
1111022222201111808888ee8ee88088808888e8e808888800000000000000000000000000000000000000000000000000000000000000000000000000000000
1111100000011111880888eeee88088888088ee88088888800000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111111111118888888ee880888888808880088e888e00000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111111111118e8888888808888e8888800888ee88e800000000000000000000000000000000000000000000000000000000000000000000000000000000
111110000001111188e80088008888eee8880888eee8888800000000000000000000000000000000000000000000000000000000000000000000000000000000
111105555550111188e8880088888e88ee88808eeee8888000000000000000000000000000000000000000000000000000000000000000000000000000000000
1100555505050011088e88888888880088e88808ee88880800000000000000000000000000000000000000000000000000000000000000000000000000000000
10555665505055018088888888808000088888088888808800000000000000000000000000000000000000000000000000000000000000000000000000000000
05556555555505508088888008808880808888808888088800000000000000000000000000000000000000000000000000000000000000000000000000000000
505555555556550588088008808808888888e880888808e800000000000000000000000000000000000000000000000000000000000000000000000000000000
55655555555565508888088e88888808888ee80888808e8800000000000000000000000000000000000000000000000000000000000000000000000000000000
5555550000555555888808e88888e888888e88088808888800000000000000000000000000000000000000000000000000000000000000000000000000000000
05550055550055508880888888088e8888e880888808880800000000000000000000000000000000000000000000000000000000000000000000000000000000
605055555055050688880888800088e8888888888088888000000000000000000000000000000000000000000000000000000000000000000000000000000000
56055566655050658888808888808888088888e80888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
505556655505050580088088e888888080888e808888008800000000000000000000000000000000000000000000000000000000000000000000000000000000
0505655505555050088888088e8880088888e8808880880800000000000000000000000000000000000000000000000000000000000000000000000000000000
555650505050550588e8880888ee888888e8e8088808888800000000000000000000000000000000000000000000000000000000000000000000000000000000
05050005000500008888808888888888888e88888880888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111111111111111111111111111000000000444444000000000000000009999999999999999999999999999999900000000000000004444444444444444
11111000000111111111111000001114004444444999999400000444444444449999999999999999999999999999999900000555555000004444455555544444
11110555555011111111110555554449449494949499999944444949494949499999999999999999999999999999999900005999999500004444544444454444
11005555050500111111005550449494999999999999999999999494949494999999999999999999999999999999999900559999595955004455444454545544
10555665505055011110550504494949999999999999999999999999999999999999999999999999999999999999999905999ff99595995045444dd445454454
0555655555550550110550500494949999999999999999999999999999999999999999999999999999999999999999995999f999999959955444d44444445445
50555555555655050005550449499999999999999999999999999999999999999999999999999999999999999999999995999999999f995945444444444d4454
55655555555565505055044994999999999999999999999999999999999999999999999999999999999999999999999999f999999999f99544d444444444d445
55555500005555550504499999999999999999999999999999999999999999999999999999999999999999999ff9999999999955559999994444445555444444
05550055550055505049949999999999999999999999999999999999999999999999999f9999999f999999f999ffff9959995599995599955444554444554445
605055555055050604949949999999999999999999999999999999999999999999999ffff9f99ff999999f99999ffff995959999959959594545444445445454
56055566655050600499999999999999999999999999999999999999999999999fffffffff99999999f9f99999999999995999fff9959599445444ddd4454544
5055566555050500499999999999999999999999999999999999999999999999999ff99ff99955599f9f99f99555559995999ff99959595945444dd444545454
0505655505555050499999999999999999999999999444999999999999999999999999999995000599999f99500000555959fff9999995955454ddd444444545
555655505050555499999999999999999999999999999944449999494949499955555555555000005999999500000000999fff99999f9999444ddd44444d4444
05050005000505049999999999999999999999999999999999444494949499990000000000000000055555500000000099f9f9f99999999944d4d4d444444444
00000000000000599999999999999999999999999999999999999999999999990000005999999999999999999999999900000000000000000000000000000000
00000000000005999999999999999999999999999999999999999999999999990000005999999999999999999999999900000000000000000000000000000000
00000000000005999999999999999999999999999999999999999999999999990000000599999999999999999999999900000000000000000000000000000000
00000000000059999999999999999999999999999999999999999999999999990000000599999999999999999999999900000000000000000000000000000000
00000000000599999999999999999999999999999999999999999999999999990000000059999999999999999999999900000000000000000000000000000000
00000000000599999999999999999999999999999999999999999999999999990000000059999999999999999999999900000000000000000000000000000000
00000000005999999999999999999999999999999999999999999999999999990000000005999999999999999999999900000000000000000000000000000000
00000000005999999999999999999999999999999999999999999999999999990000000005999999999999999999999900000000000000000000000000000000
0000000005999999999999999999999999999999999999999999999999999999000000000059f9999999999999ff999900000000000000000000000000000000
00000000059999999999999999999999999999999999999999999999999999990000000000059ff9f999999f999ffff900000000000000000000000000000000
000000005999999999999999999999999999999999999999999999999999999900000000000059ff999999f99999ffff00000000000000000000000000000000
000000005999999999999999999999999999999999999999999999999999999900000000000005999f9f9f999999999900000000000000000000000000000000
000000059999999999999999999999999999999999999999999999999999999900000000000000559ff9f99f9955555900000000000000000000000000000000
0000000599999999999999999999999999999999999999999999999999999999000000000000000059ff99f99500000500000000000000000000000000000000
00000059999999999999999999999999999999999999999999999999999999990000000000000000059999995000000000000000000000000000000000000000
00000059999999999999999999999999999999999999999999999999999999990000000000000000005555550000000000000000000000000000000000000000
