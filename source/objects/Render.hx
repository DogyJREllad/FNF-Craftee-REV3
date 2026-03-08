package objects;

typedef RenderFile = {
    public var xPosition:Float; 
    public var yPosition:Float;
    public var size:Float;
    public var image:String;
    public var isAntialiasing:Bool;
    public var renderPortraits:Bool;
    public var isFlipX:Bool;
    public var songs:Array<String>;
}

class Render extends FlxSprite
{
    public var renderFile:RenderFile = null;
    var centerX:Float;
    var centerY:Float;

    public function new(x:Float, y:Float, scale:Float, imageName:String = '', antialiasing:Bool, ?inRenderPortraits:Bool = true, ?flipX = false)
    {
        renderFile = {
            xPosition: 0,
            yPosition: 0,
            size: 1,
            image: 'placeholder',
            isAntialiasing: true,
            renderPortraits: true,
            isFlipX: false,
            songs: ['Bopeebo', 'Fresh', 'Dadbattle']
        }

        super(x, y);

        trace("Render Spawned");
        renderFile.xPosition = x;
        renderFile.yPosition = y;
        renderFile.size = scale;
        renderFile.image = imageName;
        renderFile.isAntialiasing = antialiasing;
        screenCenter();
        centerX = this.x;
        centerY = this.y;
        FlxG.watch.add(this, "x", "RenderX");
        FlxG.watch.add(this, "y", "RenderY");
        FlxG.watch.add(this, "scale", "RenderSize");
        renderFile.image = imageName;
        renderFile.renderPortraits = inRenderPortraits;
        if(inRenderPortraits == true)
        {
            loadGraphic(Paths.image('RenderPortraits/' + imageName/*, "craftee"*/));
        }else
        {
            loadGraphic(Paths.image(imageName/*, "craftee"*/));
        }
    }

    override function update(elapsed:Float)
    {
        var sizeAxis:FlxPoint = new FlxPoint();
        sizeAxis.x = renderFile.size;
        sizeAxis.y = renderFile.size;

        x = centerX + renderFile.xPosition;
        y = centerY + renderFile.yPosition;
        scale = sizeAxis;
        antialiasing = renderFile.isAntialiasing;
        flipX = renderFile.isFlipX;

        super.update(elapsed);
    }

    public function setNewImage(imageName:String = '', ?inRenderPortraits:Bool = true)
    {
        renderFile.image = imageName;
        renderFile.renderPortraits = inRenderPortraits;

        if(inRenderPortraits == true)
        {
            loadGraphic(Paths.image('RenderPortraits/' + imageName/*, "craftee"*/));
        }else
        {
            loadGraphic(Paths.image(imageName/*, "craftee"*/));
        }

        screenCenter();
        centerX = this.x;
        centerY = this.y;
    }
}