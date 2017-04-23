package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author 
 */
class Shrub extends Destroyables
{
	private var fruitTimer : Float = 0;
	private var hasFruit : Bool = false;
	
	public function new(X: Float, Y : Float) 
	{
		super(X, Y);
		
		this.loadGraphic(AssetPaths.bushes__png, true, 16, 16);
		
		var idx = FlxG.random.int(0, 3);
		this.animation.add("empty", [idx]);
		this.animation.add("fruit", [idx + 4]);
	
		fruitTimer = FlxG.random.floatNormal(20, 10);
		
		if(FlxG.random.bool())
		{
			//trace("fibres");
			dropItem = cast ItemManager.getItem("Berry");
			dropQuantity = FlxG.random.int(3,5);
		}
		else
		{
			//trace("berry");
			dropItem = cast ItemManager.getItem("Berry");
			dropQuantity = 2;
		}
		
		toolUsage = 0;
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		fruitTimer -= elapsed;
		
		if (fruitTimer < 0)
		{
			if (!hasFruit)
			{
				hasFruit = true;
				this.animation.play("fruit");
				this.scale.set(1.4, 1.4);
				FlxTween.tween(this.scale, { x:1, y:1 }, 0.25 );
				//trace("bloom");
			}
		}
		else
		{
			hasFruit = false;
			this.animation.play("empty");
		}
	}
	
	private function pickFruit()
	{
		trace("pickFruit:" + this.dropItem.Name);
		health = 1.0;
		alive = true;
		fruitTimer = FlxG.random.floatNormal(40, 10);
		hasFruit = false;
		this.scale.set(0.8, 0.8);
		FlxTween.tween(this.scale, { x:1, y:1 }, 0.25 );
		
	}
	
	public override function destroyMe(state:PlayState) : Bool
	{
		trace("drop:" + this.dropItem.Name);
		if (hasFruit)
		{
			super.destroyMe(state);
		}
		pickFruit();
		return true;
	}
	
}