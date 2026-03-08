package objects;

class CharGalleryEntry extends FlxSprite
{
    public var centerX:Float;
    public var centerY:Float;

    public function new(x:Float, y:Float, scale:Float, imageName:String = '', antialiasing:Bool, ?inCharacters:Bool = true, ?flipX = false)
    {

        super(x, y);

        screenCenter();
        centerX = this.x;
        centerY = this.y;

        FlxG.watch.add(this, "x", "EntryX");
        FlxG.watch.add(this, "y", "EntryY");
        FlxG.watch.add(this, "scale", "EntrySize");

        if(inCharacters == true)
        {
            loadGraphic(Paths.image('CharGallery/Characters/' + imageName/*, "craftee"*/));
        }else
        {
            loadGraphic(Paths.image(imageName/*, "craftee"*/));
        }
    }

    /*override function update(elapsed:Float)
    {
        super.update(elapsed);
    }*/

    public function setNewImage(imageName:String = '', ?inCharacters:Bool = true)
    {
        if(inCharacters == true)
        {
            loadGraphic(Paths.image('CharGallery/Characters/' + imageName/*, "craftee"*/));
        }else
        {
            loadGraphic(Paths.image(imageName/*, "craftee"*/));
        }

        screenCenter();
        centerX = this.x;
        centerY = this.y;
    }
}