package states;

import flixel.FlxState;
import flixel.FlxSprite;
import lime.app.Application;

import lime.system.System;
import sys.FileSystem;
import haxe.Json;

import objects.CharGalleryEntry;
//import objects.ImageChar;

class CharGalleryState extends MusicBeatState
{

    var speedBg1:Float = 100;
    var speedBg2:Float = 150;

    var bg1:FlxSprite;
    var bg2:FlxSprite;
    var bg12:FlxSprite;
    var bg22:FlxSprite;

    var tit1:FlxSprite;
    var tit2:FlxSprite;

    //var cursorSprite:Dynamic;

    var txtName:FlxText;
    var txtDesc:FlxText;

    var charFiles:Array<String>;
    var chars:Array<EntryFile> = [];

    var char:CharGalleryEntry;
    var char_TEXT:CharGalleryEntry;

    var savedSpeed1:Float;
    var savedSpeed2:Float;
    var currentEntry:Int;
    var increaseAlpha:Bool;
    var decreaseAlpha:Bool;

    var alpha:Float = 1;

    var txtPress:FlxText;

    var minus:Bool;

    var onArt:Bool;
    var imageObj:FlxSprite;
    var bgArt:FlxSprite;
    //var arts:Array<ImageChar>;
    var arts:Array<Array<Array<String>>> = [];
    //var fullSwitch:Bool;
    var currentArt:Int;
    var artDesc:FlxText;

