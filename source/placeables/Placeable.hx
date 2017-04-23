package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author 
 */
class Placeable extends FlxSprite
{

	public var DeadTime : Float = 2;
	
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
	}
	
	public function Use(p : Player)
	{
		if (DeadTime <= 0)
		{
			DeadTime = 2.0;
			doUse(p);
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		DeadTime -= elapsed;
	}
	
	public function doUse(p : Player)
	{
		
	}
	
	public function ApplySourroundingEffect(p : Player)
	{
		var dx: Float = x + width/2 - p.x - 8;
		if (dx > GP.TileSize * 2) return;
		
		var dy: Float = y + height/2 - p.y - 8;
		if (dy > GP.TileSize * 2) return;
		
		var l : Float = dx * dx  + dy * dy;
		if (l < GP.TileSize * GP.TileSize * 2 * 2)
		{
			doAppplySourroundingEffect(p);
		}
	}
	public function doAppplySourroundingEffect(p : Player)
	{
		
	}
}