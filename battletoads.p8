pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

function _init()

  is_moving_forward = true
  speed = 3
  first_row = {}
  second_row = {}
  third_row = {}
  land = {}

  start_motion = false

  init_bg()

  player = {
    x = 8,
    y = 70,
    spr = 1,
    size = 4,
    speed = 2,
    is_jumping = false
  }
end

function init_bg()
  for i = 0, 7 do
    local w = 16
    local x1 = i * w
    local x2 = x1 + w
    add(first_row, { x1 = x1, w = w, x2 = x2 })

    add(second_row, {x1 = i * 32, w = 32, x2 = i * 32 + 32 })

    add(third_row, { x1 = i * 32, w= 32, x2 = i * 32 + 32})
  end
end

function debug(str, x, y, c)
  print(str, x, y, c)
end

function _draw()
 	cls()
  palt(0, false) -- make black visible
  palt(1, true) -- make darkblue transparent

  -- draw_grid()

  -- draw top row
  for i = 1, #first_row do
    if is_moving_forward then
      first_row[i].x1 -= speed
    end

    spr(64, first_row[i].x1, 0, 2, 2) -- first_row
  end

  -- draw second/third rows
  for i = 1, #second_row do
    if is_moving_forward then
      second_row[i].x1 -= speed
      third_row[i].x1 -= speed
    end

    spr(66, second_row[i].x1, 16, 4, 4) -- second row
    spr(70, third_row[i].x1, 48, 4, 2) -- third row
  end

  -- draw land
  spr(192, 0, 64, 4, 4) -- top end
  spr(232, 0, 96, 4, 2) -- bottom end
  spr(196, 32, 64, 4, 4) -- top middle
  spr(200, 32, 96, 4, 2) -- bottom middle

  -- draw player
  spr(player.spr, player.x, player.y, player.size, player.size)

  -- debug
  -- debug("first: "..#first_row, 0, 90, 7)
  -- debug("second: "..#second_row, 0, 98, 7)
  -- debug("third: "..#third_row, 0, 106, 7)
end

function draw_grid()
  -- draw grid
  for i = 0, 8 do
    line(i * 16, 0, i* 16, 128, 6)
    line (0, i * 16, 128, i * 16, 6)
  end
end

function _update()
  if btn(2) and player.y + 6 > 48 then -- up
  -- + 6 so it looks like the player is driving close to the top edge
    player.y -= player.speed
  end

  if btn(3) and player.y < 80 then -- down
    player.y += player.speed
  end

  if is_moving_forward then
    -- update first row values
    for i = 1, #first_row do
      set_new_x2(first_row, i)
    end

    -- update second/third row values
    for i = 1, #second_row do
      set_new_x2(second_row, i)
      set_new_x2(third_row, i)
    end

    if (is_offscreen_left(first_row[1].x2)) del_first_value(first_row)

    if is_offscreen_left(second_row[1].x2) then
      del_first_value(second_row)
      del_first_value(third_row)
    end

    if (should_add_bg_spr(first_row[#first_row].x2)) add_bg_spr(first_row, 16 )

    if should_add_bg_spr(second_row[#second_row].x2) then
      add_bg_spr(second_row, 32)
      add_bg_spr(third_row, 32)
    end

  end
end

function add_bg_spr(tbl, w)
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
00000000111111111110011111111111111111111111111111100111111111111111111100000000000000000000000000000000000000000000000000000000
0000000011111111100bb001111111111111111111111111100bb001111111111111111100000000000000000000000000000000000000000000000000000000
00700700111111110bbbbbb00111111111111111111111110bbbbbb0011111111111111100000000000000000000000000000000000000000000000000000000
0007700011111111bbbbbbbbb00111111111111111111111bbbbbbbbb00111111111111100000000000000000000000000000000000000000000000000000000
0007700011111110bbbb0bb7737011111111111111111110bbbb0bb7737011111111111100000000000000000000000000000000000000000000000000000000
0070070011111110bbbb0007070011111111111111111110bbbb0007070011111111111100000000000000000000000000000000000000000000000000000000
0000000011111110bbbbb00000ee01111111111111111110bbbbb00000ee01111111111100000000000000000000000000000000000000000000000000000000
0000000011111110bbbbb08eee8801111111111111111110bbbbb08eee8801111111111100000000000000000000000000000000000000000000000000000000
0000000011111100b00000e8888011111111111111111100b00000e8888011111111111100000000000000000000000000000000000000000000000000000000
00000000111110b0000000e00000011111111111111110b0000000e0000001101111111100000000000000000000000000000000000000000000000000000000
00000000111103b0b0000b000bbb300001111111111103b0b0000b000bbb300c0111111100000000000000000000000000000000000000000000000000000000
0000000011103bb333000bb0003b00cc0111111111103bb333000bb0003b00ccc001111100000000000000000000000000000000000000000000000000000000
0000000011103bbbbb00b0b00000ccdd0111111111103bbbbb00b0b00000ccccc0c0111100000000000000000000000000000000000000000000000000000000
000000001103bbbbb0b0003bb000cd00001111111103bbbbb0b0003bb000cccc0ccc011100000000000000000000000000000000000000000000000000000000
0000000011033bbb300b303bb30cd000dd01111111033bbb300b303bb30dccc0ccccc01100000000000000000000000000000000000000000000000000000000
000000001103333300b30003b30cd0ddddd011111103333300b30003b30ddc0ccccccc0100000000000000000000000000000000000000000000000000000000
000000001100333333b30003b3ccddddd00c01111100333333b30003b3dd000cccccccc000000000000000000000000000000000000000000000000000000000
00000000110d00003b30330300ddddd00cccc011110300003b303303000dd0d00000000100000000000000000000000000000000000000000000000000000000
0000000010dddd003b3000300000000ccccccc0110dddc00000000000dddd0ddddddd01100000000000000000000000000000000000000000000000000000000
0000000000ddd0b0b3000000000000ddccccccc000ddd00000000ddddddd0ddddddd011100000000000000000000000000000000000000000000000000000000
000000000ddddd30b300000bbbbb30ddddccccc00ddd00000dddddddddd0dddd0000111100000000000000000000000000000000000000000000000000000000
000000000ddddd30bbb3333bb30003ddddddccc00dd0000dcccddddd000ddd00dd01111100000000000000000000000000000000000000000000000000000000
000000000ddddc03bbbbbbb0003bb0ddddddddc00ddddddcc00cccdd000000ddd011111100000000000000000000000000000000000000000000000000000000
0000000010000003333333333b0330ddddddd001000000000ccccccdd000dddd0111111100000000000000000000000000000000000000000000000000000000
0000000010dd00033000000003300000000001111000000000ccc00ddd0000001111111100000000000000000000000000000000000000000000000000000000
0000000011cc00300303300030033dddc0001111111dddd00000000ccdd000011111111100000000000000000000000000000000000000000000000000000000
00000000111dd000c00cc0000ddddddc111111111110ddddddd011100ddd00111111111100000000000000000000000000000000000000000000000000000000
000000001110dddd0110dd00000ddd0d1111111111110ccddd011111100001111111111100000000000000000000000000000000000000000000000000000000
000000001111000111110ddd0000001111111111111110ddd0111111111111111111111100000000000000000000000000000000000000000000000000000000
00000000111111111111100011111111111111111111110001111111111111111111111100000000000000000000000000000000000000000000000000000000
00000000111111111111111111111111111111111111111111111111111111111111111100000000000000000000000000000000000000000000000000000000
00000000111111111111111111111111111111111111111111111111111111111111111100000000000000000000000000000000000000000000000000000000
222222222222222280000000000000000000000000000000888e8808888888888888888888808888000000000000000000000000000000000000000000000000
2222e2222222e2220080008000000000000000000800000888e88088808888e8ee80888888088ee8444444444444444444444444444444440000000000000000
02022222222e2020080008000000800080008080008800888e8808880888008e880888008808e888499999999999999999999999999999990000000000000000
202020222ee2220280008088808888000800080880808088888808888800880800888088008e8888999999999999999999999999999999990000000000000000
2e02022eee2220e28080880888088808880808880888080888888088888888808888888888888888999999999999999999999999999999990000000000000000
e02022022222020e8808088808888088888080808080808088888888888888888888888888888888999999999999999999999999999999990000000000000000
02220022220022208080808888888808080808080888888888888888888888888888888888888888999999999999999999999999999999990000000000000000
22222200002222228888888888e88888888888088088888880888888808080808080888088080808999999999999999999999999999999990000000000000000
022e222222222e2288888888ee8888e8088888808888888808080808080808880888080808808088999999999999999999999999999999990000000000000000
2022e222222222028888808888808e88800888880880880880808880888080088080808080880808999999999999999999999999999999990000000000000000
02202222222e2220888e88008808e888888080888088088088080808808000800008000808080000999999999999999999999999999999990000000000000000
102202022ee222010888e888008e88888e8808888088888808008800080800080000800000800080999999999999999999999999999999990000000000000000
110020202222001180888ee888ee880008e8888e8808888880000080000000000008000000000800999999999999999999999999999999990000000000000000
1111022222201111808888ee8ee88088808888e8e808888800000000000000000000000000000000999999999999999999999999999999990000000000000000
1111100000011111880888eeee88088888088ee88088888800000000000000000000000000000000999999999999999999999999999999990000000000000000
11111111111111118888888ee880888888808880088e888e00000000000000000000000000000000999999999999999999999999999999990000000000000000
00000000000000008e8888888808888e8888800888ee88e800000000000000000000000000000000999999999999999999999999999999990000000000000000
000000000000000088e80088008888eee8880888eee8888800000000000000000000000000000000999999999999999999999999999999990000000000000000
000000000000000088e8880088888e88ee88808eeee8888000000000000000000000000000000000999999999999999999999999999999990000000000000000
0000000000000000088e88888888880088e88808ee88880800000000000000000000000000000000999999999999999999999999999999990000000000000000
00000000000000008088888888808000088888088888808800000000000000000000000000000000999999999999999999999999999999990000000000000000
00000000000000008088888008808880808888808888088800000000000000000000000000000000999999999999999999999999999999990000000000000000
000000000000000088088008808808888888e880888808e800000000000000000000000000000000999999999999999999999999999999990000000000000000
00000000000000008888088e88888808888ee80888808e8800000000000000000000000000000000999999999999999999999999999999990000000000000000
0000000000000000888808e88888e888888e88088808888800000000000000000000000000000000999999999999999999999999999999990000000000000000
00000000000000008880888888088e8888e880888808880800000000000000000000000000000000999999999999999999999999999999990000000000000000
000000000000000088880888800088e8888888888088888000000000000000000000000000000000999999999999999999999999999999990000000000000000
00000000000000008888808888808888088888e80888888800000000000000000000000000000000999999999999999999999999999999990000000000000000
000000000000000080088088e888888080888e808888008800000000000000000000000000000000999999999999999999999999999999990000000000000000
0000000000000000088888088e8880088888e8808880880800000000000000000000000000000000999999999999999999999999999999990000000000000000
000000000000000088e8880888ee888888e8e8088808888800000000000000000000000000000000999999999999999999999999999999990000000000000000
00000000000000008888808888888888888e88888880888800000000000000000000000000000000999999999999999999999999999999990000000000000000
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
00000000000000000000000000000000000000000444444000000000000000009999999999999999999999999999999900000000000000000000000000000000
00000000000000000000000000000004004444444999999400000444444444449999999999999999999999999999999900000000000000000000000000000000
00000000000000000000000000004449449494949499999944444949494949499999999999999999999999999999999900000000000000000000000000000000
00000000000000000000000000449494999999999999999999999494949494999999999999999999999999999999999900000000000000000000000000000000
00000000000000000000000004494949999999999999999999999999999999999999999999999999999999999999999900000000000000000000000000000000
00000000000000000000000004949499999999999999999999999999999999999999999999999999999999999999999900000000000000000000000000000000
00000000000000000000000449499999999999999999999999999999999999999999999999999999999999999999999900000000000000000000000000000000
00000000000000000000044994999999999999999999999999999999999999999999999999999999999999999999999900000000000000000000000000000000
00000000000000000004499999999999999999999999999999999999999999999999999999999999999999999ff9999900000000000000000000000000000000
00000000000000000049949999999999999999999999999999999999999999999999999f9999999f999999f999ffff9900000000000000000000000000000000
000000000000000004949949999999999999999999999999999999999999999999999ffff9f99ff999999f99999ffff900000000000000000000000000000000
00000000000000000499999999999999999999999999999999999999999999999fffffffff99999999f9f9999999999900000000000000000000000000000000
0000000000000000499999999999999999999999999999999999999999999999999ff99ff99944499f9f99f99444449900000000000000000000000000000000
0000000000000000499999999999999999999999999444999999999999999999999999999994000499999f994000004400000000000000000000000000000000
00000000000000049999999999999999999999999999994444999949494949994444444444400000499999940000000000000000000000000000000000000000
00000000000000049999999999999999999999999999999999444494949499990000000000000000044444400000000000000000000000000000000000000000
00000000000000499999999999999999999999999999999999999999999999990000004999999999999999999999999900000000000000000000000000000000
00000000000004999999999999999999999999999999999999999999999999990000004999999999999999999999999900000000000000000000000000000000
00000000000004999999999999999999999999999999999999999999999999990000000499999999999999999999999900000000000000000000000000000000
00000000000049999999999999999999999999999999999999999999999999990000000499999999999999999999999900000000000000000000000000000000
00000000000499999999999999999999999999999999999999999999999999990000000049999999999999999999999900000000000000000000000000000000
00000000000499999999999999999999999999999999999999999999999999990000000049999999999999999999999900000000000000000000000000000000
00000000004999999999999999999999999999999999999999999999999999990000000004999999999999999999999900000000000000000000000000000000
00000000004999999999999999999999999999999999999999999999999999990000000004999999999999999999999900000000000000000000000000000000
0000000004999999999999999999999999999999999999999999999999999999000000000049f9999999999999ff999900000000000000000000000000000000
00000000049999999999999999999999999999999999999999999999999999990000000000049ff9f999999f999ffff900000000000000000000000000000000
000000004999999999999999999999999999999999999999999999999999999900000000000049ff999999f99999ffff00000000000000000000000000000000
000000004999999999999999999999999999999999999999999999999999999900000000000004999f9f9f999999999900000000000000000000000000000000
000000049999999999999999999999999999999999999999999999999999999900000000000000449ff9f99f9944444900000000000000000000000000000000
0000000499999999999999999999999999999999999999999999999999999999000000000000000049ff99f99400000400000000000000000000000000000000
00000049999999999999999999999999999999999999999999999999999999990000000000000000049999994000000000000000000000000000000000000000
00000049999999999999999999999999999999999999999999999999999999990000000000000000004444440000000000000000000000000000000000000000
