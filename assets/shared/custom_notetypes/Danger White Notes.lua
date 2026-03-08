function onCreate()
	for i = getProperty('unspawnNotes.length')-1, 0, -1 do
        if getPropertyFromGroup('unspawnNotes', i,'noteType') == 'Danger White Notes' then
            setPropertyFromGroup('unspawnNotes', i,'texture','Danger_White_Notes')
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0');
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '1.99');
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);   
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false);
			end
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);
			setPropertyFromGroup('unspawnNotes', i, 'rgbShader.enabled', false)
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashData.useGlobalShader', false);
		end
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Danger White Notes' then
		characterPlayAnim('boyfriend', 'dodge', true);
		setProperty('boyfriend.specialAnim', true);
		playSound('Dodged', 1, 'dodge');
		
		characterPlayAnim('gf', 'scared', true);
		setProperty('gf.specialAnim', true);
		
		runTimer(gfTimer, 1, 1)
		
		characterPlayAnim('dad', 'attack', true);
		setProperty('dad.specialAnim', true);
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == gfTimer then
		characterPlayAnim('gf', 'danceRight', true);
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == 'Danger White Notes' then
		characterPlayAnim('boyfriend', 'hurt', true);
		setProperty('boyfriend.specialAnim', true);
		playSound('undertale-damage-taken', 1, 'hurt');
		
		characterPlayAnim('gf', 'scared', true);
		setProperty('gf.specialAnim', true);
		
		runTimer(gfTimer, 1, 1)
		
		characterPlayAnim('dad', 'attack', true);
		setProperty('dad.specialAnim', true);
	end
end