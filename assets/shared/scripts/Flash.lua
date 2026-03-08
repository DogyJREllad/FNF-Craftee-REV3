alpha = 0

function onCreate()
	makeLuaSprite('flash', 'flash', 0, 0)
	setObjectCamera('flash', 'camHUD')
	setObjectOrder('flash', 10)
	scaleObject('flash', 1000, 1000)
	addLuaSprite('flash', true)
end

function onUpdatePost()
	if alpha > 0 then
		alpha = alpha - 0.05
	end

	setProperty('flash.alpha', alpha)
end

function onEvent(name, value1, value2, strumTime)
	if name == 'Flash' then
		alpha = 1
	end
end