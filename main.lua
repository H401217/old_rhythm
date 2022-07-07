function love.quit() --you can remove it
  local res = love.window.showMessageBox("Warning!", "Game requested close", {"Close", "Don't Close!", enterbutton = 2}, "warning")
  if res == 2 then return true else return false end
end

function love.load()
  fonts = {
    pou = love.graphics.newFont("assets/fonts/pou.ttf")
  }

  love.graphics.setFont(fonts.pou)

  debugmodewhyyoudontwanttodothislolimadevwellimnotreallyadevbruhxddd = true

  score = 0
  acc = {
	  perfect = 0,
	  great = 0,
	  ok = 0,
	  miss = 0,
	  percent = 0,
  }

  player = {
    freeze = 0,
    died = false,
  }

  obj = require("obj")

  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  time = 0
  time_ms = 0

  notes = {l = 0,d = 0, u= 0, r=0}

  pepe = 0
  pepo = 0

--imgs
  baseimg = love.graphics.newImage("assets/BaseNote.png")
  basepressimg = love.graphics.newImage("assets/PressBaseNote.png")
  noteimg = love.graphics.newImage("assets/Note.png")
  freezenoteimg = love.graphics.newImage("assets/FreezeNote.png")
  deathnoteimg = love.graphics.newImage("assets/DeathNote.png")
