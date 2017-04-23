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
		this.loadGraphic(AssetPaths.Tent__png, false, 64, 32);
		this.scale.set(0.75, 0.75);
		
	}
	
	public override function doUse(p : Player)
	{
		//trace("use tent");
		p.Flash(0.25, FlxColor.fromRGB(0,255,0,10));
		p.Exhaustion = 1;
		
	}
	
}