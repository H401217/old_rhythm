local foo = {
    ignore = false, --Botplay will check if this note needs to be ignored (true for death notes, false for necessary notes)
    func = function(info) --Main Function (you can use "love" functions)
      love.window.setTitle("Bruh xd amogus")
      love.window.setPosition(50,50)
      module.bg = love.graphics.newImage("songs/test/bg1.png")
    end,
    img = love.graphics.newImage("assets/Note.png"), --Note Image
    points = 10, --Points awarded for pressing note
}

local function foo2()
  module.bg = love.graphics.newImage("songs/test/bg2.png")
end

module = {}

module.title = "sus audio"
module.sound = "audio.ogg"
module.offset = 180
module.bg = nil

module.start = function(data)
	data.obj.newDeltaFunc("a",nil,nil,function(delta,dat)
	--[[local a = dat.obj.imgs["left"]
	a.pY = a.pY+1]]
	dat.obj.imgs["left"].pY = dat.obj.imgs["left"].pY+1*delta
	return dat
	end)
end

module.notes = {
  {1261,4};
  {1391,4};
  {1477,2};
  {1521,4};
  {1694,4};
  {1738,2};
  {1868,4};
  {1954,1};
  {2041,4};
  {2128,1};
  {2214,4};
  {2301,1};
  {2388,4};
  {2518,4};
  {2605,2};
  {2735,4};
  {2865,4};
  {2951,2};
  {3081,3};
  {3212,3};
  {3255,1};
  {3385,2};
  {3515,4};
  {3645,4};
  {3775,4};
  {3862,2};
  {3992,4};
  {4122,4};
  {4122,2};
  {4252,4};
  {4382,1};
  {4469,4};
  {4555,1};
  {4599,4};
  {4729,1};
  {4772,4};
  {4946,2};
  {5119,2};
  {5206,4};
  {5336,4};
  {5379,2};
  {5509,3};
  {5639,1};
  {5769,1};
  {5856,2};
  {5943,4};
  {6073,4};
  {6160,4};
  {6246,3};
  {6333,2};
  {6463,2};
  {6506,3};
  {6636,3};
  {6680,2};
  {6810,1};
  {6897,2};
  {6983,1};
  {7070,2};
  {7113,3};
  {7243,2};
  {7287,1};
  {7330,4};
  {7460,3};
  {7590,2};
  {7720,3};
  {7720,2};
  {7894,2};
  {7937,1};
  {8067,2};
  {8154,1};
  {8197,2};
  {8284,3};
  {8371,2};
  {8457,1};
  {8631,2};
  {8761,3};
  {8891,4};
  {9021,4};
  {9151,4};
  {9238,4};
  {9368,4};
  {9411,1};
  {9454,2};
  {9584,3};
  {9714,3};
  {9844,4};
  {10018,4};
  {10148,4};
  {10278,1};
  {10321,2};
  {10408,3};
  {10538,1};
  {10581,4};
  {10625,2};
  {10755,3};
  {10842,4};
  {10885,1};
  {10972,2};
  {11145,2};
  {11188,3};
  {11362,4};
  {11535,4};
  {11665,4};
  {11752,1};
  {11882,2};
  {11969,3};
  {12099,3};
  {12229,4};
  {12359,4};
  {12532,4};
  {12619,1};
  {12706,2};
  {12792,3};
  {12923,4};
  {12966,1};
  {13053,2};
  {13096,3};
  {13183,4};
  {13399,2};
  {13399,4};
  {13573,1};
  {13703,2};
  {13876,4};
  {14006,4};
  {14050,1};
  {14136,4};
  {14266,4};
  {14353,3};
  {14483,3};
  {14657,2};
  {14657,3};
  {14787,4};
  {14960,2};
  {15090,1};
  {15177,3};
  {15307,3};
  {15394,2};
  {15567,2};
  {15654,4};
  {15784,4};
  {15827,2};
  {15957,1};
  {16044,2};
  {16217,4};
  {16347,4};
  {16434,1};
  {16521,4};
  {16651,4};
  {16781,3};
  {16911,3};
  {17041,2};
  {17171,4};
  {17344,2};
  {17475,1};
  {17605,4};
  {17735,4};
  {17821,3};
  {17908,2};
  {18081,2};
  {18081,1};
  {18212,3};
  {18298,4};
  {18428,1};
  {18472,3};
  {18602,4};
  {18732,1};
  {18818,3};
  {18905,4};
  {19035,1};
  {19122,3};
  {19165,4};
  {19382,4};
  {19512,2};
  {19599,4};
  {19729,4};
  {19816,2};
  {19946,4};
  {20119,2};
  {20249,1};
  {20379,2};
  {20509,3};
  {20596,4};
  {20596,1};
  {20813,3};
  {20899,4};
  {20899,1};
  {21116,1};
  {21203,3};
  {21290,4};
  {21420,1};
  {21506,3};
  {21593,4};
  {21766,4};
  {21897,1};
  {22027,2};
  {22200,2};
  {22287,4};
  {22460,4};
  {22634,1};
  {22677,2};
  {22807,3,1214};
  {25191,3};
}

module.events = {
  {0, function() module.bg = nil end};
  {5000, foo.func};
  {22807, foo2};
  {25191, function() love.event.quit() end}
}

return module
