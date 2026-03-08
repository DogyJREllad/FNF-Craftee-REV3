local crafteeRatingButActuallyDogyRating1 = 0
local crafteeRatingButActuallyDogyRating2 = 0
local crafteeRatingButActuallyDogyRating3 = 0

local author = 'DogyJR'
songNameCraftee = ''

function onCreatePost()
	makeLuaText('songNameText', 'Now Playing:', 2000, 0, 0)
	setProperty('songNameText.antialiasing', true)
	setTextColor('songNameText', to_hex(getProperty('boyfriend.healthColorArray')))
	setObjectCamera('songNameText', 'hud')
	setTextAlignment('songNameText', 'left')
	setTextSize('songNameText', 25)
	addLuaText('songNameText')
	songNameCraftee = songName
	if songName == "Doggies Scrapped Version" then
		author = 'A FUCKING AI(Dogy For The Second Part)'
	elseif songName == "Craft10Music Scrapped Version" then
		author = 'A FUCKING AI'
	elseif songName == "Finale Parasite(Concept)" then
		author = 'Rareblin(Edited By DogyJR)'
	elseif songName == "MasterPiece" then
		author = '@WackyH(OG By Pharrell Williams)'
		
		makeLuaSprite('obj1-2', 'Hypercam_2_watermark', 0, 0)
		setObjectCamera('obj1-2', 'Other')
		scaleObject('obj1-2', 0.5, 0.5)
		--setProperty('obj1-2.alpha', 0.8)
		addLuaSprite('obj1-2', true)
	end
end

function onUpdate()
	crafteeRatingButActuallyDogyRating1 = math.floor(rating * 100)
	crafteeRatingButActuallyDogyRating2 = rating * 100 - crafteeRatingButActuallyDogyRating1
	crafteeRatingButActuallyDogyRating3 = math.floor(crafteeRatingButActuallyDogyRating2 * 1000)
	
	health = getProperty('health') * 100
	
	if crafteeRatingButActuallyDogyRating1 > 0 then
		if crafteeRatingButActuallyDogyRating3 < 100 and crafteeRatingButActuallyDogyRating3 >= 10 then
			setTextString('scoreTxt', 'Score: '..score..' | Misses: '..misses..' | Acurracy: '..crafteeRatingButActuallyDogyRating1..'.0'..crafteeRatingButActuallyDogyRating3..'% ('..ratingFC..') | Health: '..health..'')
		elseif crafteeRatingButActuallyDogyRating3 < 10 then
			setTextString('scoreTxt', 'Score: '..score..' | Misses: '..misses..' | Acurracy: '..crafteeRatingButActuallyDogyRating1..'.00'..crafteeRatingButActuallyDogyRating3..'% ('..ratingFC..') | Health: '..health..'')
		else
			setTextString('scoreTxt', 'Score: '..score..' | Misses: '..misses..' | Acurracy: '..crafteeRatingButActuallyDogyRating1..'.'..crafteeRatingButActuallyDogyRating3..'% ('..ratingFC..') | Health: '..health..'')
		end
	else
		setTextString('scoreTxt', 'Score: '..score..' | Misses: '..misses..' | Acurracy: 100.'..crafteeRatingButActuallyDogyRating3..'% (IDK) | Health: '..health..'')
	end
	
	doTweenColor('timeBar', 'timeBar', 'FFFF00', 0.4, 'linear');
	
	setTextColor("scoreTxt", to_hex(getProperty('dad.healthColorArray')))
	
	setTextColor("timeTxt", to_hex(getProperty('boyfriend.healthColorArray')))
	
	setTextString('songNameText', 'Now Playing: '..songNameCraftee..' By '..author..'.')
	
	if getPropertyFromClass('backend.ClientPrefs', 'data.downScroll') then
	setProperty('songNameText.y', 695)
	end
end

function onUpdatePost()
	setProperty('songName', 'amogus')
end

function to_hex(rgb)
    return string.format('%x', (rgb[1] * 0x10000) + (rgb[2] * 0x100) + rgb[3])
end

function onEvent(name, value1, value2)
	local songNameYAY = (value1)
	if name == "ChangeSongName" then
		songNameCraftee = songNameYAY
	end
end