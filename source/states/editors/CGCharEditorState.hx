package states.editors;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import openfl.net.FileReference;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import flash.net.FileFilter;
import haxe.Json;

import objects.CharGalleryEntry;
import states.CharGalleryState;

class CGCharEditorState extends MusicBeatState
{

    var speedBg1:Float = 100;
    var speedBg2:Float = 150;

    var bg1:FlxSprite;
    var bg2:FlxSprite;
    var bg12:FlxSprite;
    var bg22:FlxSprite;

    var tit1:FlxSprite;
    var tit2:FlxSprite;

    var txtOffsets:FlxText;
    var yStepper:FlxUINumericStepper;
    var xStepper:FlxUINumericStepper;
    var scaleStepper:FlxUINumericStepper;
    var imageInputText:FlxUIInputText;
    var antialiasingCheckbox:FlxUICheckBox;
    var isCheckbox:FlxUICheckBox;
    var flipCheckbox:FlxUICheckBox;

    var txtOffsetsTEXT:FlxText;
    var yStepperTEXT:FlxUINumericStepper;
    var xStepperTEXT:FlxUINumericStepper;
    var scaleStepperTEXT:FlxUINumericStepper;
    //var imageInputTextTEXT:FlxUIInputText;
    var antialiasingCheckboxTEXT:FlxUICheckBox;
    //var isCheckboxTEXT:FlxUICheckBox;
    var flipCheckboxTEXT:FlxUICheckBox;

    //var nameInputText:FlxUIInputText;
    var descInputText:FlxUIInputText;
    var txtName:FlxText;
    var txtDesc:FlxText;

    var file:EntryFile;
    var char:CharGalleryEntry;
    var char_TEXT:CharGalleryEntry;

    var _file:FileReference = null;

