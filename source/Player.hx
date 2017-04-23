package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import flixel.text.FlxText;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using flixel.util.FlxSpriteUtil;

class Player extends FlxSprite
{
    //#################################################################

    var _accelFactor    : Float;

	var _playState      : PlayState;

	var _hitArea        : FlxSprite;
	
	var _facing         : Facing;
	
	
	var dustparticles : MyParticleSystem;
	var dustTime : Float = 0;
	
	var healthMax : Float = 1;
	
	var inInteractionAnim : Float = 0;

	
    public function new(playState: PlayState)
    {
        super();

		loadGraphic(AssetPaths.Hero__png, true, 16, 16);
		animation.add("walk_south", [0, 4, 8,  12], 8);
		animation.add("walk_west",  [1, 5, 9,  13], 8);
		animation.add("walk_north", [2, 6, 10, 14], 8);
		animation.add("walk_east",  [3, 7, 11, 15], 8);
		animation.add("idle", [0]);
		animation.add("stick", [16, 17], 8);
		animation.add("axe", [18, 19], 4);
		animation.add("pick", [20, 21], 4);
		animation.add("fish", [22,23,24,25,26,27], 8);
		animation.play("idle");

		dustparticles = new MyParticleSystem();
		dustparticles.mySize = 500;

		_hitArea = new FlxSprite();
		_hitArea.makeGraphic(16, 16, flixel.util.FlxColor.fromRGB(255, 255, 255, 64));
		_hitArea.alpha = 0;
		_facing = Facing.SOUTH;
		
		_accelFactor = GP.PlayerMovementAcceleration;
		drag         = GP.PlayerMovementDrag;
		maxVelocity  = GP.PlayerMovementMaxVelocity;

		_playState = playState;

		setPosition(8 * GP.TileSize, 2 * GP.TileSize);
		
		health = healthMax = GP.PlayerHealthMaxDefault;
		
		
    }

    //#################################################################

    public override function update(elapsed: Float)
    {
        super.update(elapsed);
		
		keepPlayerOnMap();	
		
		dustparticles.update(elapsed);
		
		inInteractionAnim -= elapsed;
		
		switch _facing
		{
			case Facing.EAST:
				_hitArea.setPosition(x + GP.TileSize, y);
				if(inInteractionAnim <= 0)
					animation.play("walk_east", false);
				
				
			case Facing.WEST:
				_hitArea.setPosition(x - GP.TileSize, y);
				if(inInteractionAnim <= 0)
					animation.play("walk_west", false);
				
				
			case Facing.NORTH:
				_hitArea.setPosition(x, y - GP.TileSize);
				if(inInteractionAnim <= 0)
					animation.play("walk_north", false);
				
				
			case Facing.SOUTH:
				_hitArea.setPosition(x, y + GP.TileSize);
				if(inInteractionAnim <= 0)
					animation.play("walk_south", false);
				
			
			case Facing.NORTHEAST:
				_hitArea.setPosition(x + GP.TileSize / 2, y - GP.TileSize / 2);
				if(inInteractionAnim <= 0)
					animation.play("walk_north", false);
				
			case Facing.NORTHWEST:
				_hitArea.setPosition(x - GP.TileSize / 2, y - GP.TileSize / 2);
				if(inInteractionAnim <= 0)
					animation.play("walk_north", false);
				
				
			case Facing.SOUTHEAST:
				_hitArea.setPosition(x + GP.TileSize / 2, y + GP.TileSize / 2);
				if(inInteractionAnim <= 0)
					animation.play("walk_south", false);
			
				
			case Facing.SOUTHWEST:
				_hitArea.setPosition(x - GP.TileSize / 2, y + GP.TileSize / 2);
				if(inInteractionAnim <= 0)
					animation.play("walk_south", false);
				
			
		}

        
		var l : Float = velocity.distanceTo(new FlxPoint());
		if (l <= GP.PlayerMovementMaxVelocity.x / 8 && inInteractionAnim <= 0 )
		{
			animation.play("idle", false);
		}
		else
		{
			CreateDustParticles();
		}
		
		handleInput();
    }

