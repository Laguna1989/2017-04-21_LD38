package;

import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author 
 */
class Destroyables extends FlashSprite
{
	public var visited : Bool = false;
	
	public var dropItem : Resource = null;
	public var dropQuantity : Int = 4;
	
	public function new( X : Float, Y : Float) 
	{
		super(X, Y);
		health = 1;
	}
	
	public inline function visitMe()
	{
		alpha = 1;
		visited = true;
	}
	
	public function takeDamage(v : Float) : Void
	{
		health -= v;
		if (health <= 0)
		{
			this.alive = false;
		
			
		}
	}
	
	public function destroyMe(state:PlayState)
	{
		var ao : Float = FlxG.random.float(0, Math.PI * 2);
		for (i in 0 ... dropQuantity)
		{
			var r : Resource = dropItem.clone();
			r.x = x;
			r.y = y;
			
			var a : Float = i * Math.PI * 2.0 / dropQuantity + ao;
			r.velocity.set(Math.cos(a) * 150, Math.sin(a) * 150);
			r.drag.set(500, 500);
			
			state._level.dropResourceInLevel(r);
		}
	}
	
	
}