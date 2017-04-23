package;
import flixel.FlxG;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class PlaceableFire extends Placeable
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
	}
	
	public function doAppplySourroundingEffect(p : Player)
	{
		p.Warmth += 0.3 * FlxG.elapsed;
		p.Flash(0.25, FlxColor.fromRGB(255,0,0,10));
	}
}