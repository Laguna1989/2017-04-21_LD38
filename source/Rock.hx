package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author 
 */
class Rock extends FlxSprite
{

	public var visited : Bool = false;
	
	public function new(X : Float, Y : Float ) 
	{
		super(X, Y);
		
		//this.makeGraphic(Std.int(GP.TileSize / 2), GP.TileSize, FlxColor.BROWN);
		
		//var r1 : Bool = FlxG.random.bool();
		//if (r1)
		//{
			// small
			var r2 : Int = FlxG.random.int(0, 7);
			this.loadGraphic(AssetPaths.Rockset_small__png, true, 16, 16);
			this.animation.add("idle", [r2], 3, true);
			this.animation.play("idle");
		//}
		//else
		//{
			//var r2 : Int = FlxG.random.int(0, 3);
			//this.loadGraphic(AssetPaths.Rockset_huge__png, true, 32,32);
			//this.animation.add("idle", [r2], 3, true);
		//}
		//
		this.immovable = true;
		this.alpha = 0;
	}
	
	public inline function visitMe()
	{
		alpha = 1;
		visited = true;
	}
	
}