--end

 --chars coming
  math.randomseed(os.time())
  if math.random(1,1) == 1 then
    currentchar = obj.newChar("assets/characters/cubito/","stick",10,height*0.25,height*0.5,height*0.5,0)
  --[[else
    currentchar = obj.newChar("assets/characters/noob/","noob",10,height*0.25,height*0.5,height*0.5,0)]]
  end
 --beuh

  notesize = 0.14 --0.14
  noteoffset = 0
  notespeed = 1

  keybinds = {
  	left = "a",
  	down = "s",
  	up = "up",
  	right = "right",
  	}
  
  temptimelolol = {
  	left = 0,
  	down = 0,
  	up = 0,
  	right = 0,
    animation = 0,
  	}
  
  presses = {
    left = false,
    down = false,
    up = false,
    right = false,
  }
  
  settings = {
	  botplay = false,
  }

  state = "play" --play, pause, stop, load
  obj.newButton("stop",width-30,0,30,30,"fill",'if state == "stop" then state = "play" elseif state == "play" then state = "stop" end player.died = false')
  obj.newButton("pause",width-30,31,30,30,"line",'if state == "pause" then state = "play" elseif state == "play" then state = "pause" end')
  obj.newButton("botplay",width-30,62,30,30,"fill",'if settings.botplay == false then settings.botplay = true else settings.botplay = false end')
  obj.newButton("nextsong",width-30,93,30,30,"line",'if currentsong == #songstable then currentsong = 1 else currentsong = currentsong+1 end player.died = false state = "load"')
  
  if love.system.getOS() ~= "Windows" then
    obj.newButton("LeftController",0,0,width/4,height,"line",'checknote("left") glow(true, "left") presses.left = true')
    obj.newButton("DownController",width/4,0,width/4,height,"line",'checknote("down") glow(true, "down") presses.down = true')
    obj.newButton("UpController",width/2,0,width/4,height,"line",'checknote("up") glow(true, "up") presses.up = true')
    obj.newButton("RightController",width/4*3,0,width/4,height,"line",'checknote("right") glow(true, "right") presses.right = true')
  end

  obj.CreateImg("left",width*0.25+noteoffset,height*0.8,height*notesize/baseimg:getHeight(),height*notesize/baseimg:getHeight(),0,baseimg)
  obj.CreateImg("down",width*(0.25+height*notesize/baseimg:getHeight()*1)+noteoffset,height*0.8,height*notesize/baseimg:getHeight(),height*notesize/baseimg:getHeight(),0,baseimg)
  obj.CreateImg("up",width*(0.25+height*notesize/baseimg:getHeight()*2)+noteoffset,height*0.8,height*notesize/baseimg:getHeight(),height*notesize/baseimg:getHeight(),0,baseimg)
  obj.CreateImg("right",width*(0.25+height*notesize/baseimg:getHeight()*3)+noteoffset,height*0.8,height*notesize/baseimg:getHeight(),height*notesize/baseimg:getHeight(),0,baseimg)

  obj.CreateImg(".leftpress",width*10,height*10,height*notesize/baseimg:getHeight(),height*notesize/baseimg:getHeight(),0,basepressimg,"folder1")
  obj.CreateImg(".downpress",width*10,height*10,height*notesize/baseimg:getHeight(),height*notesize/baseimg:getHeight(),0,basepressimg,"folder1")
  obj.CreateImg(".uppress",width*10,height*10,height*notesize/baseimg:getHeight(),height*notesize/baseimg:getHeight(),0,basepressimg,"folder1")
  obj.CreateImg(".rightpress",width*10,height*10,height*notesize/baseimg:getHeight(),height*notesize/baseimg:getHeight(),0,basepressimg,"folder1")
  
  songstable = love.filesystem.getDirectoryItems("songs")

  if #songstable == 0 then love.window.showMessageBox("Error", "No songs found", "error") love.event.quit() end

  currentsong = 1
  current = require("songs/"..songstable[currentsong].."/song")
  currentnote = 1
  currentevent = 1

  if notespeed > 1 then
    if 1==1 then
      current.offset = current.offset+((0.8-(0.8/notespeed))*1000)
    else

    current.offset = current.offset+((notespeed-1)*500)
    end
  elseif notespeed < 1 then
    current.offset = current.offset-((1-notespeed)*6000)
  end

  if current then
    local file = love.sound.newSoundData("songs/"..songstable[currentsong].."/"..current.sound)
    songaudio = love.audio.newSource(file,"stream")
    songaudio:setVolume(0.4)
  end

  deathsong = love.audio.newSource("assets/sounds/Death.ogg","stream")
  deathsong:setVolume(1)

  function createNote()
    local tempmspingwhynot = current.notes[currentnote][1]
    local tempnoteimg = noteimg
    if current.notes[currentnote][4] == 1 then
      tempnoteimg = current.notes[currentnote][5].img
    elseif current.notes[currentnote][4] == 2 then
      tempnoteimg = freezenoteimg
    elseif current.notes[currentnote][4] == 3 then
      tempnoteimg = deathnoteimg
    end
   if current.notes[currentnote][2] == 1 then
     notes.l = notes.l+1
     obj.CreateTemp("note"..currentnote,width*0.25+noteoffset,0,height*notesize,height*notesize,0,tempnoteimg,current.notes[currentnote][4],current.notes[currentnote][5])
   elseif current.notes[currentnote][2] == 2 then
     notes.d = notes.d+1
     obj.CreateTemp("note"..currentnote,width*(0.25+height*notesize/noteimg:getHeight()*1)+noteoffset,0,height*notesize,height*notesize,0,tempnoteimg,current.notes[currentnote][4],current.notes[currentnote][5])
   elseif current.notes[currentnote][2] == 3 then
     notes.u = notes.u+1
     obj.CreateTemp("note"..currentnote,width*(0.25+height*notesize/noteimg:getHeight()*2)+noteoffset,0,height*notesize,height*notesize,0,tempnoteimg,current.notes[currentnote][4], current.notes[currentnote][5])
   elseif current.notes[currentnote][2] == 4 then
     notes.r=notes.r+1
     obj.CreateTemp("note"..currentnote,width*(0.25+height*notesize/noteimg:getHeight()*3)+noteoffset,0,height*notesize,height*notesize,0,tempnoteimg,current.notes[currentnote][4],current.notes[currentnote][5])
   else error("invalid note")
   end
   local tempnum = currentnote
   currentnote=currentnote+1
   if current.notes[currentnote] and current.notes[currentnote][1] == tempmspingwhynot then
     createNote()
   end
 end

 sendinfo = {}

 function checknote(notetype)
 if state == "play" and player.freeze <= time_ms then
  local function del(i)
    local tab = obj.temp[i]
    if tab.reserved == false then
      obj.temp[i].pY = height+999
      obj.Destroy(i,"temp")
    end
  end
  for _,i in ipairs(obj.temp) do
   if obj.temp[i].sY then
    
    if obj.temp[i].pX >= obj.imgs[notetype].pX and obj.temp[i].pX <= obj.imgs[notetype].pX+obj.imgs[notetype].sX then
      if not obj.temp[i].type then
        if obj.temp[i].pY >= obj.imgs[notetype].pY-(height/25)*notespeed and obj.temp[i].pY <= obj.imgs[notetype].pY+obj.imgs[notetype].sY+(height/25)*notespeed then
         if settings.botplay == true then glow(true, tostring(notetype)) temptimelolol[notetype] = time_ms+200 end
         del(i)
         score = score+100
         acc.perfect = acc.perfect+1
         print("perfect", time_ms, notetype)
         love.audio.play(love.audio.newSource(love.sound.newSoundData("assets/sounds/Hit.ogg"),"static"))
         return
        elseif obj.temp[i].pY >= obj.imgs[notetype].pY-(height/20)*notespeed and obj.temp[i].pY <= obj.imgs[notetype].pY+obj.imgs[notetype].sY+(height/20)*notespeed and settings.botplay == false then
         del(i)
         score = score+50
         acc.great = acc.great+1
         print("great", time_ms, notetype)
         love.audio.play(love.audio.newSource(love.sound.newSoundData("assets/sounds/Hit.ogg"),"static"))
         return
        elseif obj.temp[i].pY >= obj.imgs[notetype].pY-(height/10)*notespeed and obj.temp[i].pY <= obj.imgs[notetype].pY+obj.imgs[notetype].sY+(height/8)*notespeed and settings.botplay == false then
         del(i)
         score = score+20
         acc.ok = acc.ok+1
         print("ok", time_ms, notetype)
         love.audio.play(love.audio.newSource(love.sound.newSoundData("assets/sounds/Hit.ogg"),"static"))
         return
        end
      elseif obj.temp[i].pY >= obj.imgs[notetype].pY-(height/8)*notespeed and obj.temp[i].pY <= obj.imgs[notetype].pY+obj.imgs[notetype].sY+(height/8)*notespeed then
        if (not obj.temp[i].effect or obj.temp[i].effect.ignore == true) and settings.botplay == true then return end
        del(i)
        if obj.temp[i].type == 1 then
          if obj.temp[i].effect.func then
            score = score+tonumber(obj.temp[i].effect.points)
            love.audio.play(love.audio.newSource(love.sound.newSoundData("assets/sounds/Hit.ogg"),"static"))
            print("hit!",time_ms,notetype)
            obj.temp[i].effect.func(sendinfo)
          end
        elseif obj.temp[i].type == 2 then
          player.freeze = time_ms+2000
          love.system.vibrate(0.1)
        elseif obj.temp[i].type == 3 then
          player.died = true
          state = "stop"
          love.system.vibrate(0.2)
        end
      end
    end 
   end
  end
 end
 end

  function glow(on, notetype)
    if on == true then
      if notetype == "left" then
        obj.folder1[".leftpress"].pX = width*0.25+noteoffset
        obj.folder1[".leftpress"].pY = height*0.8
        currentchar.state = "left"
        pepe = pepe+1
      elseif notetype == "down" then
        obj.folder1[".downpress"].pX = width*(0.25+height*notesize/baseimg:getHeight()*1)+noteoffset
        obj.folder1[".downpress"].pY = height*0.8
        currentchar.state = "down"
      elseif notetype == "up" then
        obj.folder1[".uppress"].pX = width*(0.25+height*notesize/baseimg:getHeight()*2)+noteoffset
        obj.folder1[".uppress"].pY = height*0.8
        currentchar.state = "up"
      elseif notetype == "right" then
        obj.folder1[".rightpress"].pX = width*(0.25+height*notesize/baseimg:getHeight()*3)+noteoffset
        obj.folder1[".rightpress"].pY = height*0.8
        currentchar.state = "right"
      end
      temptimelolol.animation = 200
    else
      if obj.folder1["."..notetype.."press"] and obj.folder1["."..notetype.."press"].pX < width then
        obj.folder1["."..notetype.."press"].pX = width*10
        obj.folder1["."..notetype.."press"].pY = height*10
        if temptimelolol.animation <= 0 then
          currentchar.state = "idle"
        end
        pepo = pepo+1
      end
    end
  end
