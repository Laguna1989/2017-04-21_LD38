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
		this.loadGraphic(AssetPaths.fire__png, true, 16, 16);
		this.animation.add("idle", [0, 1, 2, 3, 4, 5, 4, 3], 5);
		this.animation.play("idle");
		
	}
	
	public override function doAppplySourroundingEffect(p : Player)
	{
		p.Warmth += 0.3 * FlxG.elapsed;
		if (p.Warmth > 1) p.Warmth = 1;
		p.Flash(0.25, FlxColor.fromRGB(255,150,150,10));
	}
}