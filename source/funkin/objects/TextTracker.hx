package funkin.objects;

import flixel.FlxSprite;
import flixel.text.FlxText;

class TextTracker extends Alphabet
{
	public var offsetX:Float = 0;
	public var offsetY:Float = 0;
	public var sprTracker:FlxSprite;
	public var copyVisible:Bool = true;
	public var copyAlpha:Bool = false;
	public var Text:FlxText;

	public function new(text:String = "", ?offsetX:Float = 0, ?offsetY:Float = 0, ?scale:Float = 0, ?qqqeb:Float = 0)
	{
		super(0, 0, text);
		isMenuItem = false;
		this.offsetX = offsetX;
		this.offsetY = offsetY;
		
		Text = new FlxText(offsetX, offsetY, qqqeb, text, scale);
		#end
		Text.setFormat(Paths.font("candy.otf"), scale, FlxColor.BLACK, LEFT);
		//Text.screenCenter(Y);
		add(Text);
	}

	override function update(elapsed:Float)
	{
		if (sprTracker != null)
		{
			setPosition(sprTracker.x + offsetX, sprTracker.y + offsetY);
			if (copyVisible)
			{
				visible = sprTracker.visible;
			}
			if (copyAlpha)
			{
				alpha = sprTracker.alpha;
			}
		}

		super.update(elapsed);
	}
}
