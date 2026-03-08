function opponentNoteHit(id, isSustainNote)
       health = getProperty('health')
	   local isHoldNote = getPropertyFromGroup('notes', id, 'isSustainNote')
	   allowed = false
	   if not guitarHeroSustains then
			allowed = true
		elseif isHoldNote and guitarHeroSustains then
			allowed = false
		elseif not isHoldNote and guitarHeroSustains then
			allowed = true
		end
		healthGain = getProperty('healthGain')
    if getProperty('health') > 0.075 * healthGain and allowed then
       setProperty('health', health- 0.02 * healthGain);
	end
end
