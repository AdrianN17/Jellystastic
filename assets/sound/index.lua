local index = {}

index.disparo = {}
index.disparo[1] = love.audio.newSource("assets/sound/armas/pistol.wav", "static")
index.disparo[2] = love.audio.newSource("assets/sound/armas/desertEagle.wav", "static")
index.disparo[3] = love.audio.newSource("assets/sound/armas/uzi.wav", "static")
index.disparo[4] = love.audio.newSource("assets/sound/armas/fusil.wav", "static")
index.disparo[5] = love.audio.newSource("assets/sound/armas/escopeta.wav", "static")
index.disparo[6] = love.audio.newSource("assets/sound/armas/grenadeLauncher.wav", "static")

index.recarga = {}
index.recarga[1] = love.audio.newSource("assets/sound/armas/recargaPistola.mp3", "static")
index.recarga[2] = index.recarga[1]
index.recarga[3] = love.audio.newSource("assets/sound/armas/recargaArma.mp3", "static")
index.recarga[4] = index.recarga[3]
index.recarga[5] = love.audio.newSource("assets/sound/armas/recargaEscopeta.wav", "static")
index.recarga[6] = love.audio.newSource("assets/sound/armas/recargaGrenadeLauncher.wav", "static")

index.noArma = {}
index.noArma[1] = love.audio.newSource("assets/sound/armas/sinBalas.wav", "static")
index.noArma[2] = index.noArma[1]
index.noArma[3] = index.noArma[1]
index.noArma[4] = index.noArma[1]
index.noArma[5] = index.noArma[1]
index.noArma[6] = love.audio.newSource("assets/sound/armas/sinBalasGrenadeLauncher.wav", "static")

return index