end

function love.update(dt)
  sendinfo = {
    plr = player,
    time = time_ms,
    window = {sX = width, sY = height}
   }

  if current.events and current.events[currentevent] then
    if time_ms >= current.events[currentevent][1] then
      current.events[currentevent][2](sendinfo)
      currentevent = currentevent+1
    end
  end

  --update size
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

      obj.imgs["left"].pX = width*0.25+noteoffset
      obj.imgs["left"].pY = height*0.8
      obj.imgs["down"].pX = width*(0.25+height*notesize/baseimg:getHeight()*1)+noteoffset
      obj.imgs["down"].pY = height*0.8
      obj.imgs["up"].pX = width*(0.25+height*notesize/baseimg:getHeight()*2)+noteoffset
      obj.imgs["up"].pY = height*0.8
      obj.imgs["right"].pX = width*(0.25+height*notesize/baseimg:getHeight()*3)+noteoffset
      obj.imgs["right"].pY = height*0.8
  --end

  if temptimelolol.animation < 0 then
    currentchar.state = "idle" 
  end
  if presses.left == false and presses.down == false and presses.up == false and presses.right == false then
    temptimelolol.animation = temptimelolol.animation-dt*1000
  end
 --botplay
 if settings.botplay == true then
  checknote("left")
  checknote("down")
  checknote("up")
  checknote("right")
  if temptimelolol.left < time_ms then
    glow(false,"left")
  end
  if temptimelolol.down < time_ms then
    glow(false,"down")
  end
  if temptimelolol.up < time_ms then
    glow(false,"up")
  end
  if temptimelolol.right < time_ms then
    glow(false,"right")
  end
 end
 
 if player.freeze > time_ms then
   currentchar.state = "freeze"
 elseif currentchar.state == "freeze" then
   currentchar.state = "idle"
 end
 if player.died == true then
   currentchar.state = "died"
 elseif currentchar.state == "died" then
   currentchar.state = "idle"
 end
