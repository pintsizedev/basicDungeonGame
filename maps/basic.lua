return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 10,
  height = 10,
  tilewidth = 16,
  tileheight = 16,
  properties = {},
  tilesets = {
    {
      name = "dungeon_sheet_0",
      firstgid = 1,
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      image = "../images/dungeon_sheet_0.png",
      imagewidth = 384,
      imageheight = 160,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      tiles = {
        {
          id = 176,
          animation = {
            {
              tileid = "176",
              duration = "100"
            },
            {
              tileid = "177",
              duration = "100"
            },
            {
              tileid = "178",
              duration = "100"
            },
            {
              tileid = "179",
              duration = "100"
            },
            {
              tileid = "180",
              duration = "100"
            },
            {
              tileid = "181",
              duration = "100"
            },
            {
              tileid = "180",
              duration = "100"
            },
            {
              tileid = "179",
              duration = "100"
            },
            {
              tileid = "178",
              duration = "100"
            },
            {
              tileid = "177",
              duration = "100"
            },
            {
              tileid = "176",
              duration = "100"
            }
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Tile Layer 1",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        55, 55, 55, 55, 55, 55, 55, 55, 55, 55,
        55, 55, 55, 55, 55, 55, 55, 55, 55, 55,
        55, 55, 55, 55, 55, 55, 55, 55, 55, 55,
        55, 55, 55, 55, 55, 55, 55, 55, 55, 55,
        55, 55, 55, 55, 55, 55, 55, 55, 55, 55,
        55, 55, 55, 55, 55, 55, 55, 55, 55, 55,
        55, 55, 55, 55, 55, 55, 55, 55, 55, 55,
        55, 55, 55, 55, 55, 55, 55, 55, 55, 55,
        55, 55, 55, 55, 55, 55, 55, 55, 55, 55,
        55, 55, 55, 55, 55, 55, 55, 55, 55, 55
      }
    },
    {
      type = "tilelayer",
      name = "Chest",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 177, 177, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "Pillars",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 19, 20, 0, 0, 0, 0, 19, 20, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "Walls",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        6, 7, 7, 7, 7, 7, 7, 7, 7, 8,
        30, 31, 31, 31, 31, 31, 31, 31, 31, 32,
        54, 0, 0, 0, 0, 0, 0, 0, 0, 56,
        54, 0, 0, 0, 0, 0, 0, 0, 0, 56,
        54, 0, 0, 0, 0, 0, 0, 0, 0, 56,
        54, 0, 0, 0, 0, 0, 0, 0, 0, 56,
        54, 0, 0, 0, 0, 0, 0, 0, 0, 56,
        54, 43, 44, 0, 0, 0, 0, 43, 44, 56,
        54, 67, 68, 0, 0, 0, 0, 67, 68, 56,
        78, 79, 79, 79, 79, 79, 79, 79, 79, 80
      }
    },
    {
      type = "tilelayer",
      name = "Collision",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = false,
      opacity = 1,
      properties = {
        ["visible"] = "false"
      },
      encoding = "lua",
      data = {
        206, 206, 206, 206, 206, 206, 206, 206, 206, 206,
        206, 206, 206, 206, 206, 206, 206, 206, 206, 206,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 206, 206, 0, 0, 0, 0, 206, 206, 0,
        0, 206, 206, 0, 0, 0, 0, 206, 206, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
