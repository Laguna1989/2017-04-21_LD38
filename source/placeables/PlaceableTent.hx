package;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class PlaceableTent extends Placeable
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
	}
	
	public override function Use(p : Player)
	{
		p.Flash(0.25, FlxColor.fromRGB(0,255,0,10));
		p.Exhaustion = 1;
		
	}
	
}