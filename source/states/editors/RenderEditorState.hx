//I Got Stuck Here Forever. What Was The Problem. I FORGOT TO PUT "super.update(elapsed);" FUCKING KILL ME
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

import objects.Render;

class RenderEditorState extends MusicBeatState
{
    var txtOffsets:FlxText;
    var render:Render;
    //var renderFile:RenderFile;
    var yStepper:FlxUINumericStepper;
    var xStepper:FlxUINumericStepper;
    var scaleStepper:FlxUINumericStepper;
    var imageInputText:FlxUIInputText;
    var songsInputText:FlxUIInputText;
    var antialiasingCheckbox:FlxUICheckBox;
    var isCheckbox:FlxUICheckBox;
    var flipCheckbox:FlxUICheckBox;
    var _file:FileReference = null;

    override function create()
    {

        FlxG.camera.bgColor = FlxColor.BLACK;
        #if DISCORD_ALLOWED
        // Updating Discord Rich Presence
        //DiscordClient.changePresence("Freeplay Render Editor", null);
        #end

        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
        bg.scrollFactor.set();
        bg.color = 0xFFA4FAFF;
        add(bg);

        render = new Render(0, 0, 1, "placeholder", true);
        //render.screenCenter();
        //render.xPosition = render.x;
        //render.yPosition = render.y;
        add(render); //FORGOT TO ADD IT OMG >:(
    
        txtOffsets = new FlxText(20, 620, 0, "[0, 0]", 20);
		txtOffsets.setFormat("VCR OSD Mono", 32, 0xFF232323, CENTER);
		txtOffsets.alpha = 0.7;
        txtOffsets.screenCenter(X);
        //txtOffsets.x += 475;
		add(txtOffsets);

        xStepper = new FlxUINumericStepper(0, 627.5, 10, 0, -9999, 9999, 2);
        xStepper.screenCenter(X);
		xStepper.x -= 145;
        add(xStepper);

        FlxG.watch.add(xStepper, "x", "XStepperX");
        FlxG.watch.add(xStepper, "y", "XStepperY");

        yStepper = new FlxUINumericStepper(0, 627.5, 10, 0, -9999, 9999, 2);
        yStepper.screenCenter(X);
		yStepper.x += 145;
        add(yStepper);

        FlxG.watch.add(yStepper, "x", "YStepperX");
        FlxG.watch.add(yStepper, "y", "YStepperY");

        var loadButton:FlxButton = new FlxButton(0, 690, "Load Render", function() {
            loadRender();  
        });
		loadButton.screenCenter(X);
		loadButton.x += 475;
		add(loadButton);
        
        FlxG.watch.add(loadButton, "x", "loadButtonX");
        FlxG.watch.add(loadButton, "y", "loadButtonY");

		var saveButton:FlxButton = new FlxButton(0, 690, "Save Render", function() {
            saveRender();  
        });
		saveButton.screenCenter(X);
		saveButton.x += 575;
		add(saveButton);

        FlxG.watch.add(saveButton, "x", "saveButtonX");
        FlxG.watch.add(saveButton, "y", "saveButtonY");

        scaleStepper = new FlxUINumericStepper(0, 692.5, 0.1, 1, 0.1, 30, 2);
        scaleStepper.screenCenter(X);
        //scaleStepper.screenCenter(Y);
		scaleStepper.x += 400;
        add(scaleStepper);

        FlxG.watch.add(scaleStepper, "x", "scaleStepperX");
        FlxG.watch.add(scaleStepper, "y", "scaleStepperY");

        FlxG.mouse.visible = true;

        imageInputText = new FlxUIInputText(0, 690, 80, render.renderFile.image, 8);
        imageInputText.screenCenter(X);
		imageInputText.x -= 575;
        add(imageInputText);

        isCheckbox = new FlxUICheckBox(0, 690, null, null, "in Render Portraits", 50);
        isCheckbox.screenCenter(X);
		isCheckbox.x -= 375;
        isCheckbox.checked = true;
        add(isCheckbox);

        var setImageButton:FlxButton = new FlxButton(0, 690, "Set Image", function() {
            render.setNewImage(imageInputText.text, isCheckbox.checked);  
        });
		setImageButton.screenCenter(X);
		setImageButton.x -= 485;
		add(setImageButton);

        antialiasingCheckbox = new FlxUICheckBox(0, 690, null, null, "Antialiasing", 50);
        antialiasingCheckbox.screenCenter(X);
		antialiasingCheckbox.x += 325;
        antialiasingCheckbox.checked = true;
        add(antialiasingCheckbox);

        flipCheckbox = new FlxUICheckBox(0, 690, null, null, "Flip X", 50);
        flipCheckbox.screenCenter(X);
		flipCheckbox.x += 250;
        add(flipCheckbox);

        songsInputText = new FlxUIInputText(0, 600, 900, "Bopeebo, Fresh, Dadbattle", 15);
        songsInputText.screenCenter(X);
        add(songsInputText);

        super.create();
    }

    override function update(elapsed:Float)
    {
        if(FlxG.keys.justPressed.ESCAPE)
		{
			MusicBeatState.switchState(new MasterEditorMenu());
            FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

        txtOffsets.text = "[" + xStepper.value + ", " + yStepper.value + "]";
        txtOffsets.screenCenter(X);

        render.renderFile.xPosition = xStepper.value;
        render.renderFile.yPosition = yStepper.value;
        render.renderFile.size = scaleStepper.value;
        render.renderFile.isAntialiasing = antialiasingCheckbox.checked;
        render.renderFile.isFlipX = flipCheckbox.checked;
        render.renderFile.songs = songsInputText.text.trim().split(', ');

        #if DISCORD_ALLOWED
        DiscordClient.changePresence("Freeplay Render Editor", "Editing: " + render.renderFile.image);
        #end

        super.update(elapsed);
    }

    function saveRender() 
    {
        var data:String = haxe.Json.stringify(render.renderFile, "\t");
		if (data.length > 0)
		{
			var splittedImage:Array<String> = imageInputText.text.trim().split('_');
			var renderName:String = splittedImage[splittedImage.length-1].toLowerCase().replace(' ', '');

			_file = new FileReference();
			_file.addEventListener(#if desktop Event.SELECT #else Event.COMPLETE #end, onSaveComplete);
			_file.addEventListener(Event.CANCEL, onSaveCancel);
			_file.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
			_file.save(data, renderName + ".json");
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

    function loadRender() 
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
                    var loadedRender:RenderFile = cast Json.parse(rawJson);
                    //if(loadedRender.idle_anim != null && loadedRender.confirm_anim != null) //Make sure it's really a character
                    //{
                        var cutName:String = _file.name.substr(0, _file.name.length - 5);
                        trace("Successfully loaded file: " + cutName);
                        //characterFile = loadedRender;
                        render.setNewImage(loadedRender.image, loadedRender.renderPortraits);
                        xStepper.value = loadedRender.xPosition;
                        yStepper.value = loadedRender.yPosition;
                        scaleStepper.value = loadedRender.size;
                        antialiasingCheckbox.checked = loadedRender.isAntialiasing;
                        flipCheckbox.checked = loadedRender.isFlipX;
                        imageInputText.text = loadedRender.image;
                        isCheckbox.checked = loadedRender.renderPortraits;

                        var songsString:String = loadedRender.songs[0];
		                for (i in 1...loadedRender.songs.length) {
		                	songsString += ', ' + loadedRender.songs[i];
		                }
                        songsInputText.text = songsString;
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