package funkin.objects;

import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class TextTracker extends FlxText {
    public var sprTracker:FlxSprite;
    public var offset_x:Float = 0;
    public var offset_y:Float = 0;
    public var frameHeight:Float = 0;

    public function new(Text:String, X:Float, Y:Float, Size:Int, MaxWidth:Int) {
        super(X, Y, MaxWidth, Text, Size);

        this.setFormat(Paths.font("candy.otf"), Size, FlxColor.BLACK, "left");
        this.scrollFactor.set();
        this.alignment = "left";

        // Calculate frame height based on text length and max width
        var textHeight = Std.int(FlxG.bitmapFont.measureText(Text, Size).height);
        this.frameHeight = Math.max(this.height, textHeight);
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        // Update position based on the tracked sprite's position
        if (sprTracker != null) {
            this.x = sprTracker.x + offset_x;
            this.y = sprTracker.y + offset_y;
        }
    }

    // Function to set the text content
    public function setTextContent(newText:String):Void {
        this.text = newText;

        // Recalculate frame height based on new text length
        var textHeight = Std.int(FlxG.bitmapFont.measureText(newText, this.size).height);
        this.frameHeight = Math.max(this.height, textHeight);
    }
}
