package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import flixel.text.FlxText;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

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
		animation.add("axe", [18, 19], 8);
		animation.add("pick", [20, 21], 8);
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
		dustparticles.update(elapsed);

		switch _facing
		{
			case Facing.EAST:
				_hitArea.setPosition(x + GP.TileSize, y);
				animation.play("walk_east", false);
				
				
			case Facing.WEST:
				_hitArea.setPosition(x - GP.TileSize, y);
				animation.play("walk_west", false);
				
				
			case Facing.NORTH:
				_hitArea.setPosition(x, y - GP.TileSize);
				animation.play("walk_north", false);
				
				
			case Facing.SOUTH:
				_hitArea.setPosition(x, y + GP.TileSize);
				animation.play("walk_south", false);
				
			
			case Facing.NORTHEAST:
				_hitArea.setPosition(x + GP.TileSize / 2, y - GP.TileSize / 2);
				animation.play("walk_north", false);
				
			case Facing.NORTHWEST:
				_hitArea.setPosition(x - GP.TileSize / 2, y - GP.TileSize / 2);
				animation.play("walk_north", false);
				
				
			case Facing.SOUTHEAST:
				_hitArea.setPosition(x + GP.TileSize / 2, y + GP.TileSize / 2);
				animation.play("walk_south", false);
			
				
			case Facing.SOUTHWEST:
				_hitArea.setPosition(x - GP.TileSize / 2, y + GP.TileSize / 2);
				animation.play("walk_south", false);
				
			
		}

        handleInput();
		var l : Float = velocity.distanceTo(new FlxPoint());
		if (l <= GP.PlayerMovementMaxVelocity.x / 8 )
		{
			animation.play("idle", true);
		}
		else
		{
			CreateDustParticles();
		}
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
    }



	function CreateDustParticles():Void 
	{
		dustTime -= FlxG.elapsed;
		if (dustTime <= 0)
		{
			dustTime += 0.25;
			dustparticles.Spawn( 3,
			function (s : FlxSprite) : Void
			{
				s.alive = true;
				var T : Float = 1.25;
				s.setPosition(x + GP.rng.float(0, this.width) , y + height + GP.rng.float( 0, 1) );
				s.alpha = GP.rng.float(0.125, 0.35);
				FlxTween.tween(s, { alpha:0 }, T, { onComplete: function(t:FlxTween) : Void { s.alive = false; } } );
				var v : Float = GP.rng.float(0.75, 1.0);
				s.scale.set(v, v);
				FlxTween.tween(s.scale, { x: 2.5, y:2.5 }, T);
			},
			function(s:FlxSprite) : Void 
			{
				s.makeGraphic(7, 7, FlxColor.TRANSPARENT);
				s.drawCircle(4, 4, 3, GP.ColorDustParticles);
			});
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