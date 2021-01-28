pico-8 cartridge // http://www.pico-8.com
version 27
__lua__
function _init()
  x=59
  y=59
  vx=0
  vy=0
  p_spr=1
  p_flip=false

  speed=2
end

function _update()
  --controls
  if (btn(⬅️)) then
    x-=speed -- left
    p_spr=3
    p_flip=true
  elseif (btn(➡️)) then
    x+=speed -- right
    p_spr=3
    p_flip=false
  elseif (btn(⬆️)) then
    y-=speed -- up
    p_spr=2
    p_flip=false
  elseif (btn(⬇️)) then
    y+=speed --down
    p_spr=1
    p_flip=false
  end

  --if run off screen warp to other side
  if (x>128) then x=-8 end
  if (x<-8) then x=128 end
  if (y<-8) then y=128 end
  if (y>128) then y=-8 end

end

function _draw()
  cls()
  map(0, 0, 0,0,16,16)
  spr(p_spr,x,y, 1, 1, p_flip)

end
__gfx__
00000000000000000000000000000000111111101111111111111110111111111111111077777775777777700000000000000001000000000000000000000000
000000000555555005555550055555001111111011111111111111101111117ccc111110666666d5766666600000000000000001000000000000000000000000
0070070005c77c50055555500555c700111111101111111111111110111717777ccc1110666666d5766666600000000000000001000000000000000000000000
000770000559955005555550055559901111111011111111111111101117c777777cc11055555555555555500000000000000001000000000000000000000000
000770000555555005555550055555001111111011111111111111101177777777cccc1077757777777577700000000000000001000000000000000000000000
00700700057777500555555005557700111111101111111111111110117777c777ccc11066d5766666d576600000000000000001000000000000000000000000
000000005577775055577550555577001111111011111111111111101777c7777777cc1066d5766666d576600000000000000001000000000000000000000000
0000000000900900009009000040900000000000111111111111111017777777777c7c1055555555555555500000000000000001000000000000000000000000
000000000000000000000000000000000000000011111111111111101177777c777ccc1077777577777775700000000000000001000000000000000000000000
00555000005550000000000000000000000000001111111111111110177777777cccc1106666d5766666d5700000000000000001000000000000000000000000
005c700000c7500000000000000000000000000011111111111111101777777777c7c1106666d5766666d5700000000000000001000000000000000000000000
00559900099550000000000000000000000000001111111111111110177c777cccccc11055555555555555500000000000000001000000000000000000000000
005550000055500000000000000000000000000011111111111111101177777ccccc111075777777757777700000000000000001000000000000000000000000
00577000007750000000000000000000000000001111111111111110111c7777cc7cccc0d5766666d57666600000000000000001000000000000000000000000
0557700000775500000000000000000000000000111111111111111011cccccccccccc10d5766666d57666600000000000000001000000000000000000000000
00409000009040000000000000000000000000000000000000000000000000000000000000000000000000001111111111111111000000000000000000000000
__gff__
0000000000000001010101000000000000000000000000010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
090a050605060506050605060506050600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
191a151615161516151615161516151600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
090a050605060506050605060506050600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
191a151615161516151615161516151600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
090a050605060506050605060506050600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
191a151615161516151615161516151600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
090a050607080506070805060708050600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
191a151617181516171815161718151600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0506050605060506050605060506050600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1516151615161516151615161516151600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
090a050607080506070805060708050600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
191a151617181516171815161718151600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
090a050605060506050605060506050600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
191a151615161516151615161516151600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
090a050605060506050605060506050600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
191a151615161516151615161516151600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
