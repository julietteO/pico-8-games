-- tiny-tv jam invite
-- by trasevol_dog



text={
"you are invited to the one & only",
"~ tiny-tv jam ~",
"make a tiny pico-8 game",
"for a tiny pico-8 tv",
"jam will be held on the pico8 bbs",
"from jan 14 - 00:00 gmt",
"to jan 22 - 24:00 gmt",
"all pico-8 levels are welcome!!!",
"don't be shy!",
"and have  f u n",
"details on the bbs thread",
""
}

txtplt={7,7,10,10,10,9,9,9,9,4,4,2,1}
txtpltb={9,9,4,4,4,4,2,2,2,2,1,1,0,0}

cama1=0
va1=0

lm=20

function _init()
 gameon=false
 whitescrn=false
 cama1=-0.10
 
 music(0,0,1)
end

function init_game()
 gameon=true
 whitescrn=0.3
 pad1=4
 pad2=5
 
 balx=4
 baly=4
 balvx=0.25
 balvy=rnd(0.5)-0.25
 balcol=1
 
 shk=0
end

ofx=0
ofy=0
ryy=0

lbt=0
t=0
function _update()
 t+=0.01
 
 if btn(0) then va1-=0.01 lbt=0 end
 if btn(1) then va1+=0.01 lbt=0 end
 
 if lbt>0.5 then va1=0.005 end
 lbt+=0.01
 
 oldcama=cama1
 cama1+=va1
 
 cama1=(cama1+0.5)%1-0.5
 
 va1*=0.9
 
 ofx*=0.9
 ofy*=0.9
 ryy*=0.9
 
 if btnp(4) then
  if gameon then
   gameon=false
   sfx(1)
  else
   init_game()
   sfx(0)
  end
 end

 if gameon then
  if va1<0.015 and abs(cama1)<0.001 then
   va1=0
   cama1=0
  else
   va1=0.9*va1+0.1*0.05*sgn(-cama1) 
  end
  
  lbt=0
 end
 
 if gameon and whitescrn==0 then
  if(btn(2))pad1=min(pad1+0.5,9.75)
  if(btn(3))pad1=max(pad1-0.5,2)

  pad2=mid(baly,2,9.75)
  
  baly+=balvy
  balx+=balvx
  
  if(baly<0)baly=0 balvy*=-1 ryy=0.8 sfx(4)
  if(baly>=11)baly=10 balvy*=-1 ryy=-0.8 sfx(4)
  
  if balx>=8 then
   balx=7.75
   balvx*=-1
   
   balcol=1
   
   balvy+=rnd(0.5)-0.25
   
   ofx+=8
   va1-=0.02
   
   sfx(3)
  end
  
  if balx<2 then
   if mid(baly,pad1-4,pad1+3)==baly then
    balx=2
    balvx*=-1
    
    balvy+=rnd(0.5)-0.25
    
    balcol=1
    
    ofx-=8
    va1+=0.02
    
    sfx(2)
   else
    sfx(5)
    init_game()
    shk=0
    va1=0.1
   end
  end
 end

end

