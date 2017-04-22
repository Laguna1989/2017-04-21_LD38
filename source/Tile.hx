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
		if (type == TileType.GRASS)
		{
			this.makeGraphic(GP.TileSize, GP.TileSize, FlxColor.GREEN);
		}
		else if (type == TileType.WATER)
		{
			this.makeGraphic(GP.TileSize, GP.TileSize, FlxColor.BLUE);
			blocking = true;
		}
		else if (type == TileType.STONE)
		{
			this.makeGraphic(GP.TileSize, GP.TileSize, FlxColor.GRAY);
		}
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