package;

import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import hxnoise.Perlin;

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
		
		var perlin : Perlin = new Perlin();
		tiles.clear();
		
		var arr : Array<Float> = new Array < Float>();
		for (i in 0 ... GP.WorldSizeInTiles)
		for (j in 0 ... GP.WorldSizeInTiles)
		{
			var idx = i + GP.WorldSizeInTiles * j;
			var fi : Float = i / 0.2;
			var fj : Float = j / 0.2;
			arr.push(perlin.perlin(fi/GP.WorldSizeInTiles, fj /GP.WorldSizeInTiles, 1));
		}
		
		var min : Float = 1000;
		var max : Float = -1;
		
		for (h in arr)
		{
			min = (h < min) ? h : min;
			max = (h > max) ? h : max;
		}
		trace(min + " " + max);
		
		for ( i in 0...arr.length)
		{
			arr[i] = (arr[i] - min) / (max - min);
			
		}
		
		min = 1000;
		max = -1;
		
		for (h in arr)
		{
			min = (h < min) ? h : min;
			max = (h > max) ? h : max;
		}
		trace(min + " " + max);
		
		var stonecount : Int = 0;
		var watercount : Int = 0;
		var grasscount : Int = 0;
		
		for (i in 0 ... GP.WorldSizeInTiles)
		for (j in 0 ... GP.WorldSizeInTiles)
		{
			
			var idx = i + GP.WorldSizeInTiles * j;
			var h = arr[idx];
			var type : TileType = TileType.GRASS;
			if (h < GP.WorldWaterLevel)
			{
				type = TileType.WATER;
				watercount++;
			}
			else if (h > GP.WorldStoneLevel)
			{
				type = TileType.STONE;
				stonecount++;
			}
			else
			{
				grasscount++;
			}
			
			var t : Tile = new Tile(type, i, j);
			tiles.add(t);
		}
		
		trace("Water: " + watercount);
		trace("Stone: " + stonecount);
		trace("Grass: " + grasscount);
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