drk={[0]=0,0,1,1,2,1,5,6,2,4,9,3,1,1,2,4}
function _draw()
 local c=flr((t)%1*6)+8
 palt(0,false)
 for x=0,128,64 do
 for y=0,128,64 do
  spr(136,x-(t*100)%64,y-(t*100)%64,8,8)
 end
 end
 
 if gameon then
  if whitescrn>0 then
   local c=7
   
   if whitescrn<0.05 then
    c=13
   elseif whitescrn<0.1 then
    c=6
   end
   
   for y=0,10 do
   for x=0,9 do
    sset(x,y+64,c)
   end
   end
  
   whitescrn=max(whitescrn-0.01,0)
  else
   for y=0,10 do
   for x=0,9 do
    sset(x,y+64,0)
   end
   end
   
   for y=pad1-2,pad1+1 do
    sset(1,y+64,9)
   end
   
   for y=pad2-2,pad2+1 do
    sset(8,y+64,8)
   end
   
   if balcol>0 then
    sset(balx-1,baly+64,7)
    sset(balx+1,baly+64,7)
    sset(balx,baly-1+64,7)
    sset(balx,baly+1+64,7)
    sset(balx,baly+64,7)
    balcol-=0.4
   else
    sset(balx,baly+64,13)
   end
  end
 end
 
 --pal(1,8)
 --pal(2,14)
 --pal(4,7)
 --pal(9,14)
 --pal(10,8)
 draw_voxels()
 pal()
 
 local strk=(t*0.5-1)%#text
 local x=64-strk%1*150
 draw_text(text[flr(strk)+1],x,16,1)

 local strk=(t*0.5)%#text
 local x=64+150-strk%1*150
 draw_text(text[flr(strk)+1],x,16,1)


 local str="#t\73\78\89tv\74\65\77 -> jan 14~22"
 print(str,64-#str*2-2,2,6)
 print(str,64-#str*2-2,1,13)
 
 str="start:\142"
 print(str,1,122,6)
 print(str,1,121,13)
 
 str="play:\148\131  "
 print(str,128-#str*4,122,6)
 print(str,128-#str*4,121,13)

 --print(stat(1),0,0,7)
end


function draw_voxels()
 local ocx=cos(cama1)
 local osx=-sin(cama1)
 local ocy=cos(cama1+0.25)
 local osy=-sin(cama1+0.25)
 
 local ssx,sox,ssy,soy
 if cama1%1>0.5 then
  ssx=15
  sox=-1
 else
  ssx=0
  sox=1
 end
   
 if cama1%1>0.25 and cama1%1<0.75 then
  ssy=15
  soy=-1
 else
  ssy=0
  soy=1
 end

 for l=0,20 do
  local ly=112-l*4+ofy
  local lx=64+ofx
  
  local x,y=lx,ly
  
  local sx=ssx
  for ix=0,15 do  
  local sy=ssy
  for iy=0,15 do

   local c=sget(sx+(l%8)*16,sy+flr(l/8)*16)
   
   if c~=14 then
   
    if gameon and c==0 and l<16 then
     c=sget(ssx+sox*ix-3,l-2+64)
    end
   
    --local a=atan2(sx-8,sy-8)-cama1
    --local l=sqrt(sqr(sx-8)+sqr(sy-8))
    local xx=3.99*((sx-7.5)*ocx+(sy-7.5)*ocy)
    local yy=(1+ryy)*((sx-7.5)*osx+(sy-7.5)*osy)
   
    xx+=x
    yy+=y
   
    rectfill(xx-2,yy-2,xx+1,yy+1,c)
   
   end
  
  sy+=soy
  end
  sx+=sox
  end
 end
end


function draw_text(str,x,y,al)
 if al==1 then x-=#str*2.5-2.5
 elseif al==2 then x-=#str*4 end
 
 local colk=#txtplt-1
 
 for i=1,#str do
  chr=sub(str,i,i)
  
  local c=colk*0.5*cos(x*0.01+y*0.01-t*2)
  c=mid(round(colk*0.5+c),0,colk-1)
  local c1,c2
  c0=txtplt[c+1]
  c1=txtpltb[c+1]
  c2=0
  c3=0
 
  local xx,yy
  xx=x
  yy=y+round(3*sin(x*0.02+t*3)+4*sin(x*0.01+t*0.4))
  

  print(chr,xx,yy+2,c3)
  print(chr,xx-1,yy+1,c3)
  print(chr,xx+1,yy+1,c3)
  
  print(chr,xx-1,yy,c2)
  print(chr,xx+1,yy,c2)
  print(chr,xx,yy-1,c2)
  print(chr,xx,yy+1,c1)
  
  --print(chr,xx-1,yy-1,c1)
  --print(chr,xx+1,yy-1,c1)
  --print(chr,xx-1,yy+1,c1)
  --print(chr,xx+1,yy+1,c1)
  
  print(chr,xx,yy,c0)

  
  x+=5
 end

end


function sqr(a) return a*a end
function round(a) return flr(a+0.5) end
