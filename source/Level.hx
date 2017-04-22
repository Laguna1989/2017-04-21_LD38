package;

import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;

/**
 * ...
 * @author 
 */
class Level extends FlxObject
{
	
	public var tiles : FlxTypedGroup<Tile>;

	public function new() 
	{
		super();
		
		tiles = new FlxTypedGroup<Tile>();
		
		CreateLevel();
		
	}
	
	function CreateLevel() 
	{
		tiles.clear();
		
		for (i in 0 ... GP.WorldSizeInTiles)
		for (j in 0 ... GP.WorldSizeInTiles)
		{
			var t : Tile = new Tile(TileType.GRASS, i, j);
			tiles.add(t);
		}
	}
	
	public override function draw ()
	{
		super.draw();
		tiles.draw();
	}
	
	
	public override function update (elapsed : Float)
	{
		super.update(elapsed);
		tiles.update(elapsed);
	}
}