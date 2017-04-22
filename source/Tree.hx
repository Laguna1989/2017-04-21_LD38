package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Tree extends Destroyables
{
	
	public var collisionSprite : FlxSprite;
	
	public function new(X : Float, Y : Float ) 
	{
		super(X, Y);
		
		dropItem = cast ItemManager.getItem("Wood");
		
		var r : Int = FlxG.random.int(1, 6);
		
		if (r == 1)
		{
			x -= 16;
			y -= 16;
			this.loadGraphic(AssetPaths.tree1__png, false, 32, 32);
			collisionSprite = new FlxSprite(x + 10, y + 24);
			collisionSprite.makeGraphic(10, 8);
			dropQuantity = 3;
			health = 1.0;
		}
		else if (r == 2)
		{
			y -= 16;
			this.loadGraphic(AssetPaths.tree2__png, false, 16, 32);
			collisionSprite = new FlxSprite(x + 4, y + 24);
			collisionSprite.makeGraphic(6, 9);
			dropQuantity = 2;
			health = 0.8;
		}
		else if (r == 3)
		{
			y -= 16;
			this.loadGraphic(AssetPaths.tree3__png, false, 16, 32);
			collisionSprite = new FlxSprite(x + 4, y + 24);
			collisionSprite.makeGraphic(6, 9);
			dropQuantity = 2;
			health = 0.8;
		}
		else if (r == 4)
		{
			
			this.loadGraphic(AssetPaths.tree4__png, false, 16, 16);
			collisionSprite = new FlxSprite(x + 4, y + 12);
			collisionSprite.makeGraphic(8, 4);
			dropQuantity = 1;
			health = 0.6;
		}
		else if (r == 5)
		{
			x -= 24;
			y -= 24;
			this.loadGraphic(AssetPaths.tree5__png, false, 48, 48);
			collisionSprite = new FlxSprite(x + 16, y + 32);
			collisionSprite.makeGraphic(16, 16);
			dropQuantity = 5;
			health = 1.5;
		}
		else if (r == 6)
		{
			x -= 24;
			y -= 24;
			this.loadGraphic(AssetPaths.tree6__png, false, 48, 48);
			collisionSprite = new FlxSprite(x + 16, y + 32);
			collisionSprite.makeGraphic(16, 16);
			dropQuantity = 5;
			health = 1.5;
		}
		
		this.immovable = true;
		this.collisionSprite.immovable = true;
		this.alpha = 0;
	}
	
	override public function destroyMe(state:PlayState) 
	{
		super.destroyMe(state);
		collisionSprite.setPosition( -5000, -5000);
	}
	
	
}