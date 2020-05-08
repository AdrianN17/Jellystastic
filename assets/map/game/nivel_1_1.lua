return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.4",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 37,
  height = 35,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 15,
  nextobjectid = 66,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "objectgroup",
      id = 14,
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
          id = 61,
          name = "ParedBase",
          type = "static",
          shape = "polyline",
          x = -0.0342093,
          y = -1.16323,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0.0078125, y = 1124.34 }
          },
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisicoSolo"
          }
        },
        {
          id = 62,
          name = "ParedBase",
          type = "static",
          shape = "polyline",
          x = 1184.22,
          y = -1.15152,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0.0078125, y = 1126.28 }
          },
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisicoSolo"
          }
        },
        {
          id = 63,
          name = "ParedBase",
          type = "static",
          shape = "polyline",
          x = -0.0381155,
          y = -0.0187027,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 1184.05, y = 0 }
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
          id = 2,
          name = "Gelatina",
          type = "static",
          shape = "rectangle",
          x = -4.44089e-16,
          y = 896,
          width = 1184.67,
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
          id = 4,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 32.0455,
          y = 512.091,
          width = 320.25,
          height = 384,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "1"
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
          id = 7,
          name = "Pared",
          type = "static",
          shape = "rectangle",
          x = 0.299242,
          y = 480.917,
          width = 32,
          height = 415,
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
          id = 8,
          name = "Pared",
          type = "static",
          shape = "rectangle",
          x = 352.549,
          y = 481.104,
          width = 31.7778,
          height = 415,
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
          x = 384.333,
          y = 192,
          width = 32,
          height = 704,
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
          id = 11,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 416.417,
          y = 226.971,
          width = 349.333,
          height = 668.985,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "2"
          }
        },
        {
          id = 13,
          name = "Pared",
          type = "static",
          shape = "rectangle",
          x = 765.769,
          y = 192.136,
          width = 32,
          height = 704,
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
          id = 14,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 829.732,
          y = 512.217,
          width = 320.25,
          height = 384,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "5"
          }
        },
        {
          id = 15,
          name = "Pared",
          type = "static",
          shape = "rectangle",
          x = 797.986,
          y = 511.543,
          width = 32,
          height = 384.5,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "texturaFisica",
            ["grupo"] = "pared",
            ["img"] = "3"
          }
        },
        {
          id = 16,
          name = "Pared",
          type = "static",
          shape = "rectangle",
          x = 1150.24,
          y = 511.73,
          width = 34.2778,
          height = 384.5,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "texturaFisica",
            ["grupo"] = "pared",
            ["img"] = "3"
          }
        },
        {
          id = 43,
          name = "Helado",
          type = "none",
          shape = "rectangle",
          x = 412.999,
          y = 39.6665,
          width = 351.667,
          height = 187.334,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "sundae",
            ["quad"] = "2"
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 9,
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
          id = 41,
          name = "Helado",
          type = "none",
          shape = "rectangle",
          x = 33.6665,
          y = 339.667,
          width = 321.167,
          height = 159.667,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "sundae",
            ["quad"] = "1"
          }
        },
        {
          id = 42,
          name = "Helado",
          type = "none",
          shape = "rectangle",
          x = 833.667,
          y = 362.667,
          width = 316.667,
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
          id = 27,
          name = "Chicle",
          type = "static",
          shape = "polyline",
          x = 191.948,
          y = 658,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 46.2535, y = 0 },
            { x = 161.587, y = 0.3333 }
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
          id = 28,
          name = "Chicle",
          type = "static",
          shape = "polyline",
          x = 569.974,
          y = 717,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 56.2795, y = 0 },
            { x = 196.613, y = 0.3333 }
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
          id = 29,
          name = "Chicle",
          type = "static",
          shape = "polyline",
          x = 570.375,
          y = 540,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 55.8785, y = 0 },
            { x = 195.212, y = 0.3333 }
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
          id = 30,
          name = "Chicle",
          type = "static",
          shape = "polyline",
          x = 362.108,
          y = 381.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 56.1459, y = 0 },
            { x = 196.146, y = 0.3333 }
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
          id = 37,
          name = "Chicle",
          type = "static",
          shape = "polyline",
          x = 987,
          y = 735,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 46.2535, y = 0 },
            { x = 161.587, y = 0.3333 }
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
          x = 797.625,
          y = 655,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 36.6285, y = 0 },
            { x = 127.962, y = 0.3333 }
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
          id = 44,
          name = "Baston",
          type = "static",
          shape = "rectangle",
          x = 800.091,
          y = 495.562,
          width = 191.895,
          height = 47.2827,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["direccion_x"] = 1,
            ["img"] = "objetos",
            ["quad"] = "dulce_parte2"
          }
        },
        {
          id = 45,
          name = "Baston",
          type = "static",
          shape = "rectangle",
          x = 992.013,
          y = 497.098,
          width = 191.897,
          height = 45.8054,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["direccion_x"] = -1,
            ["img"] = "objetos",
            ["quad"] = "dulce_parte2"
          }
        },
        {
          id = 46,
          name = "Baston",
          type = "static",
          shape = "rectangle",
          x = 1126.21,
          y = 453.312,
          width = 57.613,
          height = 44.3177,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["direccion_x"] = -1,
            ["img"] = "objetos",
            ["quad"] = "dulce_parte1"
          }
        },
        {
          id = 47,
          name = "Baston",
          type = "static",
          shape = "rectangle",
          x = 800.472,
          y = 451.096,
          width = 57.613,
          height = 44.3177,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["direccion_x"] = 1,
            ["img"] = "objetos",
            ["quad"] = "dulce_parte1"
          }
        },
        {
          id = 48,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 24,
          y = 670,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 9.83411, y = -24.6818 },
            { x = 207.241, y = -24.6818 },
            { x = 216.208, y = -0.188804 }
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
          id = 49,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 408,
          y = 734,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 9.97055, y = -24.6818 },
            { x = 210.117, y = -24.6818 },
            { x = 219.208, y = -0.188804 }
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
          id = 50,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 411,
          y = 560,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 9.97056, y = -24.6818 },
            { x = 210.117, y = -24.6818 },
            { x = 219.208, y = -0.188804 }
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
          id = 51,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 16,
          y = 518.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 16.0352, y = -38.0151 },
            { x = 337.921, y = -38.0151 },
            { x = 352.541, y = -0.290798 }
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
          id = 52,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 397.333,
          y = 229.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 17.8546, y = -47.3484 },
            { x = 376.262, y = -47.3484 },
            { x = 392.541, y = -0.362194 }
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
      id = 12,
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
          id = 54,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 167.333,
          y = 794.667,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_portal"] = true,
            ["clase"] = "puerta",
            ["id"] = 1,
            ["img"] = "objetos",
            ["nivel"] = 1,
            ["quad"] = "puerta",
            ["sensor"] = true
          }
        },
        {
          id = 55,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 550.333,
          y = 795.667,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_portal"] = true,
            ["clase"] = "puerta",
            ["id"] = 2,
            ["img"] = "objetos",
            ["nivel"] = 1,
            ["quad"] = "puerta",
            ["sensor"] = true
          }
        },
        {
          id = 56,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 975.833,
          y = 797.333,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_portal"] = true,
            ["clase"] = "puerta",
            ["id"] = 3,
            ["img"] = "objetos",
            ["nivel"] = 1,
            ["quad"] = "puerta",
            ["sensor"] = true
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 6,
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
          id = 33,
          name = "Caja",
          type = "dynamic",
          shape = "rectangle",
          x = 37,
          y = 822.667,
          width = 70,
          height = 75,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_movible"] = true,
            ["Es_movibleFacil"] = false,
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
          id = 35,
          name = "Arma",
          type = "static",
          shape = "rectangle",
          x = 47,
          y = 603.5,
          width = 55.5,
          height = 33,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_usable"] = true,
            ["clase"] = "arma",
            ["img"] = "armas",
            ["quad"] = "2",
            ["sensor"] = true
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 13,
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
          id = 57,
          name = "Vida",
          type = "static",
          shape = "rectangle",
          x = 296.667,
          y = 833.333,
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
          id = 64,
          name = "Municion",
          type = "static",
          shape = "rectangle",
          x = 424,
          y = 681,
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
          id = 65,
          name = "Municion",
          type = "static",
          shape = "rectangle",
          x = 429.333,
          y = 502.333,
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
        }
      }
    },
    {
      type = "objectgroup",
      id = 7,
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
          id = 32,
          name = "Npc",
          type = "dynamic",
          shape = "rectangle",
          x = 429.667,
          y = 293,
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
        },
        {
          id = 59,
          name = "Npc",
          type = "dynamic",
          shape = "rectangle",
          x = 852,
          y = 572,
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
            ["h"] = 0.2,
            ["hp"] = 8,
            ["img"] = "jugador",
            ["quad"] = "2",
            ["s"] = 0,
            ["tag"] = "humano"
          }
        },
        {
          id = 60,
          name = "Npc",
          type = "dynamic",
          shape = "rectangle",
          x = 850,
          y = 814,
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
            ["h"] = 0.3,
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
      id = 10,
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
      id = 11,
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