    override function create()
    {
        file = {
            char: {
                x: 0,
                y: 0,
                scale: 0,
                image: "placeholder",
                antialiasing: false,
                inCharacters: true,
                flipX: false
            },
            char_TEXT: {
                x: 0,
                y: 0,
                scale: 0,
                image: "placeholder_TEXT",
                antialiasing: false,
                inCharacters: true,
                flipX: false
            },
            description: "temp description"
        }

        FlxG.camera.bgColor = FlxColor.BLACK;

        FlxG.watch.add(FlxG.camera, "x", "CameraX");
        FlxG.watch.add(FlxG.camera, "y", "CameraY");
        #if DISCORD_ALLOWED
        // Updating Discord Rich Presence
        //DiscordClient.changePresence("Character Gallery Entry Editor", null);
        #end

        bg1 = new FlxSprite().loadGraphic(Paths.image('CharGallery/bg1'));

        bg1.scale.set(3, 3);
        bg1.scrollFactor.set();

        bg1.x = 1020;
        bg1.screenCenter(Y);
        add(bg1);
        FlxG.watch.add(bg1, "x", "Bg1X");
        FlxG.watch.add(bg1, "y", "Bg1Y");
        FlxG.watch.add(bg1, "scale", "Bg1Scale");

        bg2 = new FlxSprite().loadGraphic(Paths.image('CharGallery/bg2'));

        bg2.scale.set(3, 3);
        bg2.scrollFactor.set();

        bg2.x = bg1.x;
        bg2.y = bg1.y;
        add(bg2);

        FlxG.watch.add(bg2, "x", "Bg2X");
        FlxG.watch.add(bg2, "y", "Bg2Y");
        FlxG.watch.add(bg2, "scale", "Bg2Scale");

        bg12 = new FlxSprite().loadGraphic(Paths.image('CharGallery/bg1'));

        bg12.scale.set(3, 3);
        bg12.scrollFactor.set();

        bg12.x = bg1.x + 2050;
        bg12.screenCenter(Y);
        add(bg12);
        FlxG.watch.add(bg12, "x", "Bg1-2X");
        FlxG.watch.add(bg12, "y", "Bg1-2Y");
        FlxG.watch.add(bg12, "scale", "Bg1-2Scale");

        bg22 = new FlxSprite().loadGraphic(Paths.image('CharGallery/bg2'));

        bg22.scale.set(3, 3);
        bg22.scrollFactor.set();

        bg22.x = bg12.x;
        bg22.y = bg12.y;
        add(bg22);

        FlxG.watch.add(bg22, "x", "Bg2-2X");
        FlxG.watch.add(bg22, "y", "Bg2-2Y");
        FlxG.watch.add(bg22, "scale", "Bg2-2Scale");

        tit1 = new FlxSprite().loadGraphic(Paths.image('CharGallery/title1'));

        tit1.scale.set(3, 3);
        tit1.scrollFactor.set();

        tit1.screenCenter();
        //tit1.x += 10;
        //tit1.y -= 35;
        add(tit1);

        FlxG.watch.add(tit1, "x", "Title1X");
        FlxG.watch.add(tit1, "y", "Title1Y");
        FlxG.watch.add(tit1, "scale", "TitleScale");

        char = new CharGalleryEntry(0, 0, 1, "placeholder", true);
        add(char);

        tit2 = new FlxSprite().loadGraphic(Paths.image('CharGallery/title2'));

        tit2.scale.set(3, 3);
        tit2.scrollFactor.set();

        tit2.x = tit1.x;
        tit2.y = tit1.y;
        add(tit2);

        char_TEXT = new CharGalleryEntry(0, 0, 1, "placeholder_TEXT", true);
        add(char_TEXT);

        FlxG.mouse.visible = true;

        txtOffsets = new FlxText(20, 680, 0, "[0, 0]", 20);
		txtOffsets.setFormat("VCR OSD Mono", 32, 0xFF232323, CENTER);
		txtOffsets.alpha = 0.7;
        txtOffsets.screenCenter(X);
        //txtOffsets.x += 475;
		add(txtOffsets);

        txtOffsetsTEXT = new FlxText(20, 620, 0, "[0, 0]", 20);
		txtOffsetsTEXT.setFormat("VCR OSD Mono", 32, 0xFF232323, CENTER);
		txtOffsetsTEXT.alpha = 0.7;
        txtOffsetsTEXT.screenCenter(X);
		add(txtOffsetsTEXT);

        xStepper = new FlxUINumericStepper(0, 692.5, 10, 0, -9999, 9999, 2);
        xStepper.screenCenter(X);
		xStepper.x -= 145;
        add(xStepper);

        xStepperTEXT = new FlxUINumericStepper(0, 632.5, 10, 0, -9999, 9999, 2);
        xStepperTEXT.screenCenter(X);
		xStepperTEXT.x -= 145;
        add(xStepperTEXT);
        //FlxG.watch.add(xStepper, "x", "XStepperX");
        //FlxG.watch.add(xStepper, "y", "XStepperY");

        yStepper = new FlxUINumericStepper(0, 692.5, 10, 0, -9999, 9999, 2);
        yStepper.screenCenter(X);
		yStepper.x += 145;
        add(yStepper);

        yStepperTEXT = new FlxUINumericStepper(0, 632.5, 10, 0, -9999, 9999, 2);
        yStepperTEXT.screenCenter(X);
		yStepperTEXT.x += 145;
        add(yStepperTEXT);

        //FlxG.watch.add(yStepper, "x", "YStepperX");
        //FlxG.watch.add(yStepper, "y", "YStepperY");

        var loadButton:FlxButton = new FlxButton(0, 660, "Load Entry", function() {
            loadEntry();  
        });
		loadButton.screenCenter(X);
		loadButton.x += 475;
		add(loadButton);
        
        //FlxG.watch.add(loadButton, "x", "loadButtonX");
        //FlxG.watch.add(loadButton, "y", "loadButtonY");

		var saveButton:FlxButton = new FlxButton(0, 660, "Save Entry", function() {
            saveEntry();  
        });
		saveButton.screenCenter(X);
		saveButton.x += 575;
		add(saveButton);

        //FlxG.watch.add(saveButton, "x", "saveButtonX");
        //FlxG.watch.add(saveButton, "y", "saveButtonY");

        scaleStepper = new FlxUINumericStepper(0, 692.5, 0.1, 1, 0.1, 30, 2);
        scaleStepper.screenCenter(X);
        //scaleStepper.screenCenter(Y);
		scaleStepper.x += 400;
        add(scaleStepper);

        scaleStepperTEXT = new FlxUINumericStepper(0, 632.5, 0.1, 1, 0.1, 30, 2);
        scaleStepperTEXT.screenCenter(X);
		scaleStepperTEXT.x += 400;
        add(scaleStepperTEXT);

        //FlxG.watch.add(scaleStepper, "x", "scaleStepperX");
        //FlxG.watch.add(scaleStepper, "y", "scaleStepperY");

        imageInputText = new FlxUIInputText(0, 660, 80, "placeholder", 8);
        imageInputText.screenCenter(X);
		imageInputText.x -= 575;
        add(imageInputText);

        /*imageInputTextTEXT = new FlxUIInputText(0, 630, 80, "placeholder", 8);
        imageInputTextTEXT.screenCenter(X);
		imageInputTextTEXT.x -= 575;
        add(imageInputTextTEXT);*/

        isCheckbox = new FlxUICheckBox(0, 660, null, null, "in characters", 50);
        isCheckbox.screenCenter(X);
		isCheckbox.x -= 375;
        isCheckbox.checked = true;
        add(isCheckbox);

        var setImageButton:FlxButton = new FlxButton(0, 660, "Set Image", function() {
            char.setNewImage(imageInputText.text, isCheckbox.checked);
            char_TEXT.setNewImage(imageInputText.text + "_TEXT", isCheckbox.checked);

            file.char.image = imageInputText.text;
            file.char.inCharacters = isCheckbox.checked;

            file.char_TEXT.image = imageInputText.text + "_TEXT";
            file.char_TEXT.inCharacters = isCheckbox.checked;

            xStepper.value = char.centerX;
            yStepper.value = char.centerY;

            xStepperTEXT.value = char_TEXT.centerX;
            yStepperTEXT.value = char_TEXT.centerY;
        });
		setImageButton.screenCenter(X);
		setImageButton.x -= 485;
		add(setImageButton);

        antialiasingCheckbox = new FlxUICheckBox(0, 690, null, null, "Antialiasing", 50);
        antialiasingCheckbox.screenCenter(X);
		antialiasingCheckbox.x += 325;
        add(antialiasingCheckbox);

        antialiasingCheckboxTEXT = new FlxUICheckBox(0, 630, null, null, "Antialiasing", 50);
        antialiasingCheckboxTEXT.screenCenter(X);
		antialiasingCheckboxTEXT.x += 325;
        add(antialiasingCheckboxTEXT);

        flipCheckbox = new FlxUICheckBox(0, 690, null, null, "Flip X", 50);
        flipCheckbox.screenCenter(X);
		flipCheckbox.x += 250;
        add(flipCheckbox);

        flipCheckboxTEXT = new FlxUICheckBox(0, 630, null, null, "Flip X", 50);
        flipCheckboxTEXT.screenCenter(X);
		flipCheckboxTEXT.x += 250;
        add(flipCheckboxTEXT);

        descInputText = new FlxUIInputText(0, 625, 200, "temp description", 8);
        //descInputText.screenCenter(X);
        //FlxG.watch.add(descInputText, "x", "X");
        //FlxG.watch.add(descInputText, "y", "Y");
        //FlxG.watch.add(descInputText, "width", "Width");
        //FlxG.watch.add(descInputText, "height", "Height");
        //descInputText.height = 400;
        add(descInputText);

        txtName = new FlxText(0, 0, 0, "Char:", 20);
		txtName.setFormat("VCR OSD Mono", 32, 0xFFFFFFFF, CENTER);
		add(txtName);

        txtDesc = new FlxText(0, 50, 250, "very cool text", 3);
		txtDesc.setFormat("VCR OSD Mono", 32, 0xFFFFFFFF, LEFT);
		add(txtDesc);

        xStepper.value = char.centerX;
        yStepper.value = char.centerY;

        xStepperTEXT.value = char_TEXT.centerX;
        yStepperTEXT.value = char_TEXT.centerY;

        super.create();
    }

