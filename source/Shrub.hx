package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

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
		dropItem = cast ItemManager.getItem("Wood");
		dropQuantity = 1;
		
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
				trace("bloom");
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
		health = 1.0;
		alive = true;
		fruitTimer = FlxG.random.floatNormal(40, 10);
		hasFruit = false;
	}
	
	public override function destroyMe(state:PlayState) : Bool
	{
		if (hasFruit)
		{
			super.destroyMe(state);
		}
		pickFruit();
		return true;
	}
	
}