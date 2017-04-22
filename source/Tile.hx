package;
import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Tile extends FlxSprite
{
	public var type : TileType;
	
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
		}
		else if (type == TileType.WATER)
		{
			this.makeGraphic(GP.TileSize, GP.TileSize, FlxColor.GRAY);
		}
	}
	
}