--stop
if state == "stop" or state == "load" then
  temptimelolol.animation = 0
  time = 0
  time_ms = 0
  currentnote = 1
  currentevent = 1
  score = 0
  acc.perfect = 0
  acc.great = 0
  acc.ok = 0
  acc.miss = 0
  acc.percent = 0
  player.freeze = 0

  for _,i in ipairs(obj.temp) do
    if obj.temp[tostring(i)].reserved == false then
      obj.Destroy(i,"temp")
    end
  end
end
--end

 function love.focus()
   if state == "play" then
     state = "pause"
   end
 end


--keypress
function love.keypressed(key)
 if state == "play" then
  if key == keybinds.left then
    presses.left = true
    checknote("left")
    glow(true, "left")
  elseif key == keybinds.down then
    presses.down = true
    checknote("down")
    glow(true, "down")
  elseif key == keybinds.up then
    presses.up = true
    checknote("up")
    glow(true, "up")
  elseif key == keybinds.right then
    presses.right = true
    checknote("right")
    glow(true, "right")
  end
 end
end

function love.keyreleased(key)
 if state == "play" then
  if key == keybinds.left then
    presses.left = false
    glow(false, "left")
  elseif key == keybinds.down then
    presses.down = false
    glow(false, "down")
  elseif key == keybinds.up then
    presses.up = false
    glow(false, "up")
  elseif key == keybinds.right then
    presses.right = false
    glow(false, "right")
  end
 end
end
--end

--loadsong
  if songaudio then
    if not songaudio:isPlaying() and time >= 1 then
      if state == "play" then
        if currentnote >= #current.notes+1 then
          state = "stop"
        else
          songaudio:seek(time-1,"seconds")
          love.audio.play(songaudio)
        end
        player.died = false
      end
    elseif songaudio:isPlaying() then
      if state == "pause" then
        love.audio.pause(songaudio)
      elseif state == "stop" or state == "load" then
        love.audio.stop(songaudio)
      end
    end
  end

  if deathsong then
    if not deathsong:isPlaying() and state == "stop" and player.died == true then
      love.audio.play(deathsong)
    elseif deathsong:isPlaying() then
      if state ~= "stop" or player.died == false then
        love.audio.stop(deathsong)
      end
    end
  end
--end
 
--accuracy
  if state == "play" and current then
    local total = acc.perfect+acc.great+acc.ok+acc.miss
    local perf = 0
    local gre = 0
    local okok = 0
    if acc.perfect > 0 then
      perf = acc.perfect/total
    end
    if acc.great > 0 then
      gre = (acc.great*0.5)/total
    end
    if acc.ok > 0 then
      okok = (acc.ok*0.2)/total
    end
    local temperc = (perf+gre+okok)*100
    if math.floor(temperc)>=10 and math.floor(temperc)<=99 then
      acc.percent = tonumber(string.reverse(string.sub(string.reverse(tostring(temperc)),string.len(tostring(temperc))-4)))
    elseif math.floor(temperc)>=0 and math.floor(temperc)<=9 then
      acc.percent = tonumber(string.reverse(string.sub(string.reverse(tostring(temperc)),string.len(tostring(temperc))-3)))
    elseif temperc>=100 then
      acc.percent = temperc
    end
  end
--end
 
  if state == "play" then
    time = time+dt
    time_ms = time*1000
  end
 
  if current then
    for _,i in ipairs(current.notes) do
      if _==currentnote and time_ms >= i[1]+current.offset then
        createNote()
      end
    end
  end
 
 --move notes every upsate with for do
  if state == "play" then
    for a,b in ipairs(obj.temp) do
      if obj.temp[b].sY then
        obj.temp[b].pY = obj.temp[b].pY+height*dt*notespeed
      end
      if obj.temp[b].pY > height+obj.temp[b].sY+10 then
        if obj.temp[b].reserved == false then
          obj.Destroy(b,"temp")
          if not obj.temp[b].type then
            acc.miss = acc.miss+1
          end
        end
      end
    end
  end