    override function update(elapsed:Float)
    {
        if(FlxG.keys.justPressed.ESCAPE)
        {
            MusicBeatState.switchState(new MasterEditorMenu());
            FlxG.sound.playMusic(Paths.music('freakyMenu'));
        }

        if(bg1.x > -2050)
        {
            bg1.x -= speedBg1 * elapsed;
        }else
        {
            bg1.x = bg12.x + 2050;
        }

        if(bg2.x > -2050)
        {
            bg2.x -= speedBg2 * elapsed;
        }else
        {
            bg2.x = bg22.x + 2050;
        }

        if(bg12.x > -2050)
        {
            bg12.x -= speedBg1 * elapsed;
        }else
        {
            bg12.x = bg1.x + 2050;
        }

        if(bg22.x > -2050)
        {
            bg22.x -= speedBg2 * elapsed;
        }else
        {
            bg22.x = bg2.x + 2050;
        }

        txtName.text = imageInputText.text.toUpperCase() + ": ";

        txtDesc.text = descInputText.text;

        txtOffsets.text = "[" + xStepper.value + ", " + yStepper.value + "]";
        txtOffsets.screenCenter(X);

        char.x = xStepper.value;
        char.y = yStepper.value;
        char.scale.x = scaleStepper.value;
        char.scale.y = scaleStepper.value;
        char.antialiasing = antialiasingCheckbox.checked;
        char.flipX = flipCheckbox.checked;

        file.char.x = xStepper.value;
        file.char.y = yStepper.value;
        file.char.scale = scaleStepper.value;
        file.char.antialiasing = antialiasingCheckbox.checked;
        file.char.flipX = flipCheckbox.checked;

        txtOffsetsTEXT.text = "[" + xStepperTEXT.value + ", " + yStepperTEXT.value + "]";
        txtOffsetsTEXT.screenCenter(X);

        char_TEXT.x = xStepperTEXT.value;
        char_TEXT.y = yStepperTEXT.value;
        char_TEXT.scale.x = scaleStepperTEXT.value;
        char_TEXT.scale.y = scaleStepperTEXT.value;
        char_TEXT.antialiasing = antialiasingCheckboxTEXT.checked;
        char_TEXT.flipX = flipCheckboxTEXT.checked;

        file.char_TEXT.x = xStepperTEXT.value;
        file.char_TEXT.y = yStepperTEXT.value;
        file.char_TEXT.scale = scaleStepperTEXT.value;
        file.char_TEXT.antialiasing = antialiasingCheckboxTEXT.checked;
        file.char_TEXT.flipX = flipCheckboxTEXT.checked;

        file.description = descInputText.text;

        #if DISCORD_ALLOWED
        DiscordClient.changePresence("Character Gallery Entry Editor", "Editing: " + file.char.image);
        #end
    
        super.update(elapsed);
    }