    //#################################################################

    function handleInput()
    {
        var vx : Float = MyInput.xVal * _accelFactor;
		var vy : Float = MyInput.yVal * _accelFactor;
		var l : Float = Math.sqrt(vx * vx + vy * vy);

		if (l >= 25)
		{

			if(vx > 0)
			{
				_facing = Facing.EAST;
				if(vy > 0) _facing = Facing.SOUTHEAST;
				if(vy < 0) _facing = Facing.NORTHEAST;
			}
			else if(vx < 0)
			{
				_facing = Facing.WEST;
				if(vy > 0) _facing = Facing.SOUTHWEST;
				if(vy < 0) _facing = Facing.NORTHWEST;
			}
			else
			{
				if(vy > 0) _facing = Facing.SOUTH;
				if(vy < 0) _facing = Facing.NORTH;
			}
		}
		acceleration.set(vx, vy);
		
		
		handleInteraction();
    }



	function CreateDustParticles():Void 
	{
		dustTime -= FlxG.elapsed;
		if (dustTime <= 0)
		{
			dustTime += 0.25;
			dustparticles.Spawn( 4,
			function (s : FlxSprite) : Void
			{
				s.alive = true;
				var T : Float = 1.25;
				s.setPosition(x + GP.rng.float(0, this.width) , y + height + GP.rng.float( -2, 2) );
				s.alpha = GP.rng.float(0.125, 0.35);
				FlxTween.tween(s, { alpha:0 }, T, { onComplete: function(t:FlxTween) : Void { s.alive = false; } } );
				var v : Float = GP.rng.float(0.75, 1.0);
				s.scale.set(v, v);
				FlxTween.tween(s.scale, { x: 2.5, y:2.5 }, T);
			},
			function(s:FlxSprite) : Void 
			{
				s.makeGraphic(5, 5, FlxColor.TRANSPARENT);
				s.drawCircle(3, 3, 2, GP.ColorDustParticles);
			});
		}
	}
	
	function keepPlayerOnMap():Void 
	{
		if (x < 0) x = 0;
		if (x > GP.TileSize * GP.WorldSizeInTiles - this.width) x = GP.TileSize * GP.WorldSizeInTiles - this.width;
		if (y < 0) y = 0;
		if (y > GP.TileSize * GP.WorldSizeInTiles - this.height) y = GP.TileSize * GP.WorldSizeInTiles - this.height;
	}
	
	function handleInteraction():Void 
	{
		if (inInteractionAnim < 0)
		{
			if (MyInput.InteractButtonPressed)
			{
				var r : Rock = _playState._level.getRockInRange(this);
				if (r != null)
				{
					r.Flash(0.2, FlxColor.fromRGB(255, 255, 255, 10));
					this.animation.play("pick", true);
					inInteractionAnim = 0.5;
					r.takeDamage(0.2);
					if (r.x < x) 
					{
						this.scale.set( -1, 1);
						new FlxTimer().start(0.5, function(t) : Void {this.scale.set( 1, 1); } );
					}
					return;
				}
				
				var t : Tree = _playState._level.getTreeInRange(this);
				if (t != null)
				{
					t.Flash(0.2, FlxColor.fromRGB(255, 255, 255, 10));
					this.animation.play("axe", true);
					inInteractionAnim = 0.5;
					t.takeDamage(0.2);
					if (t.x < x) 
					{
						this.scale.set( -1, 1);
						new FlxTimer().start(0.5, function(t) : Void {this.scale.set( 1, 1); } );
					}
					return;
				}
				
			}
		}
	}

 
	public override function draw() 
	{
		dustparticles.draw();
		
		super.draw();

		_hitArea.draw();
	}

    //#################################################################

	public function drawHud()
	{
		
	}

    //#################################################################
	
	
	public function restoreHealth()
	{
		health = healthMax;
	}
}