    override function create()
    {
        savedSpeed1 = speedBg1;
        savedSpeed2 = speedBg2;

        charFiles = File.getContent(System.applicationDirectory + "/assets/craftee/CharGallery/entryList.txt")
            .split("\n")
            .map(function(line) return line.trim())//This
            .filter(function(line) return line != "");//And This
		trace(charFiles);

        /*for(i in 0...charFiles.length)
        {
            charFiles[i] = charFiles[i] + ".json";
            trace(charFiles[i]);
        }*/

		for(json in charFiles)
		{
            trace(System.applicationDirectory + "assets/craftee/CharGallery/" + json);
			var jsonContents = File.getContent(System.applicationDirectory + "assets/craftee/CharGallery/" + json); // I Got Stuck Here For A Day. Just Needed To Add A Couple These. I Can Finally Relax Now
			var parsedJson = Json.parse(jsonContents);
    		chars.push(parsedJson);
			trace(parsedJson);

            try
            {
                var txtContents = File.getContent(System.applicationDirectory + "assets/craftee/CharGallery/" + json.substr(0, json.length - 5) + "_ART.txt")
                    //.split(",");
                    .split("\n")
                    .map(function(line) return line.trim())
                    .filter(function(line) return line != "");

                /*for(txt in txtContents)
                {
                    if(txt.substr(0, 2) == " ")
                    {
                        txt.substr(1);
                    }

                    if(txt.substr(0, 3) == "/n")
                    {
                        txt.substr(2);
                    }
                    trace(txt.substr(0, 2));
                    trace(txt.substr(0, 3));
                    trace(txt);
                }*/

                var image:Array<Array<String>> = [];
                //image.push([]);
                //var int:Int = 1;

                //trace(txtContents.length);

                var image2:Array<String> = [];
                for(i in 0...txtContents.length)
                {
                    /*if(int == 1) 
                    {
                        image2 = [];
                        image2.push(txtContents[i]);
                        int += 1;
                    }else if(int == 2)
                    {
                        image2.push(txtContents[i]);
                        int += 1;
                    }else
                    {
                        image2.push(txtContents[i]);
                        int = 1;
                        image.push(image2);
                        trace(image2);
                    }*/

                    image2.push(txtContents[i]);

                    if(image2.length == 3)
                    {
                        image.push(image2);
                        trace(image2);
                        image2 = [];
                    }
                }

                //image.push([json.substr(0, json.length - 5)]); I Dont Actually Need This Anymore Since I Have A Better Way To Fix The Bug

                arts.push(image);
                trace(image);
            }catch(e:Dynamic)
            {
                trace("ERROR YOU STUPID FUCK: " + e);

                var image:Array<Array<String>> = [];

                var image2:Array<String> = [
                    "placeholder.png",
                    "6",
                    "ERROR: " + e
                ];

                image.push(image2);

                arts.push(image);
                trace(image);
            }
		}
        trace(arts);

        //Application.current.window.width = 960;

        FlxG.camera.bgColor = FlxColor.BLACK;

        //FlxG.watch.add(FlxG.camera, "x", "CameraX");
        //FlxG.watch.add(FlxG.camera, "y", "CameraY");

        FlxG.watch.add(this, "speedBg1", "speedBg1");
        FlxG.watch.add(this, "speedBg2", "speedBg2");
        #if DISCORD_ALLOWED
        // Updating Discord Rich Presence
        DiscordClient.changePresence("Character Gallery", "Looking At *insert char name here*");
        #end

        bg1 = new FlxSprite().loadGraphic(Paths.image('CharGallery/bg1'));

        //cursorSprite = FlxG.mouse.cursor;

        //FlxG.mouse.load(Paths.image('CharGallery/gensMouse'), 3);

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

        txtDesc = new FlxText(0, 50, 250, "very cool text", 3);
		txtDesc.setFormat("VCR OSD Mono", 32, 0xFFFFFFFF, LEFT);
		add(txtDesc);

        bgArt = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
        bgArt.scrollFactor.set();
        bgArt.color = 0xFFA4FAFF;
        bgArt.alpha = 0;
        add(bgArt);

        txtName = new FlxText(0, 0, 0, "Char:", 20);
		txtName.setFormat("VCR OSD Mono", 32, 0xFFFFFFFF, CENTER);
		add(txtName);

        imageObj = new FlxSprite().loadGraphic(Paths.image('CharGallery/Characters/Art/placeholder'));
        imageObj.alpha = 0;
        add(imageObj);

        artDesc = new FlxText(0, 590, 750, "temp description", 20);
		artDesc.setFormat("VCR OSD Mono", 32, 0xFFFFFFFF, CENTER);
        artDesc.alpha = 0;
		add(artDesc);

        txtPress = new FlxText(0, 640, 0, "press SPACE to open art", 20);
		txtPress.setFormat("VCR OSD Mono", 32, 0xFFFFFFFF, CENTER);
        txtPress.screenCenter(X);
        txtPress.x -= 30;
		add(txtPress);

        /*var timer = new haxe.Timer(550);
        timer.run = function() {
            if(txtPress.alpha == 0)
            {
                txtPress.alpha = 1;
            }else
            {
                txtPress.alpha = 0;
            }
        }*/

        var timer = new FlxTimer().start(0.550, function(timer:FlxTimer)
        {
            if(txtPress.alpha == 0)
            {
                txtPress.alpha = 1;
            }else
            {
                txtPress.alpha = 0;
            }
        }, 0);

        FlxG.mouse.visible = true;

        changeEntry(currentEntry);

        super.create();
    }

