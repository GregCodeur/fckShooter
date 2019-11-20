io.stdout:setvbuf('no')
love.graphics.setDefaultFilter("nearest")
local largeur
local hauteur

local heros = {}
local listeSprites = {}

--Usine a sprite
function CreerSprite(pNomImage,pX,pY)
  
  local sprite = {}
  sprite.image = love.graphics.newImage("images/"..pNomImage..".png")
  sprite.x = pX
  sprite.y = pY
  sprite.origineX = sprite.image:getWidth()/2
  sprite.origineY = sprite.image:getHeight()/2
  
  table.insert(listeSprites,sprite)
  
  return sprite
  
end

function love.load()
  
  love.window.setMode(1024,768)
  love.window.setTitle("Fucking shooter")
  
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
  heros = CreerSprite("heros",largeur/2,hauteur/2)
  heros.y = hauteur - heros.origineY*8
end

function love.update(dt)
  
  
end

function love.draw()
  love.graphics.line(largeur/2,0,largeur/2,hauteur)
  love.graphics.line(0,hauteur/2,largeur,hauteur/2)
  
  --Afficher les sprites
  local n
  for n=1,#listeSprites do
    local s = listeSprites[n]
    love.graphics.draw(s.image,s.x,s.y,0,1,1,s.origineX,s.origineY)
    --love.graphics.draw(s.image,s.x,s.y)
    --print("x : "..s.origineX)
  end
end

function love.keypressed(key)
  
end
