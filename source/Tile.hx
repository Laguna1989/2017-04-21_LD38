package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Tile extends FlxSprite
{
	public var type : TileType;
	public var visited : Bool = false;
	public var blocking : Bool = false;
	
	public function new(t : TileType, xi : Int, yi : Int)
	{
		super();
		type = t;
		
		loadGraphicFromType();
		
		this.setPosition(xi * GP.TileSize, yi * GP.TileSize); 
	}
	
	function loadGraphicFromType() 
	{
		this.loadGraphic(AssetPaths.Tileset__png, true, 16, 16);
		
		if (type == TileType.GRASS)
		{
			this.animation.add("idle", [FlxG.random.int(81, 89, [85])], 1, true);
			//this.makeGraphic(GP.TileSize, GP.TileSize, FlxColor.GREEN);
		}
		else if (type == TileType.WATER)
		{
			//this.makeGraphic(GP.TileSize, GP.TileSize, FlxColor.BLUE);
			this.animation.add("idle", [58], 1, true);
			blocking = true;
		}
		else if (type == TileType.STONE)
		{
			//this.makeGraphic(GP.TileSize, GP.TileSize, FlxColor.GRAY);
			this.animation.add("idle", [FlxG.random.int(0,9)], 1, true);
		}
		this.animation.play("idle");
		this.alpha = 0;
	}
	
	public inline function visitMe()
	{
		alpha = 1;
		visited = true;
	}
	
	override public function draw():Void 
	{
		super.draw();
	}
	
}