return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.4",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 30,
  height = 20,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 8,
  nextobjectid = 16,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "objectgroup",
      id = 3,
      name = "paredBase",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["tabla"] = "paredBase"
      },
      objects = {
        {
          id = 4,
          name = "ParedBase",
          type = "static",
          shape = "polyline",
          x = 2.03421,
          y = 0.946382,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0.0078125, y = 635.007 }
          },
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisicoSolo"
          }
        },
        {
          id = 5,
          name = "ParedBase",
          type = "static",
          shape = "polyline",
          x = 961.288,
          y = 0.958092,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0.0078125, y = 638.28 }
          },
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisicoSolo"
          }
        },
        {
          id = 6,
          name = "ParedBase",
          type = "static",
          shape = "polyline",
          x = 2.0303,
          y = 2.09091,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 956.05, y = 0 }
          },
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisicoSolo"
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 2,
      name = "sueloMapa",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["tabla"] = "sueloMapa"
      },
      objects = {
        {
          id = 1,
          name = "Gelatina",
          type = "static",
          shape = "rectangle",
          x = 0.665,
          y = 418.5,
          width = 469.67,
          height = 221,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "texturaFisica",
            ["grupo"] = "suelo",
            ["img"] = "1",
            ["uv"] = 2
          }
        },
        {
          id = 3,
          name = "Gelatina",
          type = "static",
          shape = "rectangle",
          x = 469.165,
          y = 580.5,
          width = 493.67,
          height = 61,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "texturaFisica",
            ["grupo"] = "suelo",
            ["img"] = "1",
            ["uv"] = 2
          }
        },
        {
          id = 15,
          name = "Baba",
          type = "dynamic",
          shape = "rectangle",
          x = 299.667,
          y = 324.333,
          width = 70,
          height = 90,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_danoExplosivo"] = true,
            ["Es_danoFisico"] = true,
            ["Es_explotaMorir"] = true,
            ["clase"] = "enemigo1",
            ["hp"] = 15,
            ["img"] = "baba",
            ["limiteVision"] = 350,
            ["tag"] = "infectado",
            ["velocidad"] = 80
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 4,
      name = "Liquido",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["tabla"] = "liquidoMapa"
      },
      objects = {
        {
          id = 2,
          name = "Gaseosa",
          type = "static",
          shape = "rectangle",
          x = 469.682,
          y = 449.333,
          width = 492.636,
          height = 131.333,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_liquido"] = true,
            ["clase"] = "liquido",
            ["densidad"] = 75,
            ["grupo"] = "liquido",
            ["img"] = "1"
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 6,
      name = "Jugadores",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["tabla"] = "jugadores"
      },
      objects = {
        {
          id = 7,
          name = "Player",
          type = "dynamic",
          shape = "rectangle",
          x = 16.3333,
          y = 334.667,
          width = 50,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_danoExplosivo"] = true,
            ["Es_explotaMorir"] = true,
            ["Es_transformarZombie"] = true,
            ["armaIndex"] = 1,
            ["clase"] = "player",
            ["hp"] = 25,
            ["img"] = "jugador",
            ["imgAccesorio"] = "accesorios",
            ["salto"] = 30,
            ["tag"] = "humano",
            ["velocidad"] = 175
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 7,
      name = "Enemigos",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["tabla"] = "enemigos"
      },
      objects = {}
    },
    {
      type = "objectgroup",
      id = 5,
      name = "Balas",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["tabla"] = "balas"
      },
      objects = {}
    }
  }
}