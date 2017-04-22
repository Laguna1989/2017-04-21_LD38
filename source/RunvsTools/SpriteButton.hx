package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;

class SpriteButton extends FlxSprite
{
    public override function new(xPos : Float, yPos : Float, path : String)
    {
        super(xPos, yPos, path);
    }


    public override function update(elapsed: Float)
    {
        super.update(elapsed);

        var mousePosition : FlxPoint = FlxG.mouse.getScreenPosition();
        if(mousePosition.x >= x && mousePosition.x < x + width
        && mousePosition.y >= y && mousePosition.y < y + height)
        {
            alpha = 0.2;
        }
        else
        {
            alpha = 1.0;
        }
    }
}