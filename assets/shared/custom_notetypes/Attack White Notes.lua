function onCreate()
	for i = getProperty('unspawnNotes.length')-1, 0, -1 do
        if getPropertyFromGroup('unspawnNotes', i,'noteType') == 'Attack White Notes' then
            setPropertyFromGroup('unspawnNotes', i,'texture','Attack_White_Notes')
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '1.99');
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0');
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);   
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false);
			end
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);
			setPropertyFromGroup('unspawnNotes', i, 'rgbShader.enabled', false)
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashData.useGlobalShader', false);
			setPropertyFromGroup('unspawnNotes', i, 'noMissAnimation', true)
		end
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Attack White Notes' then
		characterPlayAnim('boyfriend', 'attack', true);
		setProperty('boyfriend.specialAnim', true);
		playSound('undertale-damage-taken', 1, 'hurt');
		
		characterPlayAnim('dad', 'hurt', true);
		setProperty('dad.specialAnim', true);
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == 'Attack White Notes' then
		characterPlayAnim('boyfriend', 'attack', true);
		setProperty('boyfriend.specialAnim', true);
		playSound('Dodged', 1, 'dodge');
		
		characterPlayAnim('dad', 'dodge', true);
		setProperty('dad.specialAnim', true);
	end
end