function opponentNoteHit(id, isSustainNote)
       health = getProperty('health')
	   local isHoldNote = getPropertyFromGroup('notes', id, 'isSustainNote')
	   guitarHeroSustains = getProperty('guitarHeroSustains')
	   allowed = false
	   if not guitarHeroSustains then
			allowed = true
		elseif isHoldNote and guitarHeroSustains then
			allowed = false
		elseif not isHoldNote and guitarHeroSustains then
			allowed = true
		end
		healthGain = getProperty('healthGain')
    if getProperty('health') > 1 and allowed and difficulty == 2 then
       setProperty('health', health- 0.02 * healthGain);
	end
end