    function saveEntry() 
    {
        var data:String = haxe.Json.stringify(file, "\t");
		if (data.length > 0)
		{
			var splittedImage:Array<String> = imageInputText.text.trim().split('_');
			var entryName:String = splittedImage[splittedImage.length-1].toLowerCase().replace(' ', '');

			_file = new FileReference();
			_file.addEventListener(#if desktop Event.SELECT #else Event.COMPLETE #end, onSaveComplete);
			_file.addEventListener(Event.CANCEL, onSaveCancel);
			_file.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
			_file.save(data, entryName + ".json");
		}
    }

    function onSaveComplete(_):Void
    {
        _file.removeEventListener(#if desktop Event.SELECT #else Event.COMPLETE #end, onSaveComplete);
        _file.removeEventListener(Event.CANCEL, onSaveCancel);
        _file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
        _file = null;
        FlxG.log.notice("Successfully saved file.");
    }
    
    /**
    * Called when the save file dialog is cancelled.
    */
    function onSaveCancel(_):Void
    {
        _file.removeEventListener(#if desktop Event.SELECT #else Event.COMPLETE #end, onSaveComplete);
        _file.removeEventListener(Event.CANCEL, onSaveCancel);
        _file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
        _file = null;
    }
    
    /**
    * Called if there is an error while saving the gameplay recording.
    */
    function onSaveError(_):Void
    {
        _file.removeEventListener(#if desktop Event.SELECT #else Event.COMPLETE #end, onSaveComplete);
        _file.removeEventListener(Event.CANCEL, onSaveCancel);
        _file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
        _file = null;
        FlxG.log.error("Problem saving file");
    }

    function loadEntry() 
    {
        var jsonFilter:FileFilter = new FileFilter('JSON', 'json');
		_file = new FileReference();
		_file.addEventListener(#if desktop Event.SELECT #else Event.COMPLETE #end, onLoadComplete);
		_file.addEventListener(Event.CANCEL, onLoadCancel);
		_file.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
		_file.browse([jsonFilter]);  
    }

    function onLoadComplete(_):Void
        {
            _file.removeEventListener(#if desktop Event.SELECT #else Event.COMPLETE #end, onLoadComplete);
            _file.removeEventListener(Event.CANCEL, onLoadCancel);
            _file.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
    
            #if sys
            var fullPath:String = null;
            @:privateAccess
            if(_file.__path != null) fullPath = _file.__path;
    
            if(fullPath != null) {
                var rawJson:String = File.getContent(fullPath);
                if(rawJson != null) {
                    var loadedEntry:EntryFile = cast Json.parse(rawJson);
                    //if(loadedEntry.idle_anim != null && loadedEntry.confirm_anim != null) //Make sure it's really a character
                    //{
                        var cutName:String = _file.name.substr(0, _file.name.length - 5);
                        trace("Successfully loaded file: " + cutName);
                        //characterFile = loadedEntry;
                        char.setNewImage(loadedEntry.char.image, loadedEntry.char.inCharacters);
                        xStepper.value = loadedEntry.char.x;
                        yStepper.value = loadedEntry.char.y;
                        scaleStepper.value = loadedEntry.char.scale;
                        antialiasingCheckbox.checked = loadedEntry.char.antialiasing;
                        flipCheckbox.checked = loadedEntry.char.flipX;
                        imageInputText.text = loadedEntry.char.image;
                        isCheckbox.checked = loadedEntry.char.inCharacters;
                        descInputText.text = loadedEntry.description;

                        char_TEXT.setNewImage(loadedEntry.char_TEXT.image, loadedEntry.char_TEXT.inCharacters);
                        xStepperTEXT.value = loadedEntry.char_TEXT.x;
                        yStepperTEXT.value = loadedEntry.char_TEXT.y;
                        scaleStepperTEXT.value = loadedEntry.char_TEXT.scale;
                        antialiasingCheckboxTEXT.checked = loadedEntry.char_TEXT.antialiasing;
                        flipCheckboxTEXT.checked = loadedEntry.char_TEXT.flipX;
                        _file = null;
                        return;
                   // }
                }
            }
            _file = null;
            #else
            trace("File couldn't be loaded! You aren't on Desktop, are you?");
            #end
        }
    
        /**
            * Called when the save file dialog is cancelled.
            */
        function onLoadCancel(_):Void
        {
            _file.removeEventListener(#if desktop Event.SELECT #else Event.COMPLETE #end, onLoadComplete);
            _file.removeEventListener(Event.CANCEL, onLoadCancel);
            _file.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
            _file = null;
            trace("Cancelled file loading.");
        }
    
        /**
            * Called if there is an error while saving the gameplay recording.
            */
        function onLoadError(_):Void
        {
            _file.removeEventListener(#if desktop Event.SELECT #else Event.COMPLETE #end, onLoadComplete);
            _file.removeEventListener(Event.CANCEL, onLoadCancel);
            _file.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
            _file = null;
            trace("Problem loading file");
        }
}