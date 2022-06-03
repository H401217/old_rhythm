# Wiki
Welcome to this wiki

## Index:
1. [Songs](#songs)
    - [song.lua](#songlua)
    - [audio.ogg](#audioogg)
2. [Characters](#characters)

# Songs
You can edit songs using folders:

## song.lua

This is the base for the song coding.  
Example:

```lua
local foo = {
    ignore = false, --Botplay will check if this note needs to be ignored (true for death notes, false for necessary notes)
    func = function(info) --Main Function (you can use "love" functions)
      print("bar")
    end,
    img = love.graphics.newImage("assets/Note.png"), --Note Image
    points = 10, --Points awarded for pressing note
}

local module = {}

module.title = "foobar"
module.sound = "audio.ogg"
module.offset = 180
module.bg = love.graphics.newImage("assets/Icon.png")

module.notes = {
    {0,1,0,1, foo} --{time_ms, type, holdDuration, specialnotetype, customfunc}
}

module.events = {
    {5000, foo.func} --{time_ms, function}
}

return module
```

- Note types:
    - 1 = Left Note
    - 2 = Down Note
    - 3 = Up Note
    - 4 = Right Note
- Custom notes types:
    - 1 = Custom function
    - 2 = Freeze note
    - 3 = Death note

## audio.ogg
This is the main song (can be renamed but you also need to put song name in song.lua)

# Characters 
The characters are made of separate images.
- died.png
- down.png
- up.png
- right.png
- left.png
- freeze.png
- idle.png

(All images need to be png)

