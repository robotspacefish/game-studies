pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

function _init()

  is_moving_forward = false
  speed = 5
  first_row = {}
  second_row = {}
  third_row = {}

  start_motion = false

  init_first_row()

end

function init_first_row()
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

  -- draw player
  spr(1, 8, 70, 4, 4)

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
  if (btn(➡️)) then
    is_moving_forward = true
  else
  -- speed = 0
    is_moving_forward = false
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

    if (first_row[1].x2 < 0) del_first_value(first_row)

    if second_row[1].x2 < 0 then
      del_first_value(second_row)
      del_first_value(third_row)
    end

    if (first_row[#first_row].x2 <= 148) then -- 148 smoother addition since it's out of view
      local x1 = first_row[#first_row - 1].x2
      add(first_row, { x1 = x1, w = 16, x2 = x1 + 16 })
    end

    if (second_row[#second_row].x2 <= 148) then
      local x1 = second_row[#second_row - 1].x2
      add(second_row, { x1 = x1, w = 32, x2 = x1 + 32 })
      add(third_row, { x1 = x1, w = 32, x2 = x1 + 32 })
    end

  end
end

function del_first_value(tbl)
  del(tbl, tbl[1])
end


function set_new_x2(tbl, idx)
    tbl[idx].x2 = tbl[idx].x1 + tbl[idx].w
end

__gfx__
0000000011111111111001111111111111111111ffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
0000000011111111100bb0011111111111111111ffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
00700700111111110bbbbbb00111111111111111ffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
0007700011111111bbbbbbbbb001111111111111ffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
0007700011111110bbbb0bb77370111111111111ffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
0070070011111110bbbb00070700111111111111ffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
0000000011111110bbbbb00000ee011111111111ffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
0000000011111110bbbbb08eee88011111111111ffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
0000000011111100b00000e88880111111111111ffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
00000000111110b0000000e00000011111111111ffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
00000000111103b0b0000b000bbb300001111111ffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
0000000011103bb333000bb0003b00cc01111111ffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
0000000011103bbbbb00b0b00000ccdd01111111ffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
000000001103bbbbb0b0003bb000cd0000111111ffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
0000000011033bbb300b303bb30cd000dd011111ffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
000000001103333300b30003b30cd0ddddd01111ffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
000000001100333333b30003b3ccddddd00c01110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000110d00003b30330300ddddd00cccc0110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000010dddd003b3000300000000ccccccc010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000ddd0b0b3000000000000ddccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000ddddd30b300000bbbbb30ddddccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000ddddd30bbb3333bb30003ddddddccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000ddddc03bbbbbbb0003bb0ddddddddc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000010000003333333333b0330ddddddd0010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000010dd00033000000003300000000001110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000011cc00300303300030033dddc00011110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000111dd000c00cc0000ddddddc111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000001110dddd0110dd00000ddd00111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000001111000111110ddd00000011111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111111111100011111111111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
22222222222222228000000000000000000000000000000088888888888888888888888888888888000000000000000000000000000000000000000000000000
2222e2222222e2220080008000000000000000000800000888888888888888888888888888888888000000000000000000000000000000000000000000000000
02222222222e22200800080000008000800080800088008888888888888888888888888888888888000000000000000000000000000000000000000000000000
202222222ee222028000808880888800080008088080808888888888888888888888888888888888000000000000000000000000000000000000000000000000
2202222eee2220228080880888088808880808880888080888888888888888888888888888888888000000000000000000000000000000000000000000000000
22202222222202228808088808888088888080808080808088888888888888888888888888888888000000000000000000000000000000000000000000000000
22220022220022228080808888888808080808080888888888888888888888888888888888888888000000000000000000000000000000000000000000000000
22222200002222228888888888888888888888088088888888888888808080808088888888080808000000000000000000000000000000000000000000000000
222e222222222e228888888888888888088888808888888808080808080808888888888088808088000000000000000000000000000000000000000000000000
2222e222222222228888808888808888800888880880888880808880888080888888808880880808000000000000000000000000000000000000000000000000
02222222222e22208888880088088888888080888088088888080808808000800088880888080008000000000000000000000000000000000000000000000000
102222222ee222018888888800888888888808888088888888008800080800080008000000800080000000000000000000000000000000000000000000000000
11002222222200118888888888888800088888888808888880000080000000000000000008000800000000000000000000000000000000000000000000000000
11110222222011118888888888888088808888888808888800000000000000000000000000000000000000000000000000000000000000000000000000000000
11111000000111118888888888880888880888888088888800000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111888888888880888888808880088e888800000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000888888888808888e8888800888ee888800000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000088880088008888eee8880888eee8888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888880088888e88ee88808eeee8888800000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000888888888888880088e88808ee88888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888888888808000088888088888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888888008808880808888808888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000088888008808808888888e8808888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888088888888808888ee8088888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888088888888888888e88088888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000888088888888888888e880888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888088888888888888888888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888808888888888888888888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888808888888888888888888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888880888888888888888888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888880888888888888888888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000008888808888888888888888888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000
