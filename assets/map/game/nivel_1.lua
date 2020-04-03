return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 58,
  height = 30,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 15,
  nextobjectid = 195,
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
          x = 0.547286,
          y = 798.94,
          width = 1060,
          height = 162,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "texturaFisica",
            ["grupo"] = "suelo",
            ["img"] = "1",
            ["userdataNombre"] = "piso",
            ["uv"] = 2
          }
        },
        {
          id = 2,
          name = "Gelatina",
          type = "static",
          shape = "rectangle",
          x = 1060.54,
          y = 595.94,
          width = 773.333,
          height = 365.333,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_tierra"] = true,
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
          x = 1,
          y = 508.15,
          width = 236,
          height = 291.847,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "1"
          }
        },
        {
          id = 6,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 237,
          y = 338.809,
          width = 236,
          height = 461.191,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "2"
          }
        },
        {
          id = 7,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 473,
          y = 507.55,
          width = 236,
          height = 291.847,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "5"
          }
        },
        {
          id = 12,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 826,
          y = 343.405,
          width = 236,
          height = 457.191,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "2"
          }
        },
        {
          id = 14,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 964.667,
          y = 216.304,
          width = 97.3333,
          height = 127,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "2"
          }
        },
        {
          id = 15,
          name = "Casa",
          type = "none",
          shape = "polygon",
          x = 825.999,
          y = 343.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0.00466957, y = 0.0703125 },
            { x = 138.614, y = -127.378 },
            { x = 138.667, y = 0.0703125 }
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
          id = 17,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 1061.33,
          y = 352.5,
          width = 288,
          height = 244,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "3"
          }
        },
        {
          id = 18,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 1350,
          y = 258.667,
          width = 488.667,
          height = 337.667,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "4"
          }
        },
        {
          id = 19,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 1661.33,
          y = 131.167,
          width = 96,
          height = 127,
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
          shape = "polygon",
          x = 1521.33,
          y = 258.197,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0.00471447, y = 0.0703125 },
            { x = 139.948, y = -127.378 },
            { x = 140.001, y = 0.0703125 }
          },
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["heightArreglo"] = 1.5,
            ["img"] = "4",
            ["tipoCalculoDimensiones"] = "triangular",
            ["widthArreglo"] = 1.5
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 14,
      name = "Capa de Objetos 13",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["tabla"] = "meteorito"
      },
      objects = {
        {
          id = 193,
          name = "MeteoritoCreador",
          type = "manager",
          shape = "point",
          x = 781.333,
          y = 471.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "meteoritoCreador",
            ["direccion"] = 1,
            ["img"] = "meteorito",
            ["quad"] = "1",
            ["quadEstela"] = "estela_1",
            ["sensor"] = true,
            ["userdataNombre"] = "meteorito"
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
        ["tabla"] = "puertas"
      },
      objects = {
        {
          id = 29,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 83.3333,
          y = 699.17,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "puerta",
            ["id"] = 1,
            ["img"] = "objetos",
            ["nivel"] = 1,
            ["quad"] = "puerta",
            ["sensor"] = true,
            ["userdataNombre"] = "puerta"
          }
        },
        {
          id = 30,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 315.333,
          y = 699.17,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "puerta",
            ["id"] = 2,
            ["img"] = "objetos",
            ["nivel"] = 1,
            ["quad"] = "puerta",
            ["sensor"] = true,
            ["userdataNombre"] = "puerta"
          }
        },
        {
          id = 31,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 565.333,
          y = 700.17,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "puerta",
            ["id"] = 3,
            ["img"] = "objetos",
            ["nivel"] = 1,
            ["quad"] = "puerta",
            ["sensor"] = true,
            ["userdataNombre"] = "puerta"
          }
        },
        {
          id = 32,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 904.333,
          y = 700.17,
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
          id = 33,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 1176.33,
          y = 497.17,
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
          id = 34,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 1541.33,
          y = 496.17,
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
          id = 35,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 1683.33,
          y = 155.167,
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
          id = 36,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 985.333,
          y = 243.167,
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
        ["tabla"] = "objetosEscenario"
      },
      objects = {
        {
          id = 155,
          name = "Arbol",
          type = "none",
          shape = "rectangle",
          x = 712.5,
          y = 668.25,
          width = 111,
          height = 132,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "arbol",
            ["quad"] = "1"
          }
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
        ["tabla"] = "Ventanas"
      },
      objects = {
        {
          id = 45,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 15.3333,
          y = 612,
          width = 60,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "ventanas",
            ["quad"] = "1"
          }
        },
        {
          id = 47,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 156.667,
          y = 612,
          width = 60,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "ventanas",
            ["quad"] = "2"
          }
        },
        {
          id = 48,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 267.333,
          y = 594.67,
          width = 60,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "ventanas",
            ["quad"] = "4"
          }
        },
        {
          id = 49,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 371.333,
          y = 438,
          width = 60,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "ventanas",
            ["quad"] = "3"
          }
        },
        {
          id = 50,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 500.667,
          y = 598.67,
          width = 60,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "ventanas",
            ["quad"] = "1"
          }
        },
        {
          id = 51,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 627.333,
          y = 624.67,
          width = 60,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "ventanas",
            ["quad"] = "2"
          }
        },
        {
          id = 52,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 852.667,
          y = 598,
          width = 60,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "ventanas",
            ["quad"] = "3"
          }
        },
        {
          id = 53,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 974,
          y = 442,
          width = 60,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "ventanas",
            ["quad"] = "1"
          }
        },
        {
          id = 54,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 852.667,
          y = 439.333,
          width = 60,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "ventanas",
            ["quad"] = "4"
          }
        },
        {
          id = 55,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 1070.67,
          y = 496,
          width = 60,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "ventanas",
            ["quad"] = "2"
          }
        },
        {
          id = 56,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 1265.33,
          y = 413.333,
          width = 60,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "ventanas",
            ["quad"] = "3"
          }
        },
        {
          id = 57,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 1408.67,
          y = 488.67,
          width = 60,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "ventanas",
            ["quad"] = "3"
          }
        },
        {
          id = 58,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 1708,
          y = 491.33,
          width = 60,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "ventanas",
            ["quad"] = "1"
          }
        },
        {
          id = 59,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 1407.33,
          y = 352,
          width = 60,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "ventanas",
            ["quad"] = "4"
          }
        },
        {
          id = 60,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 1709.33,
          y = 352.667,
          width = 60,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "ventanas",
            ["quad"] = "2"
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
        ["tabla"] = "adornosMapa"
      },
      objects = {
        {
          id = 61,
          name = "Dulce",
          type = "none",
          shape = "rectangle",
          x = 97,
          y = 561,
          width = 38,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "dulce_ladrillo_1"
          }
        },
        {
          id = 62,
          name = "Dulce",
          type = "none",
          shape = "rectangle",
          x = 21,
          y = 701.5,
          width = 38,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "dulce_ladrillo_1"
          }
        },
        {
          id = 63,
          name = "Dulce",
          type = "none",
          shape = "rectangle",
          x = 252,
          y = 694.5,
          width = 38,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "dulce_ladrillo_1"
          }
        },
        {
          id = 64,
          name = "Dulce",
          type = "none",
          shape = "rectangle",
          x = 276,
          y = 459.5,
          width = 38,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "dulce_ladrillo_1"
          }
        },
        {
          id = 65,
          name = "Dulce",
          type = "none",
          shape = "rectangle",
          x = 379,
          y = 597.5,
          width = 38,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "dulce_ladrillo_1"
          }
        },
        {
          id = 66,
          name = "Dulce",
          type = "none",
          shape = "rectangle",
          x = 508,
          y = 706.5,
          width = 38,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "dulce_ladrillo_1"
          }
        },
        {
          id = 67,
          name = "Dulce",
          type = "none",
          shape = "rectangle",
          x = 602,
          y = 566.5,
          width = 38,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "dulce_ladrillo_1"
          }
        },
        {
          id = 68,
          name = "Dulce",
          type = "none",
          shape = "rectangle",
          x = 990,
          y = 661.5,
          width = 38,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "dulce_ladrillo_1"
          }
        },
        {
          id = 69,
          name = "Dulce",
          type = "none",
          shape = "rectangle",
          x = 942,
          y = 529.5,
          width = 38,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "dulce_ladrillo_1"
          }
        },
        {
          id = 70,
          name = "Dulce",
          type = "none",
          shape = "rectangle",
          x = 907,
          y = 292.5,
          width = 38,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "dulce_ladrillo_1"
          }
        },
        {
          id = 71,
          name = "Dulce",
          type = "none",
          shape = "rectangle",
          x = 1185,
          y = 394.5,
          width = 38,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "dulce_ladrillo_1"
          }
        },
        {
          id = 72,
          name = "Dulce",
          type = "none",
          shape = "rectangle",
          x = 1085,
          y = 408.5,
          width = 38,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "dulce_ladrillo_1"
          }
        },
        {
          id = 73,
          name = "Dulce",
          type = "none",
          shape = "rectangle",
          x = 1299,
          y = 514.5,
          width = 38,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "dulce_ladrillo_1"
          }
        },
        {
          id = 74,
          name = "Dulce",
          type = "none",
          shape = "rectangle",
          x = 1548,
          y = 403.5,
          width = 38,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "dulce_ladrillo_1"
          }
        },
        {
          id = 75,
          name = "Dulce",
          type = "none",
          shape = "rectangle",
          x = 1755,
          y = 429.5,
          width = 38,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "dulce_ladrillo_1"
          }
        },
        {
          id = 76,
          name = "Dulce",
          type = "none",
          shape = "rectangle",
          x = 1643,
          y = 534.5,
          width = 38,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "dulce_ladrillo_1"
          }
        },
        {
          id = 77,
          name = "Dulce",
          type = "none",
          shape = "rectangle",
          x = 1457,
          y = 289.5,
          width = 38,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "dulce_ladrillo_1"
          }
        },
        {
          id = 78,
          name = "Dulce",
          type = "none",
          shape = "rectangle",
          x = 1602,
          y = 202.5,
          width = 38,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "dulce_ladrillo_1"
          }
        },
        {
          id = 84,
          name = "Reflejo",
          type = "none",
          shape = "rectangle",
          x = 262.334,
          y = 879.5,
          width = 66,
          height = 49,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "luz"
          }
        },
        {
          id = 85,
          name = "Reflejo",
          type = "none",
          shape = "rectangle",
          x = 791,
          y = 871.5,
          width = 66,
          height = 49,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "luz"
          }
        },
        {
          id = 86,
          name = "Reflejo",
          type = "none",
          shape = "rectangle",
          x = 1167,
          y = 664.83,
          width = 66,
          height = 49,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "luz"
          }
        },
        {
          id = 87,
          name = "Reflejo",
          type = "none",
          shape = "rectangle",
          x = 1447,
          y = 827.5,
          width = 66,
          height = 49,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "luz"
          }
        },
        {
          id = 88,
          name = "Reflejo",
          type = "none",
          shape = "rectangle",
          x = 1703,
          y = 660.83,
          width = 66,
          height = 49,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "adornos",
            ["quad"] = "luz"
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
        ["tabla"] = "helados"
      },
      objects = {
        {
          id = 89,
          name = "Helado",
          type = "none",
          shape = "rectangle",
          x = 2.66667,
          y = 390.333,
          width = 234.667,
          height = 132.667,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "sundae",
            ["quad"] = "1"
          }
        },
        {
          id = 90,
          name = "Helado",
          type = "none",
          shape = "rectangle",
          x = 237,
          y = 220.333,
          width = 234.667,
          height = 132.667,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "sundae",
            ["quad"] = "2"
          }
        },
        {
          id = 91,
          name = "Helado",
          type = "none",
          shape = "rectangle",
          x = 477.333,
          y = 403.667,
          width = 234.667,
          height = 132.667,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "sundae",
            ["quad"] = "3"
          }
        },
        {
          id = 92,
          name = "Helado",
          type = "none",
          shape = "rectangle",
          x = 1062.67,
          y = 213.666,
          width = 288,
          height = 140.667,
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
          id = 147,
          name = "Baston",
          type = "static",
          shape = "rectangle",
          x = 467.082,
          y = 521.24,
          width = 129.9,
          height = 32.0071,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["direccion_x"] = 1,
            ["img"] = "objetos",
            ["quad"] = "dulce_parte2",
            ["userdataNombre"] = "piso"
          }
        },
        {
          id = 148,
          name = "Baston",
          type = "static",
          shape = "rectangle",
          x = 596.009,
          y = 522.73,
          width = 129.901,
          height = 31.0071,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["direccion_x"] = -1,
            ["img"] = "objetos",
            ["quad"] = "dulce_parte2",
            ["userdataNombre"] = "piso"
          }
        },
        {
          id = 150,
          name = "Baston",
          type = "static",
          shape = "rectangle",
          x = 466.682,
          y = 480.59,
          width = 42.5909,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["direccion_x"] = 1,
            ["img"] = "objetos",
            ["quad"] = "dulce_parte1",
            ["userdataNombre"] = "piso"
          }
        },
        {
          id = 152,
          name = "Baston",
          type = "static",
          shape = "rectangle",
          x = 683.038,
          y = 482.33,
          width = 42.5909,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["direccion_x"] = -1,
            ["img"] = "objetos",
            ["quad"] = "dulce_parte1",
            ["userdataNombre"] = "piso"
          }
        },
        {
          id = 153,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = -7.333,
          y = 531,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 11.608, y = -32.6818 },
            { x = 244.624, y = -32.6818 },
            { x = 255.208, y = -0.25 }
          },
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide",
            ["userdataNombre"] = "piso"
          }
        },
        {
          id = 156,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 225.333,
          y = 362,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 11.608, y = -32.6818 },
            { x = 244.624, y = -32.6818 },
            { x = 255.208, y = -0.25 }
          },
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide",
            ["userdataNombre"] = "piso"
          }
        },
        {
          id = 157,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 811.333,
          y = 368,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 12.2751, y = -26.0151 },
            { x = 258.682, y = -26.0151 },
            { x = 269.875, y = -0.199003 }
          },
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide",
            ["userdataNombre"] = "piso"
          }
        },
        {
          id = 158,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 1048,
          y = 372.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 14.4584, y = -24.6818 },
            { x = 304.692, y = -24.6818 },
            { x = 317.875, y = -0.188804 }
          },
          properties = {
            ["Es_tierra"] = true,
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide",
            ["userdataNombre"] = "piso"
          }
        },
        {
          id = 160,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 1512.58,
          y = 275.727,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 12.5177, y = -21.3485 },
            { x = 263.795, y = -21.3485 },
            { x = 275.208, y = -0.163305 }
          },
          properties = {
            ["Es_tierra"] = true,
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
      id = 13,
      name = "Capa de Objetos 12",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["tabla"] = "items"
      },
      objects = {}
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
        ["tabla"] = "enemigos"
      },
      objects = {
        {
          id = 175,
          name = "Baba",
          type = "dynamic",
          shape = "rectangle",
          x = 1400.65,
          y = 503.647,
          width = 70,
          height = 90,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "enemigo1",
            ["grupo"] = "infectado",
            ["hp"] = 15,
            ["img"] = "baba",
            ["limiteVision"] = 350,
            ["userdataNombre"] = "enemigo",
            ["velocidad"] = 100
          }
        },
        {
          id = 176,
          name = "Baba",
          type = "dynamic",
          shape = "rectangle",
          x = 1540.65,
          y = 505.31,
          width = 70,
          height = 90,
          rotation = 0,
          visible = true,
          properties = {
            ["grupo"] = "infectado",
            ["hp"] = 15,
            ["userdataNombre"] = "enemigo"
          }
        },
        {
          id = 177,
          name = "Baba",
          type = "dynamic",
          shape = "rectangle",
          x = 1745.98,
          y = 503.98,
          width = 70,
          height = 90,
          rotation = 0,
          visible = true,
          properties = {
            ["grupo"] = "infectado",
            ["hp"] = 15,
            ["userdataNombre"] = "enemigo"
          }
        },
        {
          id = 187,
          name = "Zombie",
          type = "dynamic",
          shape = "rectangle",
          x = 1271.67,
          y = 492.333,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "enemigo2",
            ["grupo"] = "infectado",
            ["hp"] = 20,
            ["img"] = "jugador",
            ["limiteVision"] = 100,
            ["userdataNombre"] = "enemigo",
            ["velocidad"] = 130
          }
        },
        {
          id = 189,
          name = "Soldado",
          type = "dynamic",
          shape = "rectangle",
          x = 957,
          y = 717,
          width = 50,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["arma"] = 1,
            ["clase"] = "enemigo3",
            ["grupo"] = "humano_enemigo",
            ["hp"] = 12,
            ["img"] = "jugador",
            ["imgAccesorio"] = "accesorios",
            ["limiteVision"] = 1000,
            ["quadImgAccesorio"] = "1",
            ["userdataNombre"] = "enemigo",
            ["velocidad"] = 80
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
        ["tabla"] = "jugadores"
      },
      objects = {
        {
          id = 79,
          name = "Player",
          type = "dynamic",
          shape = "rectangle",
          x = 16,
          y = 720,
          width = 50,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["armaIndex"] = 1,
            ["clase"] = "player",
            ["grupo"] = "humano",
            ["hp"] = 25,
            ["img"] = "jugador",
            ["imgAccesorio"] = "accesorios",
            ["salto"] = 30,
            ["userdataNombre"] = "player",
            ["velocidad"] = 175
          }
        }
      }
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
