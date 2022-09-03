local module = {}

module.objects = {}

module.imgs = {}

module.buttons = {}

module.temp = {}

module.folder1 = {}

module.chars = {}

module.deltaFunc = {} --work in progress

function module.Destroy(item,index)
  if #module[index]>0 then
    for _,i in ipairs(module[index]) do
      if i == item then
	    if module[index][module[index][_]].reserved == true then return end
        module[index][module[index][_]].pY = 1000
        module[index][module[index][_]].reserved = true
        --table.remove(module[index],_)
      end
    end
  end
end

function module.Create(id, X, Y, sisX, sisY, type, shape)
  table.insert(module.objects,id)
 
  module.objects[id] = {}
  
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
 
  module.buttons[id].pX = X
  module.buttons[id].pY = Y
  module.buttons[id].sX = sisX
  module.buttons[id].sY = sisY
  module.buttons[id].fill = fill
  module.buttons[id].func = func
 
  return module.buttons[id]
end

function module.CreateTemp(id, X, Y, sisX, sisY, rot, image, type, options) --4 notes
  for _,i in pairs(module.temp) do
    if i.reserved == true and i.img == image then
      i.pX = X
      i.pY = Y
      i.sX = sisX
      i.sY = sisY
      i.rot = rot
      i.reserved = false
      return i
    end
  end

  table.insert(module.temp,id)
 
  module.temp[id] = {}

  module.temp[id].pX = X
  module.temp[id].pY = Y
  module.temp[id].sX = sisX
  module.temp[id].sY = sisY
  module.temp[id].rot = rot
  module.temp[id].img = image
  module.temp[id].type = type
  module.temp[id].effect = options
  module.temp[id].reserved = false
  return module.temp[id]
end

function module.CreateImg(id, X, Y, sisX, sisY, rot, image, folder)
  if not folder then
    folder = "imgs"
  end
  for _,i in pairs(module[folder]) do
    if i.reserved == true and tostring(_) == id then
      i.pX = X
      i.pY = Y
      i.sX = sisX
      i.sY = sisY
      i.rot = rot
      i.reserved = false
      return i
    end
  end
  table.insert(module[folder],id)
 
  module[folder][id] = {}
 
  module[folder][id].pX = X
  module[folder][id].pY = Y
  module[folder][id].sX = sisX
  module[folder][id].sY = sisY
  module[folder][id].rot = rot
  module[folder][id].img = image
  module[folder][id].reserved = false
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

function module.newDeltaFunc(id, type, item, func)
  table.insert(module.deltaFunc,id)
  module.deltaFunc[id] = {
    item = item,
    func = func,
    timestamp = 0,
	obj = module,
  }
  return module.deltaFunc[id]
end

function module.removeDeltaFunc(item)
	for _,i in pairs(module.deltaFunc) do
		if i==item then
		error(1222222)
		end
	end
end


return module
