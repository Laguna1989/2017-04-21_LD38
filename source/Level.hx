package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxRect;
import hxnoise.Perlin;

/**
 * ...
 * @author 
 */
class Level extends FlxObject
{
	
	public var tiles : FlxTypedGroup<Tile>;
	
	public var collisionTiles : FlxSpriteGroup;
	
	public function new() 
	{
		super();
		
		tiles = new FlxTypedGroup<Tile>();
		collisionTiles = new FlxSpriteGroup();
		CreateLevel();
	}
	
	
	
	function CreateLevel() 
	{
		FlxG.worldBounds.set(0, 0, GP.TileSize * GP.WorldSizeInTiles, GP.TileSize * GP.WorldSizeInTiles);
		
		var perlin : Perlin = new Perlin();
		tiles.clear();
		
		var arr : Array<Float> = new Array < Float>();
		for (i in 0 ... GP.WorldSizeInTiles)
		for (j in 0 ... GP.WorldSizeInTiles)
		{
			var idx = i + GP.WorldSizeInTiles * j;
			var fi : Float = i / GP.WorldLengthScale;
			var fj : Float = j / GP.WorldLengthScale;
			arr.push(perlin.perlin(fi / GP.WorldSizeInTiles, fj / GP.WorldSizeInTiles, 1));
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
		
		CreateCollisionTiles();
	}
	
	function CreateCollisionTiles() 
	{
		for (t in tiles)
		{
			if (t.blocking)
			{
				var s : FlxSprite = new FlxSprite(t.x, t.y);
				s.makeGraphic(GP.TileSize, GP.TileSize);
				s.immovable = true;
				collisionTiles.add(s);
			}
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
		collisionTiles.update(elapsed);
	}
	
	public inline function updateVisibility(p:Player) 
	{
		for (t in tiles)
		{
			if (t.visited) continue;
			var dx : Float = t.x - p.x;
			if (dx > GP.PlayerViewRange) continue;
			
			var dy : Float = t.y - p.y;
			if (dy > GP.PlayerViewRange) continue;
			
			var l = dx * dx + dy * dy;
			if ( l < GP.PlayerViewRange * GP.PlayerViewRange)
			{
				t.visitMe(); 
			}
		}
	}
}