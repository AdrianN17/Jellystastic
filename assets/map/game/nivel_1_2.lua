return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.4",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 53,
  height = 50,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 17,
  nextobjectid = 109,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "objectgroup",
      id = 16,
      name = "ParedBase",
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
          id = 103,
          name = "ParedBase",
          type = "static",
          shape = "polyline",
          x = -0.00390625,
          y = -0.0117188,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0.0078125, y = 1600.1 }
          },
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisicoSolo"
          }
        },
        {
          id = 104,
          name = "ParedBase",
          type = "static",
          shape = "polyline",
          x = 1696,
          y = -0.03125,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0.0078125, y = 1602.13 }
          },
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisicoSolo"
          }
        },
        {
          id = 107,
          name = "ParedBase",
          type = "static",
          shape = "polyline",
          x = 0,
          y = 0,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 1690.87, y = 0 }
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
      name = "SueloMapa",
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
            ["Es_tierra"] = true,
            ["clase"] = "texturaFisica",
            ["grupo"] = "suelo",
            ["img"] = "1",
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
            ["Es_tierra"] = true,
            ["clase"] = "texturaFisica",
            ["grupo"] = "suelo",
            ["img"] = "1",
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
            ["Es_tierra"] = true,
            ["clase"] = "texturaFisica",
            ["grupo"] = "suelo",
            ["img"] = "1",
            ["uv"] = 2
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 3,
      name = "CasaMapa",
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
            ["img"] = "2",
            ["tipoCalculoDimensiones"] = "triangular"
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
            { x = 272.219, y = -0.59866 }
          },
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "4",
            ["tipoCalculoDimensiones"] = "triangular"
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
      name = "ParedMapa",
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
            ["Es_tierra"] = true,
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
            ["Es_tierra"] = true,
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
            ["Es_tierra"] = true,
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
            ["Es_tierra"] = true,
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
            ["Es_tierra"] = true,
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
            ["Es_tierra"] = true,
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
            ["Es_tierra"] = true,
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
            ["Es_tierra"] = true,
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
            ["Es_tierra"] = true,
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
      name = "Helados",
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
      name = "Plataformas",
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
            ["Es_pasable"] = true,
            ["Es_tierra"] = true,
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
          x = 211.883,
          y = 830.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 47.6207, y = 0 },
            { x = 166.363, y = 0.3333 }
          },
          properties = {
            ["Es_pasable"] = true,
            ["Es_tierra"] = true,
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
          x = 120.679,
          y = 662,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 73.8253, y = 0 },
            { x = 257.908, y = 0.3333 }
          },
          properties = {
            ["Es_pasable"] = true,
            ["Es_tierra"] = true,
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
            ["Es_pasable"] = true,
            ["Es_tierra"] = true,
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
            ["Es_pasable"] = true,
            ["Es_tierra"] = true,
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
            ["Es_pasable"] = true,
            ["Es_tierra"] = true,
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
          x = -14.5324,
          y = 991.75,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 50.101, y = 0 },
            { x = 175.075, y = 0.0208 }
          },
          properties = {
            ["Es_pasable"] = true,
            ["Es_tierra"] = true,
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
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide"
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
            { x = 10.6983, y = -24.6818 },
            { x = 225.454, y = -24.6818 },
            { x = 235.209, y = -0.188804 }
          },
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide"
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
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide"
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
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide"
          }
        },
        {
          id = 76,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 18.9535,
          y = 689.905,
          width = 0,
          height = 0,
          rotation = -49.3721,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 14.0051, y = -20.956 },
            { x = 295.139, y = -20.956 },
            { x = 307.91, y = -0.160304 }
          },
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide"
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
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide"
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
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide"
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
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide"
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
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide"
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
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide"
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
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide"
          }
        },
        {
          id = 83,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 1542,
          y = 509,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 5.86181, y = -24.6818 },
            { x = 123.53, y = -24.6818 },
            { x = 128.875, y = -0.188804 }
          },
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide"
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
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide"
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
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide"
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
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide"
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 6,
      name = "Puertas",
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
            ["Es_portal"] = true,
            ["clase"] = "puerta",
            ["id"] = 4,
            ["img"] = "objetos",
            ["nivel"] = 2,
            ["quad"] = "puerta",
            ["sensor"] = true
          }
        },
        {
          id = 39,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 298,
          y = 562.333,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_portal"] = true,
            ["clase"] = "puerta",
            ["id"] = 5,
            ["img"] = "objetos",
            ["nivel"] = 2,
            ["quad"] = "puerta",
            ["sensor"] = true
          }
        },
        {
          id = 44,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 590,
          y = 929.667,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_portal"] = true,
            ["clase"] = "puerta",
            ["id"] = 6,
            ["img"] = "objetos",
            ["nivel"] = 2,
            ["quad"] = "puerta",
            ["sensor"] = true
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
            ["Es_portal"] = true,
            ["clase"] = "puerta",
            ["id"] = 7,
            ["img"] = "objetos",
            ["nivel"] = 2,
            ["quad"] = "puerta",
            ["sensor"] = true
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
            ["Es_portal"] = true,
            ["clase"] = "puerta",
            ["id"] = 8,
            ["img"] = "objetos",
            ["nivel"] = 2,
            ["quad"] = "puerta",
            ["sensor"] = true
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 7,
      name = "Movibles",
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
          x = 98.0531,
          y = 778.583,
          width = 33.5,
          height = 37.5,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_movible"] = true,
            ["Es_movibleFacil"] = true,
            ["Es_tierra"] = true,
            ["clase"] = "movible",
            ["img"] = "objetos",
            ["quad"] = "caja"
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 8,
      name = "Armas",
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
          width = 100,
          height = 25,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_usable"] = true,
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
      name = "Objetos",
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
            ["Es_usable"] = true,
            ["clase"] = "municion",
            ["img"] = "municion",
            ["quad"] = "1",
            ["sensor"] = true,
            ["tipo"] = 2
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
            ["Es_usable"] = true,
            ["clase"] = "municion",
            ["img"] = "municion",
            ["quad"] = "1",
            ["sensor"] = true,
            ["tipo"] = 2
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
            ["Es_usable"] = true,
            ["clase"] = "municion",
            ["img"] = "municion",
            ["quad"] = "1",
            ["sensor"] = true,
            ["tipo"] = 5
          }
        },
        {
          id = 69,
          name = "Vida",
          type = "static",
          shape = "rectangle",
          x = 904,
          y = 969,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_usable"] = true,
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
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_usable"] = true,
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
      id = 14,
      name = "Enemigos",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["tabla"] = "enemigos"
      },
      objects = {
        {
          id = 94,
          name = "ZombieCreador",
          type = "manager",
          shape = "point",
          x = 20,
          y = 32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_colisionableAtaque"] = true,
            ["Es_danoFisico"] = true,
            ["Es_explotaMorir"] = true,
            ["Es_unico"] = true,
            ["clase"] = "zombieCreador",
            ["hp"] = 20,
            ["img"] = "jugador",
            ["limiteVision"] = 100,
            ["subclase"] = "enemigo2",
            ["tag"] = "infectado",
            ["velocidad"] = 130
          }
        },
        {
          id = 96,
          name = "Baba",
          type = "dynamic",
          shape = "rectangle",
          x = 1449,
          y = 731,
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
        },
        {
          id = 97,
          name = "Baba",
          type = "dynamic",
          shape = "rectangle",
          x = 1058.33,
          y = 730.333,
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
        },
        {
          id = 98,
          name = "Baba",
          type = "dynamic",
          shape = "rectangle",
          x = 1155.67,
          y = 553,
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
      id = 10,
      name = "NPCS",
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
          id = 99,
          name = "Npc",
          type = "dynamic",
          shape = "rectangle",
          x = 450,
          y = 949.5,
          width = 50,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_danoExplosivo"] = true,
            ["Es_explotaMorir"] = true,
            ["Es_salvable"] = true,
            ["Es_transformarZombie"] = true,
            ["clase"] = "npc",
            ["h"] = 0.1,
            ["hp"] = 8,
            ["img"] = "jugador",
            ["quad"] = "2",
            ["s"] = 0,
            ["tag"] = "humano"
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 13,
      name = "Jugadores",
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
