local module = {}

module.objects = {}

module.imgs = {}

module.buttons = {}

module.temp = {}

module.folder1 = {}

module.chars = {}

function module.Destroy(item,index)
  if #module[index]>0 then
    for _,i in ipairs(module[index]) do
      if i == item then
        module[index][module[index][_]].pY = 2^31
        table.remove(module[index],_)
      end
    end
  end
end

function module.Create(id, X, Y, sisX, sisY, type, shape)
  table.insert(module.objects,id)
 
  module.objects[id] = {}
 
  table.insert(module.objects[id],"pX")
  table.insert(module.objects[id],"pY")
  table.insert(module.objects[id],"sX")
  table.insert(module.objects[id],"sY")
  table.insert(module.objects[id],"fill")
  table.insert(module.objects[id],"shape")
  
  module.objects[id].pX = X
  module.objects[id].pY = Y
  module.objects[id].sX = sisX
  module.objects[id].sY = sisY
  module.objects[id].fill = type
  module.objects[id].shape = shape


  return module.objects[id]
end


function module.newButton(id, X, Y, sisX, sisY, fill, func)
  table.insert(module.buttons,id)
 
  module.buttons[id] = {}
 
  table.insert(module.buttons[id],"pX")
  table.insert(module.buttons[id],"pY")
  table.insert(module.buttons[id],"sX")
  table.insert(module.buttons[id],"sY")
  table.insert(module.buttons[id],"fill")
  table.insert(module.buttons[id],"func")
 
  module.buttons[id].pX = X
  module.buttons[id].pY = Y
  module.buttons[id].sX = sisX
  module.buttons[id].sY = sisY
  module.buttons[id].fill = fill
  module.buttons[id].func = func
 
  return module.buttons[id]
end

function module.CreateTemp(id, X, Y, sisX, sisY, rot, image, type, options)
  table.insert(module.temp,id)
 
  module.temp[id] = {}
 
  table.insert(module.temp[id],"pX")
  table.insert(module.temp[id],"pY")
  table.insert(module.temp[id],"sX")
  table.insert(module.temp[id],"sY")
  table.insert(module.temp[id],"rot")
  table.insert(module.temp[id],"img")
  table.insert(module.temp[id],"type")
  table.insert(module.temp[id],"effect")

  module.temp[id].pX = X
  module.temp[id].pY = Y
  module.temp[id].sX = sisX
  module.temp[id].sY = sisY
  module.temp[id].rot = rot
  module.temp[id].img = image
  module.temp[id].type = type
  module.temp[id].effect = options

  return module.temp[id]
end

function module.CreateImg(id, X, Y, sisX, sisY, rot, image, folder)
  if not folder then
    folder = "imgs"
  end
  table.insert(module[folder],id)
 
  module[folder][id] = {}
 
  table.insert(module[folder][id],"pX")
  table.insert(module[folder][id],"pY")
  table.insert(module[folder][id],"sX")
  table.insert(module[folder][id],"sY")
  table.insert(module[folder][id],"rot")
  table.insert(module[folder][id],"img")
 
  module[folder][id].pX = X
  module[folder][id].pY = Y
  module[folder][id].sX = sisX
  module[folder][id].sY = sisY
  module[folder][id].rot = rot
  module[folder][id].img = image

  return module[folder][id]
end

function module.newChar(path,id,x,y,sX,sY,rot)
  local idle = love.graphics.newImage(path.."idle.png")
  local left = love.graphics.newImage(path.."left.png")
  local down = love.graphics.newImage(path.."down.png")
  local up = love.graphics.newImage(path.."up.png")
  local right = love.graphics.newImage(path.."right.png")
  local freezed = love.graphics.newImage(path.."freeze.png")
  local died = love.graphics.newImage(path.."died.png")
  table.insert(module.chars,id)
  
  module.chars[id] = {}
  
  table.insert(module.chars[id],pX)
  table.insert(module.chars[id],pY)
  table.insert(module.chars[id],sX)
  table.insert(module.chars[id],sY)
  table.insert(module.chars[id],rot)
  table.insert(module.chars[id],idle)
  table.insert(module.chars[id],left)
  table.insert(module.chars[id],down)
  table.insert(module.chars[id],up)
  table.insert(module.chars[id],right)
  table.insert(module.chars[id],freeze)
  table.insert(module.chars[id],died)
  table.insert(module.chars[id],state)
  
  module.chars[id].pX = x
  module.chars[id].pY = y
  module.chars[id].sX = sX
  module.chars[id].sY = sY
  module.chars[id].rot = rot
  module.chars[id].idle = idle
  module.chars[id].left = left
  module.chars[id].down = down
  module.chars[id].up = up
  module.chars[id].right = right
  module.chars[id].freeze = freezed
  module.chars[id].died = died
  module.chars[id].state = "idle"
  
  return module.chars[id]
end

return module