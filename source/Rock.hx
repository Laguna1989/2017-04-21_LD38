package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author 
 */
class Rock extends Destroyables
{
	private var dropItem2 : Item = null;
	private var dropQuantity2 : Int = 4;
	
	public function new( X : Float, Y : Float ) 
	{
		super( X, Y);
		
		dropItem = ItemManager.getItem("Stone");
		
		var r2 : Int = FlxG.random.int(0, 7);
		this.loadGraphic(AssetPaths.Rockset_small__png, true, 16, 16);
		this.animation.add("idle", [r2], 3, true);
		this.animation.play("idle");

		this.immovable = true;
		this.alpha = 0;
		dropQuantity = 3;
		health = 1.1;
		toolUsage = 0.03;
		
		var ran : Int = FlxG.random.int(0, 2);
		dropQuantity2 = 2;
		if (ran == 0)
		{
			dropItem2 = ItemManager.getItem("IronOre");
			if (dropItem2 == null) throw "ERROR: could not create Iron";
		}
		else if (ran == 1)
		{
			dropItem2 = ItemManager.getItem("Coal");
			dropQuantity2 = 5;
			if (dropItem2 == null) throw "ERROR: could not create Coal";
		}
		else if (ran == 2)
		{
			dropItem2 = ItemManager.getItem("CopperOre");
			if (dropItem2 == null) throw "ERROR: could not create Copper";
		}
		
	}
	
	public override function destroyMe(state:PlayState) : Bool
	{
		super.destroyMe(state);	// drop stones
		
		var ao : Float = FlxG.random.float(0, Math.PI * 2);
		//trace("destroyable: destroyME, N= " + dropQuantity + " , ao= " + ao);
		for (i in 0 ... dropQuantity2)
		{
			//trace("destroyable: destroyME: Drop item" );
			//trace("destroyable: destroyME: Drop item Name: " + dropItem );
			if (dropItem2 == null) throw "ERROR: cannot clone null item! dropitem2";
			var r : Item = dropItem2.clone();
			r.x = x;
			r.y = y;
			
			var a : Float = i * Math.PI * 2.0 / dropQuantity2 + ao;
			r.velocity.set(Math.cos(a) * 150, Math.sin(a) * 150);
			r.drag.set(500, 500);
			
			trace("dropresource");
			state._level.dropResourceInLevel(r);
		}
		
		return false;
	}
	
	
}