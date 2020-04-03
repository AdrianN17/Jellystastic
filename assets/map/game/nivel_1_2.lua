return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 53,
  height = 50,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 14,
  nextobjectid = 92,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "objectgroup",
      id = 2,
      name = "Capa de Objetos 1",
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
          x = -0.0688468,
          y = 1379.22,
          width = 415.337,
          height = 221,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "texturaFisica",
            ["grupo"] = "suelo",
            ["img"] = "1",
            ["userdataNombre"] = "piso",
            ["uv"] = 2
          }
        },
        {
          id = 12,
          name = "Gelatina",
          type = "static",
          shape = "rectangle",
          x = 414.998,
          y = 1377.5,
          width = 1283.34,
          height = 221,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "texturaFisica",
            ["grupo"] = "suelo",
            ["img"] = "1",
            ["userdataNombre"] = "piso",
            ["uv"] = 2
          }
        },
        {
          id = 13,
          name = "Gelatina",
          type = "static",
          shape = "rectangle",
          x = 415.665,
          y = 1028.17,
          width = 1282,
          height = 351.667,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "texturaFisica",
            ["grupo"] = "suelo",
            ["img"] = "1",
            ["userdataNombre"] = "piso",
            ["uv"] = 2
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 3,
      name = "Capa de Objetos 2",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["tabla"] = "casaMapa"
      },
      objects = {
        {
          id = 3,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 35.5,
          y = 662.5,
          width = 342.818,
          height = 717,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "2"
          }
        },
        {
          id = 4,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 203.5,
          y = 475.5,
          width = 174.727,
          height = 187,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "2"
          }
        },
        {
          id = 5,
          name = "Casa",
          type = "none",
          shape = "polygon",
          x = 36.5,
          y = 663.125,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 167.25, y = -187.875 },
            { x = 166.75, y = -0.250834 }
          },
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["heightArreglo"] = 1.5,
            ["img"] = "2",
            ["tipoCalculoDimensiones"] = "triangular",
            ["widthArreglo"] = 1.5
          }
        },
        {
          id = 15,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 448.955,
          y = 663.833,
          width = 352.454,
          height = 365,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "3"
          }
        },
        {
          id = 19,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 875.591,
          y = 506.5,
          width = 788.818,
          height = 521,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "4"
          }
        },
        {
          id = 20,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 1333.64,
          y = 319.5,
          width = 174.727,
          height = 187,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "4"
          }
        },
        {
          id = 21,
          name = "Casa",
          type = "none",
          shape = "polygon",
          x = 1061.64,
          y = 507.125,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 272.25, y = -187.875 },
            { x = 271.436, y = -0.250834 }
          },
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["heightArreglo"] = 1.5,
            ["img"] = "4",
            ["tipoCalculoDimensiones"] = "triangular",
            ["widthArreglo"] = 1.5
          }
        },
        {
          id = 43,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 377,
          y = 776,
          width = 36.6818,
          height = 52.25,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "2"
          }
        },
        {
          id = 89,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 413.72,
          y = 763.875,
          width = 35.6818,
          height = 82.4318,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "3"
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 4,
      name = "Capa de Objetos 3",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["tabla"] = "paredMapa"
      },
      objects = {
        {
          id = 8,
          name = "Pared",
          type = "static",
          shape = "rectangle",
          x = -0.375183,
          y = 662.334,
          width = 35.6667,
          height = 717,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "texturaFisica",
            ["grupo"] = "pared",
            ["img"] = "1"
          }
        },
        {
          id = 9,
          name = "Pared",
          type = "static",
          shape = "rectangle",
          x = 378.125,
          y = 827.167,
          width = 35.6667,
          height = 552.5,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "texturaFisica",
            ["grupo"] = "pared",
            ["img"] = "1"
          }
        },
        {
          id = 10,
          name = "Pared",
          type = "static",
          shape = "rectangle",
          x = 413.712,
          y = 845.886,
          width = 35.6667,
          height = 182,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "texturaFisica",
            ["grupo"] = "pared",
            ["img"] = "2"
          }
        },
        {
          id = 16,
          name = "Pared",
          type = "static",
          shape = "rectangle",
          x = 801.621,
          y = 663.083,
          width = 37.394,
          height = 364.833,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "texturaFisica",
            ["grupo"] = "pared",
            ["img"] = "2"
          }
        },
        {
          id = 18,
          name = "Pared",
          type = "static",
          shape = "rectangle",
          x = 839.167,
          y = 505.834,
          width = 35.6667,
          height = 522.583,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "texturaFisica",
            ["grupo"] = "pared",
            ["img"] = "1"
          }
        },
        {
          id = 22,
          name = "Pared",
          type = "static",
          shape = "rectangle",
          x = 1666.83,
          y = 506.709,
          width = 29.6667,
          height = 522.583,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "texturaFisica",
            ["grupo"] = "pared",
            ["img"] = "1"
          }
        },
        {
          id = 27,
          name = "Pared",
          type = "static",
          shape = "rectangle",
          x = 1508.83,
          y = 316.25,
          width = 35.6667,
          height = 194.166,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "texturaFisica",
            ["grupo"] = "pared",
            ["img"] = "1"
          }
        },
        {
          id = 40,
          name = "Pared",
          type = "static",
          shape = "rectangle",
          x = 378.833,
          y = 447.583,
          width = 35.6667,
          height = 329.5,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "texturaFisica",
            ["grupo"] = "pared",
            ["img"] = "1"
          }
        },
        {
          id = 88,
          name = "Pared",
          type = "static",
          shape = "rectangle",
          x = 414.833,
          y = 665,
          width = 35.6667,
          height = 99.3333,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "texturaFisica",
            ["grupo"] = "pared",
            ["img"] = "2"
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 11,
      name = "Capa de Objetos 10",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["tabla"] = "helados"
      },
      objects = {
        {
          id = 64,
          name = "Helado",
          type = "none",
          shape = "rectangle",
          x = 449.917,
          y = 511.917,
          width = 352.167,
          height = 156.667,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "sundae",
            ["quad"] = "3"
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 5,
      name = "Capa de Objetos 4",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["tabla"] = "Plataformas"
      },
      objects = {
        {
          id = 31,
          name = "Chicle",
          type = "static",
          shape = "polyline",
          x = 216.701,
          y = 1185,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 46.053, y = 0 },
            { x = 160.886, y = 0.3333 }
          },
          properties = {
            ["clase"] = "objetoFisico",
            ["height"] = 10,
            ["img"] = "objetos",
            ["posicion_y"] = 0,
            ["quad"] = "chicle",
            ["tipoCalculoDimensiones"] = "linea"
          }
        },
        {
          id = 36,
          name = "Chicle",
          type = "static",
          shape = "polyline",
          x = 213.451,
          y = 830.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 46.053, y = 0 },
            { x = 160.886, y = 0.3333 }
          },
          properties = {
            ["clase"] = "objetoFisico",
            ["height"] = 10,
            ["img"] = "objetos",
            ["posicion_y"] = 0,
            ["quad"] = "chicle",
            ["tipoCalculoDimensiones"] = "linea"
          }
        },
        {
          id = 38,
          name = "Chicle",
          type = "static",
          shape = "polyline",
          x = 121.982,
          y = 665,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 72.5219, y = 0 },
            { x = 253.355, y = 0.3333 }
          },
          properties = {
            ["clase"] = "objetoFisico",
            ["height"] = 10,
            ["img"] = "objetos",
            ["posicion_y"] = 0,
            ["quad"] = "chicle",
            ["tipoCalculoDimensiones"] = "linea"
          }
        },
        {
          id = 45,
          name = "Chicle",
          type = "static",
          shape = "polyline",
          x = 640,
          y = 801.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 46.053, y = 0 },
            { x = 160.886, y = 0.3333 }
          },
          properties = {
            ["clase"] = "objetoFisico",
            ["height"] = 10,
            ["img"] = "objetos",
            ["posicion_y"] = 0,
            ["quad"] = "chicle",
            ["tipoCalculoDimensiones"] = "linea"
          }
        },
        {
          id = 46,
          name = "Chicle",
          type = "static",
          shape = "polyline",
          x = 897.822,
          y = 507.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 174.897, y = 0 },
            { x = 611.003, y = 0.3333 }
          },
          properties = {
            ["clase"] = "objetoFisico",
            ["height"] = 10,
            ["img"] = "objetos",
            ["posicion_y"] = 0,
            ["quad"] = "chicle",
            ["tipoCalculoDimensiones"] = "linea"
          }
        },
        {
          id = 54,
          name = "Chicle",
          type = "static",
          shape = "polyline",
          x = 1145.15,
          y = 819.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 74.5271, y = 0 },
            { x = 260.36, y = 0.3333 }
          },
          properties = {
            ["clase"] = "objetoFisico",
            ["height"] = 10,
            ["img"] = "objetos",
            ["posicion_y"] = 0,
            ["quad"] = "chicle",
            ["tipoCalculoDimensiones"] = "linea"
          }
        },
        {
          id = 71,
          name = "Chicle",
          type = "static",
          shape = "polyline",
          x = -12.3086,
          y = 991.75,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 49.3616, y = 0 },
            { x = 172.445, y = 0.3333 }
          },
          properties = {
            ["clase"] = "objetoFisico",
            ["height"] = 10,
            ["img"] = "objetos",
            ["posicion_y"] = 0,
            ["quad"] = "chicle",
            ["tipoCalculoDimensiones"] = "linea"
          }
        },
        {
          id = 72,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 27.3333,
          y = 1193.33,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 10.8651, y = -24.6818 },
            { x = 228.968, y = -24.6818 },
            { x = 238.875, y = -0.188804 }
          },
          properties = {
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide",
            ["userdataNombre"] = "piso"
          }
        },
        {
          id = 73,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 154.667,
          y = 1005.33,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 10.5315, y = -24.6818 },
            { x = 221.939, y = -24.6818 },
            { x = 231.542, y = -0.188804 }
          },
          properties = {
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide",
            ["userdataNombre"] = "piso"
          }
        },
        {
          id = 74,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 24,
          y = 840.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 10.8651, y = -24.6818 },
            { x = 228.968, y = -24.6818 },
            { x = 238.875, y = -0.188804 }
          },
          properties = {
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide",
            ["userdataNombre"] = "piso"
          }
        },
        {
          id = 75,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 187,
          y = 476,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 9.50057, y = -24.6818 },
            { x = 200.212, y = -24.6818 },
            { x = 208.875, y = -0.188804 }
          },
          properties = {
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide",
            ["userdataNombre"] = "piso"
          }
        },
        {
          id = 76,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 35.5059,
          y = 670.612,
          width = 0,
          height = 0,
          rotation = -49.3721,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 12.8489, y = -20.956 },
            { x = 270.773, y = -20.956 },
            { x = 282.489, y = -0.160304 }
          },
          properties = {
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide",
            ["userdataNombre"] = "piso"
          }
        },
        {
          id = 77,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 431,
          y = 687,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 17.6423, y = -37.6818 },
            { x = 371.788, y = -37.6818 },
            { x = 387.875, y = -0.288248 }
          },
          properties = {
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide",
            ["userdataNombre"] = "piso"
          }
        },
        {
          id = 78,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 867,
          y = 844.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 16.869, y = -24.6818 },
            { x = 355.493, y = -24.6818 },
            { x = 370.875, y = -0.188804 }
          },
          properties = {
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide",
            ["userdataNombre"] = "piso"
          }
        },
        {
          id = 79,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 1395,
          y = 844.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 12.9119, y = -24.6818 },
            { x = 272.102, y = -24.6818 },
            { x = 283.875, y = -0.188804 }
          },
          properties = {
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide",
            ["userdataNombre"] = "piso"
          }
        },
        {
          id = 80,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 867,
          y = 667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 12.9119, y = -24.6818 },
            { x = 272.102, y = -24.6818 },
            { x = 283.875, y = -0.188804 }
          },
          properties = {
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide",
            ["userdataNombre"] = "piso"
          }
        },
        {
          id = 81,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 1123,
          y = 667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 12.9119, y = -24.6818 },
            { x = 272.102, y = -24.6818 },
            { x = 283.875, y = -0.188804 }
          },
          properties = {
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide",
            ["userdataNombre"] = "piso"
          }
        },
        {
          id = 82,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 1366,
          y = 667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 7.31731, y = -24.6818 },
            { x = 154.203, y = -24.6818 },
            { x = 160.875, y = -0.188804 }
          },
          properties = {
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide",
            ["userdataNombre"] = "piso"
          }
        },
        {
          id = 83,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 1518,
          y = 509,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 7.31731, y = -24.6818 },
            { x = 154.203, y = -24.6818 },
            { x = 160.875, y = -0.188804 }
          },
          properties = {
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide",
            ["userdataNombre"] = "piso"
          }
        },
        {
          id = 84,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 1308.5,
          y = 324,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 9.59153, y = -24.6818 },
            { x = 202.129, y = -24.6818 },
            { x = 210.875, y = -0.188804 }
          },
          properties = {
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide",
            ["userdataNombre"] = "piso"
          }
        },
        {
          id = 85,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 860,
          y = 511.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 9.47782, y = -24.6818 },
            { x = 199.733, y = -24.6818 },
            { x = 208.375, y = -0.188804 }
          },
          properties = {
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide",
            ["userdataNombre"] = "piso"
          }
        },
        {
          id = 86,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 1063.68,
          y = 508.649,
          width = 0,
          height = 0,
          rotation = -34.3864,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 15.55, y = -29.8293 },
            { x = 327.696, y = -29.8293 },
            { x = 341.874, y = -0.22818 }
          },
          properties = {
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide",
            ["userdataNombre"] = "piso"
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 6,
      name = "Capa de Objetos 5",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["tabla"] = "puertas"
      },
      objects = {
        {
          id = 32,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 160,
          y = 1279,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "puerta",
            ["id"] = 4,
            ["img"] = "objetos",
            ["nivel"] = 2,
            ["quad"] = "puerta",
            ["sensor"] = true,
            ["userdataNombre"] = "puerta"
          }
        },
        {
          id = 39,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 298,
          y = 559.333,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "puerta",
            ["id"] = 5,
            ["img"] = "objetos",
            ["nivel"] = 2,
            ["quad"] = "puerta",
            ["sensor"] = true,
            ["userdataNombre"] = "puerta"
          }
        },
        {
          id = 44,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 590,
          y = 924.667,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "puerta",
            ["id"] = 6,
            ["img"] = "objetos",
            ["nivel"] = 2,
            ["quad"] = "puerta",
            ["sensor"] = true,
            ["userdataNombre"] = "puerta"
          }
        },
        {
          id = 47,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 1231.33,
          y = 927.333,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "puerta",
            ["id"] = 7,
            ["img"] = "objetos",
            ["nivel"] = 2,
            ["quad"] = "puerta",
            ["sensor"] = true,
            ["userdataNombre"] = "puerta"
          }
        },
        {
          id = 48,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 1408.67,
          y = 406,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "puerta",
            ["id"] = 8,
            ["img"] = "objetos",
            ["nivel"] = 2,
            ["quad"] = "puerta",
            ["sensor"] = true,
            ["userdataNombre"] = "puerta"
          }
        },
        {
          id = 65,
          name = "Baba",
          type = "",
          shape = "rectangle",
          x = 1038,
          y = 726,
          width = 70,
          height = 90,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 66,
          name = "Baba",
          type = "",
          shape = "rectangle",
          x = 1421,
          y = 724,
          width = 70,
          height = 90,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 67,
          name = "Baba",
          type = "",
          shape = "rectangle",
          x = 1234,
          y = 551,
          width = 70,
          height = 90,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      id = 7,
      name = "Capa de Objetos 6",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["tabla"] = "movibles"
      },
      objects = {
        {
          id = 42,
          name = "Caja",
          type = "dynamic",
          shape = "rectangle",
          x = 98.4167,
          y = 766.583,
          width = 33.5,
          height = 37.5,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "movible",
            ["img"] = "objetos",
            ["quad"] = "caja"
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 10,
      name = "Capa de Objetos 9",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["tabla"] = "npcs"
      },
      objects = {
        {
          id = 63,
          name = "Npc",
          type = "",
          shape = "rectangle",
          x = 465.667,
          y = 950,
          width = 50,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 8,
      name = "Capa de Objetos 7",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["tabla"] = "Armas"
      },
      objects = {
        {
          id = 57,
          name = "Arma",
          type = "static",
          shape = "rectangle",
          x = 879,
          y = 776.5,
          width = 105.333,
          height = 34.5,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "arma",
            ["img"] = "armas",
            ["quad"] = "5",
            ["sensor"] = true
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 9,
      name = "Capa de Objetos 8",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["tabla"] = "Objetos"
      },
      objects = {
        {
          id = 59,
          name = "Municion",
          type = "static",
          shape = "rectangle",
          x = 687,
          y = 770,
          width = 40,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "municion",
            ["img"] = "municion",
            ["quad"] = "1",
            ["sensor"] = true
          }
        },
        {
          id = 60,
          name = "Municion",
          type = "static",
          shape = "rectangle",
          x = 746,
          y = 770,
          width = 40,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "municion",
            ["img"] = "municion",
            ["quad"] = "1",
            ["sensor"] = true
          }
        },
        {
          id = 61,
          name = "Municion",
          type = "static",
          shape = "rectangle",
          x = 887,
          y = 607,
          width = 40,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "municion",
            ["img"] = "municion",
            ["quad"] = "1",
            ["sensor"] = true
          }
        },
        {
          id = 69,
          name = "Vida",
          type = "static",
          shape = "rectangle",
          x = 904,
          y = 979,
          width = 30,
          height = 35,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "vida",
            ["img"] = "vida",
            ["quad"] = "1",
            ["sensor"] = true
          }
        },
        {
          id = 70,
          name = "Vida",
          type = "static",
          shape = "rectangle",
          x = 1606,
          y = 975.5,
          width = 30,
          height = 35,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "vida",
            ["img"] = "vida",
            ["quad"] = "1",
            ["sensor"] = true
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 13,
      name = "Capa de Objetos 12",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["tabla"] = "jugadores"
      },
      objects = {}
    },
    {
      type = "objectgroup",
      id = 12,
      name = "Capa de Objetos 11",
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
