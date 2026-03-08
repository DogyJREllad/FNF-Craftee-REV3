function onCreate()
	removeLuaSprite('obj1', false)

	makeLuaSprite('bg', 'TheDamnBackground', -434, -225)
	setObjectOrder('bg', 0)
	scaleObject('bg', 1.75, 1.75)
	addLuaSprite('bg', true)
	
	makeLuaSprite('bgi', 'InvertBG', -434, -225)
	setObjectOrder('bgi', 0)
	scaleObject('bgi', 1.75, 1.75)
	--addLuaSprite('bgi', true)
	removeLuaSprite('bgi', false)
	
	debugPrint(getProperty('dad.curCharacter'));
end

function onEvent(name, value1, value2, strumTime)
	if name == 'TTSwitch' then
		if value1 == 'true' then
		triggerEvent('Flash')
		setObjectOrder('bgi', 0)
		addLuaSprite('bgi', true)
		removeLuaSprite('bg', false)
		
		if getProperty('dad.curCharacter') == 'Craftee' then
			triggerEvent('Change Character', 'Dad', 'Invert')
		end
		elseif value1 == 'false' then
		triggerEvent('Flash')
		setObjectOrder('bg', 0)
		addLuaSprite('bg', true)
		removeLuaSprite('bgi', false)
		
		if getProperty('dad.curCharacter') == 'Invert' then
			triggerEvent('Change Character', 'Dad', 'Craftee')
		end
		
		setProperty('health', getProperty('health'))
		end
	end
end