return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 70,
  height = 50,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 12,
  nextobjectid = 181,
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
        ["tabla"] = "objetosMapa"
      },
      objects = {
        {
          id = 1,
          name = "Gelatina",
          type = "static",
          shape = "rectangle",
          x = 0.547286,
          y = 1342.94,
          width = 1060,
          height = 257.333,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "texturaFisica",
            ["grupo"] = "suelo",
            ["img"] = "1",
            ["uv"] = 2
          }
        },
        {
          id = 2,
          name = "Gelatina",
          type = "static",
          shape = "rectangle",
          x = 1060.54,
          y = 1139.94,
          width = 773.333,
          height = 461.333,
          rotation = 0,
          visible = true,
          properties = {
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
      name = "Capa de Objetos 2",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["tabla"] = "objetosMapa"
      },
      objects = {
        {
          id = 3,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 1,
          y = 1052.15,
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
          y = 882.809,
          width = 236,
          height = 461.191,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "1"
          }
        },
        {
          id = 7,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 473,
          y = 1051.55,
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
          id = 12,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 826,
          y = 887.405,
          width = 236,
          height = 457.191,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "1"
          }
        },
        {
          id = 14,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 964.667,
          y = 760.304,
          width = 97.3333,
          height = 127,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "Casa",
          type = "none",
          shape = "polygon",
          x = 825.999,
          y = 887.333,
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
            ["img"] = "1",
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
          y = 896.5,
          width = 288,
          height = 244,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "1"
          }
        },
        {
          id = 18,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 1350,
          y = 802.667,
          width = 488.667,
          height = 337.667,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "1"
          }
        },
        {
          id = 19,
          name = "Casa",
          type = "none",
          shape = "rectangle",
          x = 1661.33,
          y = 675.167,
          width = 96,
          height = 127,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "textura",
            ["grupo"] = "casa",
            ["img"] = "1"
          }
        },
        {
          id = 20,
          name = "Casa",
          type = "none",
          shape = "polygon",
          x = 1521.33,
          y = 802.197,
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
            ["img"] = "1",
            ["tipoCalculoDimensiones"] = "triangular",
            ["widthArreglo"] = 1.5
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
        ["tabla"] = "objetosMapa"
      },
      objects = {
        {
          id = 29,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 83.3333,
          y = 1243.17,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objetoFisico",
            ["id"] = 1,
            ["img"] = "objetos",
            ["quad"] = "puerta",
            ["sensor"] = true
          }
        },
        {
          id = 30,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 315.333,
          y = 1243.17,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objetoFisico",
            ["id"] = 2,
            ["img"] = "objetos",
            ["quad"] = "puerta",
            ["sensor"] = true
          }
        },
        {
          id = 31,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 565.333,
          y = 1244.17,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objetoFisico",
            ["id"] = 3,
            ["img"] = "objetos",
            ["quad"] = "puerta",
            ["sensor"] = true
          }
        },
        {
          id = 32,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 904.333,
          y = 1244.17,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objetoFisico",
            ["id"] = 4,
            ["img"] = "objetos",
            ["quad"] = "puerta",
            ["sensor"] = true
          }
        },
        {
          id = 33,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 1176.33,
          y = 1041.17,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objetoFisico",
            ["id"] = 6,
            ["img"] = "objetos",
            ["quad"] = "puerta",
            ["sensor"] = true
          }
        },
        {
          id = 34,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 1541.33,
          y = 1040.17,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objetoFisico",
            ["id"] = 7,
            ["img"] = "objetos",
            ["quad"] = "puerta",
            ["sensor"] = true
          }
        },
        {
          id = 35,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 1683.33,
          y = 699.167,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objetoFisico",
            ["id"] = 8,
            ["img"] = "objetos",
            ["quad"] = "puerta",
            ["sensor"] = true
          }
        },
        {
          id = 36,
          name = "Puerta",
          type = "static",
          shape = "rectangle",
          x = 985.333,
          y = 787.167,
          width = 60,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objetoFisico",
            ["id"] = 5,
            ["img"] = "objetos",
            ["quad"] = "puerta",
            ["sensor"] = true
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
        ["tabla"] = "objetosMapa"
      },
      objects = {
        {
          id = 147,
          name = "Baston",
          type = "static",
          shape = "rectangle",
          x = 467.082,
          y = 1065.24,
          width = 129.9,
          height = 32.0071,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objetoFisico",
            ["direccion_x"] = 1,
            ["img"] = "objetos",
            ["quad"] = "dulce_parte2"
          }
        },
        {
          id = 148,
          name = "Baston",
          type = "static",
          shape = "rectangle",
          x = 596.009,
          y = 1066.73,
          width = 129.901,
          height = 31.0071,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objetoFisico",
            ["direccion_x"] = -1,
            ["img"] = "objetos",
            ["quad"] = "dulce_parte2"
          }
        },
        {
          id = 150,
          name = "Baston",
          type = "static",
          shape = "rectangle",
          x = 466.682,
          y = 1024.59,
          width = 42.5909,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objetoFisico",
            ["direccion_x"] = 1,
            ["img"] = "objetos",
            ["quad"] = "dulce_parte1"
          }
        },
        {
          id = 152,
          name = "Baston",
          type = "static",
          shape = "rectangle",
          x = 683.038,
          y = 1026.33,
          width = 42.5909,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objetoFisico",
            ["direccion_x"] = -1,
            ["img"] = "objetos",
            ["quad"] = "dulce_parte1"
          }
        },
        {
          id = 153,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = -7.333,
          y = 1075,
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
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide"
          }
        },
        {
          id = 156,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 225.333,
          y = 906,
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
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide"
          }
        },
        {
          id = 157,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 811.333,
          y = 912,
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
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide"
          }
        },
        {
          id = 158,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 1048,
          y = 916.667,
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
            ["clase"] = "objetoFisico",
            ["img"] = "objetos",
            ["quad"] = "chocolate",
            ["tipoCalculoDimensiones"] = "romboide"
          }
        },
        {
          id = 160,
          name = "Chocolate",
          type = "static",
          shape = "polygon",
          x = 1512.58,
          y = 819.727,
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
      name = "Capa de Objetos 5",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["tabla"] = "objetosMapa"
      },
      objects = {
        {
          id = 155,
          name = "Arbol",
          type = "none",
          shape = "rectangle",
          x = 712.5,
          y = 1212.25,
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
        ["tabla"] = "objetosMapa"
      },
      objects = {
        {
          id = 45,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 15.3333,
          y = 1156,
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
          y = 1156,
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
          id = 48,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 267.333,
          y = 1138.67,
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
          id = 49,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 371.333,
          y = 982,
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
          id = 50,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 500.667,
          y = 1142.67,
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
          y = 1168.67,
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
          id = 52,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 852.667,
          y = 1142,
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
          id = 53,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 974,
          y = 986,
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
          y = 983.333,
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
          id = 55,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 1070.67,
          y = 1040,
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
          id = 56,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 1265.33,
          y = 957.333,
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
          id = 57,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 1408.67,
          y = 1032.67,
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
          id = 58,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 1708,
          y = 1035.33,
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
          y = 896,
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
          id = 60,
          name = "Ventana",
          type = "none",
          shape = "rectangle",
          x = 1709.33,
          y = 896.667,
          width = 60,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "ventanas",
            ["quad"] = "1"
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
        ["tabla"] = "objetosMapa"
      },
      objects = {
        {
          id = 61,
          name = "Dulce",
          type = "none",
          shape = "rectangle",
          x = 97,
          y = 1105,
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
          y = 1245.5,
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
          y = 1238.5,
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
          y = 1003.5,
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
          y = 1141.5,
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
          y = 1250.5,
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
          y = 1110.5,
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
          y = 1205.5,
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
          y = 1073.5,
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
          y = 836.5,
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
          y = 938.5,
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
          y = 952.5,
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
          y = 1058.5,
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
          y = 947.5,
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
          y = 973.5,
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
          y = 1078.5,
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
          y = 833.5,
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
          y = 746.5,
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
          x = 257.667,
          y = 1459.5,
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
          y = 1415.5,
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
          y = 1208.83,
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
          y = 1371.5,
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
          y = 1204.83,
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
          x = 652.653,
          y = 1252.98,
          width = 70,
          height = 90,
          rotation = 0,
          visible = true,
          properties = {
            ["hp"] = 12
          }
        },
        {
          id = 176,
          name = "Baba",
          type = "dynamic",
          shape = "rectangle",
          x = 1540.65,
          y = 1049.31,
          width = 70,
          height = 90,
          rotation = 0,
          visible = true,
          properties = {
            ["hp"] = 12
          }
        },
        {
          id = 177,
          name = "Baba",
          type = "dynamic",
          shape = "rectangle",
          x = 1745.98,
          y = 1047.98,
          width = 70,
          height = 90,
          rotation = 0,
          visible = true,
          properties = {
            ["hp"] = 12
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
          y = 1264,
          width = 50,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "player",
            ["hp"] = 25
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
        ["tabla"] = "objetosMapa"
      },
      objects = {
        {
          id = 89,
          name = "Helado",
          type = "none",
          shape = "rectangle",
          x = 2.66667,
          y = 934.333,
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
          y = 764.333,
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
          id = 91,
          name = "Helado",
          type = "none",
          shape = "rectangle",
          x = 477.333,
          y = 947.667,
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
          id = 92,
          name = "Helado",
          type = "none",
          shape = "rectangle",
          x = 1062.67,
          y = 757.666,
          width = 288,
          height = 140.667,
          rotation = 0,
          visible = true,
          properties = {
            ["clase"] = "objeto",
            ["img"] = "sundae",
            ["quad"] = "1"
          }
        }
      }
    }
  }
}
