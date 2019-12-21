return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 70,
  height = 20,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 4,
  nextobjectid = 17,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "objectgroup",
      id = 3,
      name = "Borrador",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 7,
          name = "Personaje",
          type = "",
          shape = "point",
          x = 126,
          y = 278,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "Terreno",
          type = "",
          shape = "polygon",
          x = 1.33,
          y = 469.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 354, y = 6 },
            { x = 536, y = -83 },
            { x = 835, y = -85 },
            { x = 1104, y = 28 },
            { x = 1201, y = 163 },
            { x = -1, y = 163 }
          },
          properties = {}
        },
        {
          id = 9,
          name = "Terreno",
          type = "",
          shape = "polygon",
          x = 1446,
          y = 636,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 138.667, y = -129.333 },
            { x = 310.667, y = -133.333 },
            { x = 397.333, y = -177.333 },
            { x = 500, y = -124 },
            { x = 592, y = -208 },
            { x = 790.667, y = -220 },
            { x = 793.333, y = -4 }
          },
          properties = {}
        }
      }
    }
  }
}
