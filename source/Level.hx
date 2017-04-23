package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
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
	
	public var destroables : FlxTypedGroup<Destroyables>;
	
	private var _state : PlayState;
	
	private var resources : FlxTypedGroup<Resource>;
	private var placeables : FlxTypedGroup<Placeable>;
	
	public function new(state:PlayState) 
	{
		super();
		_state = state;
		
		tiles = new FlxTypedGroup<Tile>();
		collisionTiles = new FlxSpriteGroup();
		destroables = new FlxTypedGroup<Destroyables>();
		placeables = new FlxTypedGroup<Placeable>();
		CreateLevel();
		
		resources = new FlxTypedGroup<Resource>();
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
		
		CreateObjects();
		
		trace("Water: " + watercount);
		trace("Stone: " + stonecount);
		trace("Grass: " + grasscount);
		
		CreateAutoTiles();
		
		CreateCollisionTiles();
	}
	
	function CreateAutoTiles() 
	{
		for (i in 0... GP.WorldSizeInTiles)
		for (j in 0... GP.WorldSizeInTiles)
		{
			var t = getTileAtIntPosition(i, j);
			if (t.type == TileType.WATER ||t.type == TileType.STONE )
			{
				var tlt : Tile = getTileAtIntPositionUnsafe(i-1, j - 1);
				var tct : Tile = getTileAtIntPositionUnsafe(i,   j - 1);
				var trt : Tile = getTileAtIntPositionUnsafe(i+1, j - 1);
				
				var tlc : Tile = getTileAtIntPositionUnsafe(i - 1, j + 0);
				var tcc : Tile = getTileAtIntPositionUnsafe(i, j );
				var trc : Tile = getTileAtIntPositionUnsafe(i+1, j + 0);
				
				var tlb : Tile = getTileAtIntPositionUnsafe(i-1, j + 1);
				var tcb : Tile = getTileAtIntPositionUnsafe(i,   j + 1);
				var trb : Tile = getTileAtIntPositionUnsafe(i+1, j + 1);
				
				if (tlt != null && tlt.type != t.type)
				{
					t.addAutoTileID(1);
				}
				if (tct != null && tct.type != t.type)
				{
					t.addAutoTileID(2);
				}
				if (trt != null && trt.type != t.type)
				{
					t.addAutoTileID(4);
				}
				if (tlc != null && tlc.type != t.type)
				{
					t.addAutoTileID(8);
				}
				if (tcc != null && tcc.type != t.type)
				{
					t.addAutoTileID(16);
				}
				if (trc != null && trc.type != t.type)
				{
					t.addAutoTileID(32);
				}
				if (tlb != null && tlb.type != t.type)
				{
					t.addAutoTileID(64);
				}
				if (tcb != null && tcb.type != t.type)
				{
					t.addAutoTileID(128);
				}
				if (trb != null && trb.type != t.type)
				{
					t.addAutoTileID(256);
				}
				
				t.SelectAutoTile();
			}
		}
	}
	
	public function getDestroyableInRange(p : Player) : Destroyables
	{
		for (d in destroables)
		{
			var dx: Float = d.x  - p.x - 8;
			if (dx > GP.TileSize * 2) continue;
			
			var dy: Float = d.y - p.y - 8;
			if (dy > GP.TileSize * 2) continue;
			
			var l : Float = dx * dx  + dy * dy;
			if (l < GP.TileSize * GP.TileSize * 1.4 * 1.4)
			{
				return d;
			}
		}
		return null;
	}
	
	public function getPlaceableInRange(pl : Player) : Placeable
	{
		for (p in placeables)
		{
			var dx: Float = p.x  - pl.x - 8;
			if (dx > GP.TileSize * 2) continue;
			
			var dy: Float = p.y - pl.y - 8;
			if (dy > GP.TileSize * 2) continue;
			
			var l : Float = dx * dx  + dy * dy;
			if (l < GP.TileSize * GP.TileSize * 1.4 * 1.4)
			{
				return p;
			}
		}
		return null;
	}
	
	public function ResourceMagnet()
	{
		var p : Player = _state._player;
		for (r in resources)
		{
			var dx: Float = r.x - p.x - 8;
			if (dx > GP.PlayerMagnetRange) continue;
			
			var dy: Float = r.y - p.y - 8;
			if (dy > GP.PlayerMagnetRange) continue;
			
			var l : Float = dx * dx  + dy * dy;
			
			if (l < GP.TileSize * GP.TileSize * 0.25)
			{
				r.velocity.set();
				// touching
				if (_state._inventory.hasFreeSlot(r))
				{
					r.alive = false;
					_state._inventory.pickupItem(r);
				}
			}
			
			if (l < GP.PlayerMagnetRange * GP.PlayerMagnetRange)
			{
				l = Math.sqrt(l);
				
				r.velocity.set( -dx/l * 30, -dy/l*30);
			}
			
		}
	}
	
	function SpawnPostionOnMap () : FlxPoint
	{
		return new FlxPoint(FlxG.random.float(0, GP.WorldSizeInTiles * GP.TileSize), FlxG.random.float(0, GP.WorldSizeInTiles * GP.TileSize));
	}
	
	function CreateObjects() 
	{
		CreateRocks();
		CreateTrees();
		CreateShrubs();
		
		// sort destroyables for correct drawing order
		destroables.members.sort(function(a, b) : Int {
			if (a.y < b.y) return -1;
			else if (a.y > b.y ) return 1;
			else return 0;
		});
	}
	
	function CreateRocks() 
	{
		while(true)
		{	
			if (destroables.length >= GP.WorldRockCount)
			{
				break;
			}
			
			var ix : Int = FlxG.random.int(0, GP.WorldSizeInTiles - 1);
			var iy : Int = FlxG.random.int(0, GP.WorldSizeInTiles - 1);
			
			var tile : Tile = getTileAtIntPosition(ix, iy);
			if (tile == null) continue;
			if (tile.type == TileType.STONE)
			{
				var r : Rock = new Rock(ix * GP.TileSize , iy * GP.TileSize);
				destroables.add(r);
				collisionTiles.add(r);
			}
		}
	}
	
	function CreateTrees() 
	{
		while(true)
		{	
			if (destroables.length - GP.WorldRockCount >= GP.WorldWoodCount)
			{
				break;
			}
			
			var ix : Int = FlxG.random.int(0, GP.WorldSizeInTiles - 1);
			var iy : Int = FlxG.random.int(0, GP.WorldSizeInTiles - 1);
			
			var tile : Tile = getTileAtIntPosition(ix, iy);
			if (tile == null) continue;
			if (tile.type == TileType.GRASS)
			{
				var t : Tree = new Tree((ix+0.5) * GP.TileSize, (iy+0.5) * GP.TileSize);
				destroables.add(t);
				collisionTiles.add(t.collisionSprite);
			}
		}
		
	}
	
	function CreateShrubs() 
	{
		while(true)
		{	
			if (destroables.length - GP.WorldRockCount - GP.WorldWoodCount >= GP.WorldShrubCount)
			{
				break;
			}
			
			var ix : Int = FlxG.random.int(0, GP.WorldSizeInTiles - 1);
			var iy : Int = FlxG.random.int(0, GP.WorldSizeInTiles - 1);
			
			var tile : Tile = getTileAtIntPosition(ix, iy);
			if (tile == null) continue;
			if (tile.type == TileType.GRASS)
			{
				var t : Shrub = new Shrub((ix) * GP.TileSize, (iy) * GP.TileSize);
				destroables.add(t);
				collisionTiles.add(t);
			}
		}
		
	}
	
	public function getTileAtPosition(X : Float, Y : Float) : Tile
	{
		if (X < 0 || X > GP.TileSize * (GP.WorldSizeInTiles + 1)) 
			throw ("Error: Cannot get Tile at position : " + Std.string(X) + " " + Std.string(Y));
		if (Y < 0 || Y > GP.TileSize * (GP.WorldSizeInTiles + 1)) 
			throw ("Error: Cannot get Tile at position : " + Std.string(X) + " " + Std.string(Y));
			
		var ix : Int = Std.int(X / GP.TileSize);
		var iy : Int = Std.int(Y / GP.TileSize);
		
		var idx = iy + GP.WorldSizeInTiles * ix;
		
		return tiles.members[idx];
	}
	
	public function getTileAtIntPosition(X : Int, Y : Int) : Tile
	{
		if (X < 0 || X >= (GP.WorldSizeInTiles)) 
			throw ("Error: Cannot get Tile at position : " + Std.string(X) + " " + Std.string(Y));
		if (Y < 0 || Y >= GP.TileSize * (GP.WorldSizeInTiles)) 
			throw ("Error: Cannot get Tile at position : " + Std.string(X) + " " + Std.string(Y));
			
		
		var idx = Y + GP.WorldSizeInTiles * X;
		
		return tiles.members[idx];
	}
	
	public function getTileAtIntPositionUnsafe(X : Int, Y : Int) : Tile
	{
		if (X < 0 || X >= (GP.WorldSizeInTiles)) 
			return null;
		if (Y < 0 || Y >= GP.TileSize * (GP.WorldSizeInTiles)) 
			return null;
			
		
		var idx = Y + GP.WorldSizeInTiles * X;
		
		return tiles.members[idx];
	}
	
	function CreateCollisionTiles() 
	{
		//collisionTiles.clear();
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
		resources.draw();
		placeables.draw();

	}
	
	public function drawAbovePlayer()
	{
		destroables.draw();
	}
	
	
	public override function update (elapsed : Float)
	{
		cleanUp();
		super.update(elapsed);
		tiles.update(elapsed);
		collisionTiles.update(elapsed);
		destroables.update(elapsed);
		resources.update(elapsed);
		ResourceMagnet();
		placeables.update(elapsed);
		for (p in placeables)
		{
			p.ApplySourroundingEffect(_state._player);
		}
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
		
		for (t in destroables)
		{
			if (t.visited) continue;
			var dx : Float = t.x - p.x;
			if (dx > GP.PlayerViewRange * 1.5) continue;
			
			var dy : Float = t.y - p.y;
			if (dy > GP.PlayerViewRange * 1.5) continue;
			
			var l = dx * dx + dy * dy;
			if ( l < GP.PlayerViewRange * GP.PlayerViewRange * 1.0 * 1.0)
			{
				t.visitMe(); 
			}
		}
	}
	
	
	public function dropResourceInLevel(r:Resource)
	{
		if (r != null)
		{
			resources.add(r);
		}
	}
	
	public function addPlaceable(p : Placeable)
	{
		if (p != null)
		{
			trace("add placeable");
			placeables.add(p);
		}
	}
	
	private function cleanUp()
	{
		{
			var tl : FlxTypedGroup<Destroyables> = new FlxTypedGroup<Destroyables>();
			for (t in destroables)
			{
				if (t.alive)
					tl.add(t);
				else
				{
					if (t.destroyMe(_state))
					{
						tl.add(t);
					}
					else
					{
						t.destroy();
					}
					
				}
			}
			destroables = tl;
		}
		
		{
			var il : FlxTypedGroup<Resource> = new FlxTypedGroup<Resource>();
			for (i in resources)
			{
				if (i.alive)
					il.add(i);
			}
			resources = il;
		}
		
		
	}
}