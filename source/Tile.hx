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
	
	private var autoTileID : Int = 0;
	
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
			this.animation.add("idle", [FlxG.random.int(0, 8)], 1, true);
			//this.makeGraphic(GP.TileSize, GP.TileSize, FlxColor.GREEN);
		}
		else if (type == TileType.WATER)
		{
			//this.makeGraphic(GP.TileSize, GP.TileSize, FlxColor.BLUE);
			this.animation.add("idle", [22], 1, true);
			blocking = true;
		}
		else if (type == TileType.STONE)
		{
			//this.makeGraphic(GP.TileSize, GP.TileSize, FlxColor.GRAY);
			this.animation.add("idle", [13], 1, true);
		}
		this.animation.play("idle");
		this.alpha = 0;
	}
	
	public function addAutoTileID(id :Int) : Void
	{
		if (type != TileType.WATER && type != TileType.STONE) return;
		autoTileID += id;
		
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
	
	public function SelectAutoTile() 
	{
		if (type != TileType.WATER && type != TileType.STONE) return;
		var animID : Int = (type == TileType.WATER? 18 : 45);
		
		if ( autoTileID == 11 || autoTileID == 15 ||  autoTileID == 75 || autoTileID == 79 )
		{
			animID += 0;
		}
		else if (autoTileID == 3 || autoTileID == 6 || autoTileID == 7)
		{
			animID += 1;
		}
		else if (autoTileID == 39 || autoTileID == 38 || autoTileID == 138 || autoTileID == 139  || autoTileID == 294 || autoTileID == 295)
		{
			animID += 2;
		}
		else if (autoTileID == 9|| autoTileID == 72|| autoTileID == 73)
		{
			animID += 3;
		}
		else if (autoTileID == 0)
		{
			animID += 4;
		}
		else if (autoTileID == 36|| autoTileID == 292)
		{
			animID += 5;
		}
		else if (autoTileID == 200 || autoTileID == 201 ||autoTileID == 456 || autoTileID == 457)
		{
			animID += 6;
		}
		else if (autoTileID == 192|| autoTileID == 384  ||autoTileID == 448)
		{
			animID += 7;
		}
		else if (autoTileID == 420 || autoTileID == 480 || autoTileID == 484)
		{
			animID += 8;
		}
		
		
		
		
		
		else if (autoTileID == 256)
		{
			animID += 9;
		}
		else if (autoTileID == 64)
		{
			animID += 11;
		}
		else if (autoTileID == 4)
		{
			animID += 15;
		}
		else if (autoTileID == 1)
		{
			animID += 17;
		}
		
		
		else if (autoTileID == 203)
		{
			animID += 18;
		}
		else if (autoTileID == 47)
		{
			animID += 19;
		}
		else if (autoTileID == 488 || autoTileID == 489)
		{
			animID += 20;
		}
		else if (autoTileID == 422)
		{
			animID += 21;
		}
		
		
		
		else if (autoTileID == 5)
		{
			animID += 24;
		}
		else if (autoTileID == 65)
		{
			animID += 23;
		}
		else if (autoTileID == 260)
		{
			animID += 22;
		}
		else if (autoTileID == 320 )
		{
			animID += 25;
		}
		
		
		
		else 
		{
			animID += 4;
		}
		
		this.animation.add("autotile", [animID]);
		this.animation.play("autotile");
	}
	
}