    override function update(elapsed:Float)
    {
        if(FlxG.keys.justPressed.ESCAPE)
        {
            //Application.current.window.width = 1020;
            //FlxG.mouse.load(cursorSprite, 1);
            MusicBeatState.switchState(new MainMenuState());
            FlxG.sound.playMusic(Paths.music('freakyMenu'));
        }

        if(FlxG.keys.justPressed.SPACE)
        {
            if(onArt)
            {
                imageObj.alpha = 0;
                artDesc.alpha = 0;
                onArt = false;
                txtPress.text = "press SPACE to open art";
                txtPress.screenCenter(X);
                txtPress.x -= 30;
                bgArt.alpha = 0;
            }else
            {
                imageObj.alpha = 1;
                artDesc.alpha = 1;
                onArt = true;
                txtPress.text = "press SPACE to close art";
                txtPress.screenCenter(X);
                txtPress.x -= 30;
                bgArt.alpha = 0.8;
            }
        }

        if(alpha == 0 || alpha == 1)
        {
            speedBg1 = savedSpeed1;
            speedBg2 = savedSpeed2;
        }else
        {
            if(!minus)
            {
                speedBg1 = savedSpeed1 * 10;
                speedBg2 = savedSpeed2 * 10;
            }else
            {
                speedBg1 = -savedSpeed1 * 10;
                speedBg2 = -savedSpeed2 * 10;
            }
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

        if(bg1.x > 1650)
        {
            bg1.x = bg12.x - 1650;
        }

        if(bg12.x > 1650)
        {
            bg12.x = bg1.x - 1650;
        }

        if(bg2.x > 1650)
        {
            bg2.x = bg22.x - 1650;
        }

        if(bg22.x > 1650)
        {
            bg22.x = bg2.x - 1650;
        }
        
        if(!onArt)
        {
            if(controls.UI_LEFT_P)
            {
                if(currentEntry != 0)
                {
                    currentEntry -= 1;
                }else
                {
                    currentEntry = chars.length - 1;
                }

                minus = true;

                //switchEntry(currentEntry);
                decreaseAlpha = true;

                FlxG.sound.play(Paths.sound('scrollMenu'));
            }

            if(controls.UI_RIGHT_P)
            {
                if(currentEntry != chars.length - 1)
                {
                    currentEntry += 1;
                }else
                {
                    currentEntry = 0;
                }

                minus = false;

                //switchEntry(currentEntry);
                decreaseAlpha = true;

                FlxG.sound.play(Paths.sound('scrollMenu'));
            }

            if(decreaseAlpha)
            {
                if(alpha > 0)
                {
                    alpha -= 3 * elapsed;
                }else
                {
                    changeEntry(currentEntry);

                    increaseAlpha = true;

                    decreaseAlpha = false;
                }
            }

            if(increaseAlpha)
            {
                if(!decreaseAlpha)
                {
                    if(alpha < 1)
                    {
                        alpha += 3 * elapsed;
                    }else
                    {
                        increaseAlpha = false;
                    }
                }else
                {
                    increaseAlpha = false;
                }
            }

            if(alpha < 0)
            {
                alpha = 0;
            }

            if(alpha > 1)
            {
                alpha = 1;
            }

            char.alpha = alpha;
            char_TEXT.alpha = alpha;
            txtName.alpha = alpha;
            txtDesc.alpha = alpha;
        }else
        {
            if(FlxG.keys.justPressed.Q)
            {
                if(currentEntry != 0)
                {
                    currentEntry -= 1;
                }else
                {
                    currentEntry = chars.length - 1;
                }
                currentArt = 0;
                //fullSwitch = true;

                minus = true;

                //switchEntry(currentEntry);
                decreaseAlpha = true;

                FlxG.sound.play(Paths.sound('scrollMenu'));
            }

            if(FlxG.keys.justPressed.E)
            {
                if(currentEntry != chars.length - 1)
                {
                    currentEntry += 1;
                }else
                {
                    currentEntry = 0;
                }
                currentArt = 0;
                //fullSwitch = true;

                minus = false;

                //switchEntry(currentEntry);
                decreaseAlpha = true;

                FlxG.sound.play(Paths.sound('scrollMenu'));
            }

            if(controls.UI_LEFT_P)
            {
                if(currentArt != 0)
                {
                    currentArt -= 1;
                    //fullSwitch = false;
                }else
                {
                    if(currentEntry != 0)
                    {
                        currentEntry -= 1;
                    }else
                    {
                        currentEntry = chars.length - 1;
                    }
                    currentArt = arts[currentEntry].length - 1;
                    //fullSwitch = true;
                }

                minus = true;

                //switchEntry(currentEntry);
                decreaseAlpha = true;

                FlxG.sound.play(Paths.sound('scrollMenu'));
            }

            if(controls.UI_RIGHT_P)
            {
                if(currentArt != arts[currentEntry].length - 1)
                {
                    currentArt += 1;
                    //fullSwitch = false;
                }else
                {
                    if(currentEntry != chars.length - 1)
                    {
                        currentEntry += 1;
                    }else
                    {
                        currentEntry = 0;
                    }
                    currentArt = 0;
                    //fullSwitch = true;
                }

                minus = false;

                //switchEntry(currentEntry);
                decreaseAlpha = true;

                FlxG.sound.play(Paths.sound('scrollMenu'));
            }

            if(decreaseAlpha)
            {
                if(alpha > 0)
                {
                    alpha -= 3 * elapsed;
                }else
                {
                    changeEntry(currentEntry);
                    changeArt(currentEntry, currentArt);

                    increaseAlpha = true;

                    decreaseAlpha = false;
                }
            }

            if(increaseAlpha)
            {
                if(!decreaseAlpha)
                {
                    if(alpha < 1)
                    {
                        alpha += 3 * elapsed;
                    }else
                    {
                        increaseAlpha = false;
                    }
                }else
                {
                    increaseAlpha = false;
                }
            }

            if(alpha < 0)
            {
                alpha = 0;
            }

            if(alpha > 1)
            {
                alpha = 1;
            }

            char.alpha = alpha;
            char_TEXT.alpha = alpha;
            txtName.alpha = alpha;
            txtDesc.alpha = alpha;
            imageObj.alpha = alpha;
            artDesc.alpha = alpha;
        }
    
        super.update(elapsed);
    }

    /*function switchEntry(entryNum:Int)
    {
        decreaseAlpha = true;

        while(decreaseAlpha)
        {
            trace("Unable To Progress... Waiting For decreaseAlpha To Finish");
        }
        trace("decreaseAlpha Finished");

        changeEntry(entryNum);

        increaseAlpha = true;

        while(increaseAlpha)
        {
            trace("Unable To Progress... Waiting For increaseAlpha To Finish");
        }
        trace("increaseAlpha Finished");
    }*/
    
    function changeEntry(entryNum:Int)
    {
        char.setNewImage(chars[entryNum].char.image, chars[entryNum].char.inCharacters);
        char.x = chars[entryNum].char.x;
        char.y = chars[entryNum].char.y;
        char.scale.x = chars[entryNum].char.scale;
        char.scale.y = chars[entryNum].char.scale;
        char.antialiasing = chars[entryNum].char.antialiasing;
        char.flipX = chars[entryNum].char.flipX;

        char_TEXT.setNewImage(chars[entryNum].char_TEXT.image, chars[entryNum].char_TEXT.inCharacters);
        char_TEXT.x = chars[entryNum].char_TEXT.x;
        char_TEXT.y = chars[entryNum].char_TEXT.y;
        char_TEXT.scale.x = chars[entryNum].char_TEXT.scale;
        char_TEXT.scale.y = chars[entryNum].char_TEXT.scale;
        char_TEXT.antialiasing = chars[entryNum].char_TEXT.antialiasing;
        char_TEXT.flipX = chars[entryNum].char_TEXT.flipX;

        txtName.text = chars[entryNum].char.image.toUpperCase() + ": ";
        txtDesc.text = chars[entryNum].description;

        #if DISCORD_ALLOWED
        // Updating Discord Rich Presence
        DiscordClient.changePresence("Character Gallery", "Looking At " + chars[entryNum].char.image);
        #end

        changeArt(entryNum);
    }

    function changeArt(entryNum:Int, ?artNum:Int = 0)
    {
        imageObj.loadGraphic(Paths.image('CharGallery/Characters/Art/' + arts[entryNum][artNum][0].substr(0, arts[entryNum][artNum][0].length - 4)));
        imageObj.screenCenter();
        imageObj.scale.x = Std.parseFloat(arts[entryNum][artNum][1]);
        imageObj.scale.y = Std.parseFloat(arts[entryNum][artNum][1]);
        artDesc.text = arts[entryNum][artNum][2];
        artDesc.screenCenter(X);
        artDesc.x -= 30;

        imageObj.antialiasing = true;
    }
}

typedef EntryFile = {
    public var char:Entry;
    public var char_TEXT:Entry;
    public var description:String;
}

typedef Entry = {
    public var x:Float; 
    public var y:Float;
    public var scale:Float;
    public var image:String;
    public var antialiasing:Bool;
    public var inCharacters:Bool;
    public var flipX:Bool;
}