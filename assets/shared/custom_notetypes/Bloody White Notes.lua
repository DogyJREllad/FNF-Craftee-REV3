function onCreate()
	for i = getProperty('unspawnNotes.length')-1, 0, -1 do
        if getPropertyFromGroup('unspawnNotes', i,'noteType') == 'Bloody White Notes' then
            setPropertyFromGroup('unspawnNotes', i,'texture','Bloody_White_Notes')
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0');
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '1');
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true);   
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true);
			end
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);
			setPropertyFromGroup('unspawnNotes', i, 'rgbShader.enabled', false)
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashData.useGlobalShader', false);
		end
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == gfTimer then
		characterPlayAnim('gf', 'danceRight', true);
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == 'Bloody White Notes' then
		characterPlayAnim('boyfriend', 'hurt', true);
		setProperty('boyfriend.specialAnim', true);
		playSound('undertale-damage-taken', 1, 'hurt');
		
		characterPlayAnim('gf', 'scared', true);
		setProperty('gf.specialAnim', true);
		
		runTimer(gfTimer, 1, 1)
	end
end
