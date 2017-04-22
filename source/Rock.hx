package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author 
 */
class Rock extends FlashSprite
{

	public var visited : Bool = false;
	
	public function new(X : Float, Y : Float ) 
	{
		super(X, Y);
		
		var r2 : Int = FlxG.random.int(0, 7);
		this.loadGraphic(AssetPaths.Rockset_small__png, true, 16, 16);
		this.animation.add("idle", [r2], 3, true);
		this.animation.play("idle");

		this.immovable = true;
		this.alpha = 0;
	}
	
	public inline function visitMe()
	{
		alpha = 1;
		visited = true;
	}
	
}