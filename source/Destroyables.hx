package;

import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Destroyables extends FlashSprite
{
	public var visited : Bool = false;
	
	public var dropItem : Item = null;
	public var dropQuantity : Int = 4;
	
	public var toolUsage : Float = 0;
	
	public function new( X : Float, Y : Float) 
	{
		super(X, Y);
		health = 1;
		this.immovable = true;
		this.alpha = 0;
	}
	
	public inline function visitMe()
	{
		//alpha = 1;
		this.scale.set(0.5, 0.5);
		FlxTween.tween(this, { alpha : 1 }, 0.5);
		FlxTween.tween(this.scale, { x: 1, y:1 }, 0.3);
		visited = true;
	}
	
	public function takeDamage(v : Float) : Void
	{
		
		this.Flash(0.2, FlxColor.fromRGB(255, 255, 255, 10));
		health -= v;
		if (health <= 0)
		{
			//trace("take damage & alive = false");
			this.alive = false;
		}
	}
	
	// return value is reuse
	public function destroyMe(state:PlayState) : Bool
	{
		
		var ao : Float = FlxG.random.float(0, Math.PI * 2);
		//trace("destroyable: destroyME, N= " + dropQuantity + " , ao= " + ao);
		for (i in 0 ... dropQuantity)
		{
			//trace("destroyable: destroyME: Drop item" );
			//trace("destroyable: destroyME: Drop item Name: " + dropItem );
			var r : Item = dropItem.clone();
			r.x = x;
			r.y = y;
			
			var a : Float = i * Math.PI * 2.0 / dropQuantity + ao;
			r.velocity.set(Math.cos(a) * 150, Math.sin(a) * 150);
			r.drag.set(500, 500);
			
			//trace("dropresource");
			state._level.dropResourceInLevel(r);
		}
		
		return false;
	}
	
	
}