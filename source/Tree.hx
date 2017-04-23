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
		toolUsage = 0.025;
		
		var r : Int = FlxG.random.int(1, 6);

		if (r == 1)
		{
			this.loadGraphic(AssetPaths.tree1__png, false, 32, 32);
			this.offset.set(16, 32);
			collisionSprite = new FlxSprite(x -5, y -4);
			collisionSprite.makeGraphic(8, 4);
			dropQuantity = 3;
			health = 1.0;
		}
		else if (r == 2)
		{
			this.loadGraphic(AssetPaths.tree2__png, false, 16, 32);
			collisionSprite = new FlxSprite(x -3, y -4);
			collisionSprite.makeGraphic(6, 4);
			this.offset.set(8, 32);
			dropQuantity = 2;
			health = 0.8;
		}
		else if (r == 3)
		{
			this.loadGraphic(AssetPaths.tree3__png, false, 16, 32);
			collisionSprite = new FlxSprite(x -3, y -4);
			collisionSprite.makeGraphic(6, 4 );
			this.offset.set(8, 32);
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
			this.loadGraphic(AssetPaths.tree5__png, false, 48, 48);
			collisionSprite = new FlxSprite(x -6, y -8);
			collisionSprite.makeGraphic(16, 8);
			this.offset.set(24, 48);
			dropQuantity = 5;
			health = 1.5;
		}
		else if (r == 6)
		{
			this.loadGraphic(AssetPaths.tree6__png, false, 48, 48);
			collisionSprite = new FlxSprite(x -6, y -8);
			collisionSprite.makeGraphic(16, 8);
			this.offset.set(24, 48);
			dropQuantity = 5;
			health = 1.5;
		}
		
		this.immovable = true;
		collisionSprite.updateHitbox();
		this.collisionSprite.immovable = true;
		collisionSprite.alpha = 0.5;
		
		this.alpha = 0;
	}
	
	override public function destroyMe(state:PlayState) : Bool
	{
		collisionSprite.setPosition( -5000, -5000);
		return super.destroyMe(state);
	}
	
	override public function draw ()
	{
		super.draw();
		//collisionSprite.draw();
	}
	
}