--load
  if state == "load" then
    state = "stop"
    current = require("songs/"..songstable[currentsong].."/song")
    local file = love.sound.newSoundData("songs/"..songstable[currentsong].."/"..current.sound)
    songaudio = love.audio.newSource(file,"stream")
    songaudio:setVolume(0.4)
    state = "play"
  end
--end

end

function love.draw()
--bg
  if current.bg and state ~= "stop" then
    love.graphics.draw(current.bg,0,0,0,width/current.bg:getWidth(),height/current.bg:getHeight())
  else
    love.graphics.setColor(1,1,1,0.5)
    love.graphics.rectangle("fill",0,0,width,height)
    love.graphics.setColor(1,1,1,1)
  end
--end
love.graphics.print(pepe.."?"..pepo,300,10)
  for i,v in pairs(obj.chars) do
    if v.sY then
      love.graphics.draw(v[v.state],v.pX,v.pY,v.rot,v.sX/v[v.state]:getWidth(),v.sY/v[v.state]:getHeight())
    end 
  end
  love.graphics.print(#obj.temp.."$",20,200)
  if debugmodewhyyoudontwanttodothislolimadevwellimnotreallyadevbruhxddd == true then
    love.graphics.print("Score: "..score.. "\n misses: "..acc.miss.."\n perfect: "..acc.perfect.."\n great: "..acc.great.."\n ok: "..acc.ok.."\n accuracy: "..acc.percent.."%\n time ms: "..time_ms.."\n fps: "..love.timer.getFPS().."\n freezed until: ".. player.freeze.."\n died: "..tostring(player.died).."\n song title: "..current.title.."\n status: "..state.."\n temptime (l"..temptimelolol.left.." d"..temptimelolol.down.." u"..temptimelolol.up.." r"..temptimelolol.right..")" .."\n charstate: "..currentchar.state.."\n animationdelay: "..temptimelolol.animation.."\n total notes: "..tostring(#obj.temp))
  end

  local function detectPress(x,y)
    for i,v in pairs(obj.buttons) do
      if v.func then
        if x > v.pX and x < v.pX+v.sX and y > v.pY and y < v.pY+v.sY then
          loadstring(v.func)()
        end
      end
    end
  end

  local function unpress(x,y)
    for i,v in pairs(obj.buttons) do
      if v.func then
        if x > v.pX and x < v.pX+v.sX and y > v.pY and y < v.pY+v.sY then
          if tostring(i) == "LeftController" then
            presses.left = false
            glow(false, "left")
          elseif tostring(i) == "DownController" then
            presses.down = false
            glow(false, "down")
          elseif tostring(i) == "UpController" then
            presses.up = false
            glow(false, "up")
          elseif tostring(i) == "RightController" then
            presses.right = false
            glow(false, "right")
          end
        end
      end
    end
  end

  if love.system.getOS() ~= "Windows" then
    function love.touchpressed(id, x, y, dx, dy, pressure)
      detectPress(x,y)
    end
    function love.touchreleased(id, x, y, dx, dy, pressure)
      unpress(x,y)
    end
  else
    function love.mousepressed(x,y)
      detectPress(x,y)
    end
  end

  for i,v in pairs(obj.buttons) do
    if v.sY and v.func then
     love.graphics.rectangle(v.fill, v.pX, v.pY, v.sX, v.sY)
    end
  end

--notebase

  for _,i in pairs(obj.imgs) do
    if i.sY then
      love.graphics.draw(i.img,i.pX,i.pY,i.rot,i.sX,i.sY)
    end
  end
  for _,i in pairs(obj.folder1) do
    if i.sY then
      love.graphics.draw(i.img,i.pX,i.pY,i.rot,i.sX,i.sY)
    end
  end
--end

  if state == "play" or state == "pause" then
    for _,i in pairs(obj.temp) do
      if i.sY and #obj.temp > 0 then
        love.graphics.draw(i.img,i.pX,i.pY,i.rot,i.sX/i.img:getWidth(),i.sY/i.img:getHeight())
      else
      end
    end
  end
 
  for i,v in pairs(obj.objects) do
    if v.sY then
      if v.shape == "rect" then
        love.graphics.rectangle(v.fill, v.pX, v.pY, v.sX, v.sY)
      elseif v.shape == "ellipse" then
    -- i started to make this code when obj.lua was created, but im too lazy to end this piece of code (jk)
      end
    end
  end
end
