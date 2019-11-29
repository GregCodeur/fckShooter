io.stdout:setvbuf('no')
love.graphics.setDefaultFilter("nearest")

if arg[#arg] == "-debug" then require("mobdebug").start() end

local largeur
local hauteur

local heros = {}
local listeSprites = {}
local spriteType = {}

--Niveau 25x19
local imgTuiles = {}
local niveau = {}

function ChargementMap()
  local i
  for i=1, 3 do
    imgTuiles[i] = love.graphics.newImage("images/tuile_"..i..".png")
  end
  table.insert(niveau,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
  table.insert(niveau,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
  table.insert(niveau,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
  table.insert(niveau,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
  table.insert(niveau,{0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
  table.insert(niveau,{0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
  table.insert(niveau,{0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
  table.insert(niveau,{0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
  table.insert(niveau,{0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
  table.insert(niveau,{0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
  table.insert(niveau,{0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
  table.insert(niveau,{0,0,0,2,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
  table.insert(niveau,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
  table.insert(niveau,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0})
  table.insert(niveau,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0})
  table.insert(niveau,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0})
  table.insert(niveau,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,0,0,0,0,0,0})
  table.insert(niveau,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
  table.insert(niveau,{3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3})
end

--Usine a sprite
function CreerSprite(pNomImage,pX,pY,pVx, pVy, pType)
  
  local sprite = {}
  sprite.image = love.graphics.newImage("images/"..pNomImage..".png")
  sprite.x = pX
  sprite.y = pY
  sprite.vx = pVx
  sprite.vy = pVy
  sprite.origineX = sprite.image:getWidth()/2
  sprite.origineY = sprite.image:getHeight()/2
  sprite.hauteur = sprite.image:getHeight()
  sprite.largeur = sprite.image:getWidth()
  sprite.isVisible = true
  sprite.type = pType
  
  table.insert(listeSprites,sprite)
  
  
  return sprite
  
end

function love.load()
  
  love.window.setMode(800,600)
  love.window.setTitle("Fucking shooter")
  
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
  spriteType.heros = "heros"
  spriteType.ennemi = "ennemi"
  spriteType.tir = "tir"
  
  heros = CreerSprite("heros",largeur/2,hauteur/2,3,3,spriteType.heros)
  heros.y = hauteur - heros.origineY*8
  
  CreerSprite("enemy1",100,100,0,2,spriteType.ennemi)
  CreerSprite("enemy2",200,200,0,0,spriteType.ennemi)
  
  ChargementMap()
  
end

function love.update(dt)
  GestionTouches()
  GestionSprites()
end

function love.draw()
  
  AfficherMap()
  
  love.graphics.line(largeur/2,0,largeur/2,hauteur)
  love.graphics.line(0,hauteur/2,largeur,hauteur/2)
  
  AfficherSprites()
  
  love.graphics.print("x : "..heros.x,0,0,0)
  love.graphics.print("y : "..heros.y,0,10,0)
  love.graphics.print("nbSPrites : "..#listeSprites,0,20,0)
end

function love.keypressed(key)
  if key == "space" then
    CreerSprite("laser1", heros.x,heros.y,0,5 * -1,spriteType.tir)
    
  end
end

function GestionSprites()
  local listeSpritesToDestroy = {} 
  local n
  for n=1,#listeSprites do
    local s = listeSprites[n]
    if(s.type == spriteType.tir) then
      s.x = s.x + s.vx
      s.y = s.y +s.vy
      if s.y < 0 or s.y > hauteur then 
        table.insert(listeSpritesToDestroy,n)
      end
    end
    if s.type == spriteType.ennemi then
      s.x = s.x + s.vx
      s.y = s.y + s.vy
      if s.y > hauteur then
        table.insert(listeSpritesToDestroy,n)
      end
    end
  end
  
  for n=#listeSpritesToDestroy,1,-1 do
    table.remove(listeSprites,listeSpritesToDestroy[n])
  end
  
end

function GestionTouches()
  local oldY = heros.y
  local oldX = heros.x
  
  if love.keyboard.isDown("up") then
    heros.y = heros.y - heros.vy
    if heros.y < 0 + heros.origineY then
      heros.y = oldY
    end
    
  end
  
  if love.keyboard.isDown("right") then
    heros.x = heros.x + heros.vx
    if heros.x > largeur - heros.origineX then
      heros.x = oldX
    end
  end
  
  if love.keyboard.isDown("down") then
    heros.y = heros.y + heros.vy
    if heros.y > hauteur - heros.origineY then
      heros.y = oldY
    end
  end
  
  if love.keyboard.isDown("left") then
    heros.x = heros.x - heros.vx
    if heros.x < 0 + heros.origineX then
      heros.x = oldX
    end
  end
  
end

function AfficherSprites()
      --Afficher les sprites
  local n
  for n=1,#listeSprites do
    local s = listeSprites[n]
    love.graphics.draw(s.image,s.x,s.y,0,1,1,s.origineX,s.origineY)
  end
end

function AfficherMap()
  
    local nbLignes = #niveau
  local ligne, colonne
  local x,y
  
  x=0
  y=0
  for ligne=1,nbLignes do
    for colonne=1,19 do
      if niveau[ligne][colonne] > 0 then
        local tuile = niveau[ligne][colonne]
        love.graphics.draw(imgTuiles[tuile],tuile,x,y,0,1,1)
      end
      x = x + 32
    end
    x = 0
    y = y +32
  end
end

