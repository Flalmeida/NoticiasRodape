local itemIndex = -1
local contador = 60
local y = 60

function autoForwardy()
  contador = contador - 1 
  
  if contador > 0 then
    y = contador
  end
  if contador <= 0 then
    y = 0
  end 
  if contador < -100 then
    y = (contador + 100)
  end
  if contador < -160 then
    y = 60
    contador = 60
    autoForward()
    y = 60
  end
  showItem()
end

function autoForward()
  itemIndex = moveItemIndex(itemIndex, true)
  showItem()  
end

function moveItemIndex(index, forward)
  if index < 0 then
     return index
  end
  
  if forward then
     index = index + 1
     if index > 9 then
        index = 1
     end
  else
     index = index - 1
     if index <= 0 then
        index = 9
     end
  end
  return index
end

function breakString(str, maxLineSize)
  local t = {}
  local i, fim, countLns = 1, 0, 0
  local largtxt = 65
  if (str == nil) or (str == "") then
    return t
  end 
  str = string.gsub(str, "\n", " ")
  str = string.gsub(str, "\r", " ")
    
  while i < #str do
     countLns = countLns + 1
     if i > #str then
        t[countLns] = str
        i = #str 
     else
        fim = i+largtxt
        if fim > #str then
           fim = #str
        else
          --se o caracter onde a string deve ser quebrada
          --nÃfÆ'Ã,Â£o for um espaÃfÆ'Ã,Â§o, procura o prÃfÆ'Ã,Â³ximo espaÃfÆ'Ã,Â§o
          if string.byte(str, fim) ~= 32 then
             fim = string.find(str, ' ', i+largtxt-3)
             if fim == nil then
                fim = #str
             end
          end
      if fim>i+largtxt then
                fim = string.find(str, ' ', i+largtxt-6)
                if fim == nil then
                  fim = #str
             end
          end
      if fim>i+largtxt then
                fim = string.find(str, ' ', i+largtxt-9)
                if fim == nil then
                  fim = #str
             end
          end
      if fim>i+largtxt then
                fim = string.find(str, ' ', i+largtxt-12)
                if fim == nil then
                  fim = #str
             end
          end
      if fim>i+largtxt then
                fim = string.find(str, ' ', i+largtxt-15)
                if fim == nil then
                  fim = #str
             end
          end
        end
        t[countLns]=string.sub(str, i, fim)
        i=fim+1
     end
  end
  
  return t
end

function drawApplication()
    itemIndex = 1
    showItem()    
end

function handler(evt)
      
    --print("Scale:", canvas:attrSize())
    
    --if (evt.class == "ncl" and evt.type=="attribution") then
        --print("AtribuiÃ§Ã£o:",evt.value)
    --end
    
    --if (evt.class == "ncl"and evt.type=="presentation") then
        --print("AÃ§Ã£o:",evt.action)
    --end
    
    if (evt.class == "ncl" and evt.type=="attribution" and evt.action == "start") == true then
       
        local ok = false
    
        if evt.value == "CURSOR_DOWN" then
           ok = true
           itemIndex = moveItemIndex(itemIndex, true)
        end
        
        if evt.value == "CURSOR_UP" then
           ok = true
           itemIndex = moveItemIndex(itemIndex, false)
        end
    
        if ok then
           showItem()
        end
    
        if evt.value == "ENTER"  then
           itemIndex = 1
           showItem()
           return
        end
    end
    
    if (evt.class == "ncl" and evt.type=="presentation" 
    and evt.action == "start") == false then
       return
    end
    
    drawApplication()
    
end

function showItem()
  local i = itemIndex
  
  if itemIndex < -1 then
    title = ''
  end
  
 if itemIndex > 0 then
      title = '27/07/2016 10:21 - Iranianos e refugiados afegãos transformam discórdia em obras de arte'
  end
  if itemIndex > 1 then
    title = '27/07/2016 10:05 - Marinha faz buscas para encontrar piloto que se acidentou em Saquarema'
  end
  if itemIndex > 2 then
    title = '27/07/2016 09:48 -  Brasília deve retirar 31 antenas de telefonia celular instaladas em escolas'
  end
  if itemIndex > 3 then
      title = '27/07/2016 09:47 - Meirelles e Rodrigo Maia discutem projeto sobre repatriação de recursos'
  end
  if itemIndex > 4 then
    title = '27/07/2016 09:09 - Governo do Rio distribui pulseiras para evitar sumiço de crianças nos Jogos'
  end
  if itemIndex > 5 then
    title = '27/07/2016 08:56 - Total de mortos em atentado na Síria sobe para 44'
  end
    if itemIndex > 6 then
    title = '27/07/2016 08:12 - Jornada Mundial da Juventude leva o papa à Polônia'
  end
  if itemIndex > 7 then
      title = '26/07/2016 20:40 - Hillary Clinton é primeira mulher a concorrer à Presidência dos EUA'
  end
  if itemIndex > 8 then
    title = '27/07/2016 07:46 - ONU pede trégua olímpica durante Jogos do Rio'
  end
  
local cw, ch = canvas:attrSize()
  canvas : attrColor(0,0,0,0)
  canvas : clear()
  canvas:drawRect('fill', 0, 0, cw, ch)
  canvas:attrColor('white')
  canvas:attrFont('Tiresias', 24, bold)
  
  local tw, th = canvas:measureText('a')
  local charsByLine = tonumber(string.format('%d', cw / tw))
  local desc = title
  local desctb = breakString(desc, charsByLine)
  
  for k,ln in pairs(desctb) do
     canvas:drawText(0, y, ln)
     y = y + 26
  end
  
  canvas:flush()

  if cancelTimerFuncy then
    cancelTimerFuncy() 
  end
  
  cancelTimerFuncy = event.timer(5, autoForwardy)
  
end

event.register(handler)
