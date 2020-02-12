return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 60,
  height = 30,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 3,
  nextobjectid = 10,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "objectgroup",
      id = 2,
      name = "Borrador",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "Gelatina",
          type = "",
          shape = "polygon",
          x = -4.18149,
          y = 572.864,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 1931.2, y = -1.39383 },
            { x = 1928.41, y = 391.666 },
            { x = 5.58149, y = 390.272 }
          },
          properties = {}
        },
        {
          id = 3,
          name = "Puerta",
          type = "1",
          shape = "rectangle",
          x = 89.9056,
          y = 473.777,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["id"] = 1
          }
        },
        {
          id = 4,
          name = "Baba",
          type = "",
          shape = "point",
          x = 1378.79,
          y = 524.242,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "Puerta",
          type = "1",
          shape = "rectangle",
          x = 752.667,
          y = 470,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["id"] = 3
          }
        },
        {
          id = 6,
          name = "Puerta",
          type = "1",
          shape = "rectangle",
          x = 428.667,
          y = 472.667,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["id"] = 2
          }
        },
        {
          id = 7,
          name = "Puerta",
          type = "1",
          shape = "rectangle",
          x = 1171.33,
          y = 472.667,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["id"] = 4
          }
        },
        {
          id = 8,
          name = "Puerta",
          type = "1",
          shape = "rectangle",
          x = 1606,
          y = 467.333,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["id"] = 5
          }
        },
        {
          id = 9,
          name = "Puerta",
          type = "1",
          shape = "rectangle",
          x = 1835.33,
          y = 470,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["id"] = 6
          }
        }
      }
    }
  }
}
