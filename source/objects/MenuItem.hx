package objects;

class MenuItem extends FlxSprite
{
	public var targetX:Float = 0;
	public var centerX:Float;
	public var centerY:Float;

	public function new(x:Float, y:Float, weekName:String = '')
	{
		super(x, y);
		loadGraphic(Paths.image('storymenu/' + weekName));
		antialiasing = ClientPrefs.data.antialiasing;
		//trace('Test added: ' + WeekData.getWeekNumber(weekNum) + ' (' + weekNum + ')');
		screenCenter();
		centerX = this.x;
		centerY = this.y;
		trace(centerX);
		trace(centerY);
	}

	public var isFlashing(default, set):Bool = false;
	private var _flashingElapsed:Float = 0;
	final _flashColor = 0xFF33FFFF;
	final flashes_ps:Int = 6;

	public function set_isFlashing(value:Bool = true):Bool
	{
		isFlashing = value;
		_flashingElapsed = 0;
		color = (isFlashing) ? _flashColor : FlxColor.WHITE;
		return isFlashing;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		x = FlxMath.lerp((targetX * 120) + centerX, x, Math.exp(-elapsed * 10.2));
		//this.y = 480;
		//trace(this.y);
		if (isFlashing)
		{
			_flashingElapsed += elapsed;
			color = (Math.floor(_flashingElapsed * FlxG.updateFramerate * flashes_ps) % 2 == 0) ? _flashColor : FlxColor.WHITE;
		}
	}
}
