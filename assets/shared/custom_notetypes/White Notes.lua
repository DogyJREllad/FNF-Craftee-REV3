function onCreate()
	for i = getProperty('unspawnNotes.length')-1, 0, -1 do
        if getPropertyFromGroup('unspawnNotes', i,'noteType') == 'White Notes' then
            setPropertyFromGroup('unspawnNotes', i,'texture','White_Notes')
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '1');
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0');
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);  
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') and not botplay then
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true);
			end
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);
			setPropertyFromGroup('unspawnNotes', i, 'rgbShader.enabled', false)
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashData.useGlobalShader', false);
		end
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'White Notes' then
		characterPlayAnim('boyfriend', 'hey', true);
		setProperty('boyfriend.specialAnim', true);
		playSound('undertale-heal', 1, 'heal');
		
		characterPlayAnim('gf', 'cheer', true);
		setProperty('gf.specialAnim', true);
		
		--runTimer(gfTimer, 1, 1)
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == gfTimer then
		characterPlayAnim('gf', 'danceRight', true);
	end
end
