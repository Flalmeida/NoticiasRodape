local function sinal7()
	local evt = {
	class = 'ncl', 
	type = 'attribution',
	name = 'sinal7',
	value = 7,
	} 
	evt.action = 'start'; event.post(evt) 
	evt.action = 'stop' ; event.post(evt) 
end

local function sinal8()
	local evt = {
	class = 'ncl', 
	type = 'attribution',
	name = 'sinal8',
	value = 8,
	} 
	evt.action = 'start'; event.post(evt) 
	evt.action = 'stop' ; event.post(evt) 
end




local itemIndex = -1

function moveItemIndex(index, forward)
  if index < 0 then
     return index
  end
  
  if forward then
  	 index = index + 1
  	 if index > 60 then
  	    index = 1
  	 end
  else
  	 index = index - 1
  	 if index <= 0 then
  	    index = 60
  	 end
  end
  return index
end 

function autoForward()
	itemIndex = moveItemIndex(itemIndex, true)
	showItem()  
end

function drawApplication()
	  itemIndex = 1
	  title = ''
	  showItem()	  
end

function handler(evt)
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
   		title = ''
	end

	if itemIndex > 58 then
		title = 'agenciabrasil.ebc.com.br'
		sinal7()
	end
	if itemIndex > 59 then
	title = ''
		sinal8()
	end

local cw, ch = canvas:attrSize()
canvas : attrColor(0,0,0,0)
canvas : clear()
canvas:drawRect('fill', 0, 0, cw, ch)
canvas:attrColor(255,255,255,255)
canvas:attrFont('Tiresias', 15, bold)
canvas:drawText(0, 0, title)

canvas:flush()

if cancelTimerFunc then
	 cancelTimerFunc() --cancela o timer anteriormente criado
end
cancelTimerFunc = event.timer(3000, autoForward)
end
event.register(handler)
