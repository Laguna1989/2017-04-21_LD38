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

	public var _state      : PlayState;

	var _facing         : Facing;
	
	var dustparticles : MyParticleSystem;
	var dustTime : Float = 0;
	
	var healthMax : Float = 1;
	
	var inInteractionAnim : Float = 0;

	public var Exhaustion : Float;
	public var Hunger     : Float;
	public var Warmth     : Float;

	private var _exhaustionBar : HudBar;
	private var _hungerBar     : HudBar;
	private var _warmthBar     : HudBar;

	private var _exhaustionTimer : Float;
	private var _hungerTimer     : Float;
	private var _warmthTimer     : Float;
	
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

		_facing = Facing.SOUTH;
		
		_accelFactor = GP.PlayerMovementAcceleration;
		drag         = GP.PlayerMovementDrag;
		maxVelocity  = GP.PlayerMovementMaxVelocity;

		_state = playState;

		setPosition(8 * GP.TileSize, 2 * GP.TileSize);
		
		health = healthMax = GP.PlayerHealthMaxDefault;

		Exhaustion = 0.9;
		Hunger     = 0.55;
		Warmth     = 0.8;
		
		var barWidth = 60;
		_exhaustionBar = new HudBar(FlxG.width - barWidth,  0, barWidth, 10, false, FlxColor.GRAY );
		_hungerBar     = new HudBar(FlxG.width - barWidth, 10, barWidth, 10, false, FlxColor.GREEN);
		_warmthBar     = new HudBar(FlxG.width - barWidth, 20, barWidth, 10, false, FlxColor.RED  );

		_exhaustionTimer = GP.ExhaustionTimer;
		_hungerTimer = GP.HungerTimer;
		_warmthTimer = GP.WarmthTimer;
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
				if(inInteractionAnim <= 0)
					animation.play("walk_east", false);
				
				
			case Facing.WEST:
				if(inInteractionAnim <= 0)
					animation.play("walk_west", false);
				
				
			case Facing.NORTH:
				if(inInteractionAnim <= 0)
					animation.play("walk_north", false);
				
				
			case Facing.SOUTH:
				if(inInteractionAnim <= 0)
					animation.play("walk_south", false);
				
			
			case Facing.NORTHEAST:
				if(inInteractionAnim <= 0)
					animation.play("walk_north", false);
				
			case Facing.NORTHWEST:
				if(inInteractionAnim <= 0)
					animation.play("walk_north", false);
				
				
			case Facing.SOUTHEAST:
				if(inInteractionAnim <= 0)
					animation.play("walk_south", false);
			
				
			case Facing.SOUTHWEST:
				if(inInteractionAnim <= 0)
					animation.play("walk_south", false);
				
			
		}

        
		var l : Float = velocity.distanceTo(new FlxPoint());
		if (l <= GP.PlayerMovementMaxVelocity.x / 8)
		{
			if( inInteractionAnim <= 0 )
				animation.play("idle", false);
		}
		else
		{
			CreateDustParticles();
		}
		
		handleInput();

		_exhaustionTimer -= elapsed;
		if(_exhaustionTimer <= 0.0)
		{
			_exhaustionTimer += GP.ExhaustionTimer;
			getTired(GP.ExhaustionTickFactor);
		}

		_hungerTimer -= elapsed;
		if(_hungerTimer <= 0.0)
		{
			_hungerTimer += GP.HungerTimer;
			getHungry(GP.HungerTickFactor);
		}

		_warmthTimer -= elapsed;
		if(_warmthTimer <= 0.0)
		{
			_warmthTimer += GP.WarmthTimer;
			getCold(GP.WarmthTickFactor);
		}

		_exhaustionBar.health = Exhaustion;
		_exhaustionBar.update(elapsed);

		_hungerBar.health = Hunger;
		_hungerBar.update(elapsed);

		_warmthBar.health = Warmth;
		_warmthBar.update(elapsed);
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
			dustparticles.Spawn( 5,
			function (s : FlxSprite) : Void
			{
				s.alive = true;
				var T : Float = 0.85;
				s.setPosition(x + GP.rng.float(0, this.width) , y + height + GP.rng.float( -4, 0) );
				s.alpha = GP.rng.float(0.125, 0.35);
				FlxTween.tween(s, { alpha:0 }, T, { onComplete: function(t:FlxTween) : Void { s.alive = false; } } );
				var v : Float = GP.rng.float(0.75, 1.2);
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
				var i : Item  = _state._inventory.getActiveTool();
				
				if ( i == null)
				{
					interactWithWorld(null);
				}
				else if (Std.is(i, Tool))
				{
					trace("u have tool");
					var t : Tool = cast i;
					if (t.toolCanBeUsedWithDestroyable)
					{
						//trace("destroyable");
						interactWithWorld(t);
					}
					else if (t.toolCanBePlacedInWorld)
					{
						trace("place out");
						PlaceItemInWorld(t);
					}
				}
				else
				{
					interactWithWorld(null);	// chop with stupid item
				}
			}
		}
	}
	
	function PlaceItemInWorld(t:Tool) 
	{
		if (t == null || !t.toolCanBePlacedInWorld) return;
		
		trace("placeItem");
		_state._inventory.ActiveSlot.Item = null;
		_state._inventory.ActiveSlot.Quantity = 0;
		
		t.UseTool(this);

	}
	
	function interactWithWorld(t : Tool):Void 
	{
		InteractWithDestroyables(t);
		InteractWithPlayceables();
	}
	
	function InteractWithPlayceables() 
	{
		var p : Placeable = _state._level.getPlaceableInRange(this);
		if (p == null) return;
		
		p.Use(this);
		
	}
	function InteractWithDestroyables(t : Tool):Void 
	{
		var d : Destroyables = _state._level.getDestroyableInRange(this);
		if (d == null) return;
		
		this.animation.play("pick", true);
		inInteractionAnim = 0.5;
	
		var quality : Float = 0.5;
	
		if (t != null)
		{
			quality = t.toolQuality;
			t.toolLifeTime -= d.toolUsage * 0.75;
		}
		
		d.takeDamage(0.2 * quality);
		getTired((1 - quality) * GP.ExhaustionFactor);
		getHungry((1 - quality) * GP.HungerFactor);
		getCold((1 - quality) * -GP.WarmthFactor);
		
		if (d.x < x) 
		{
			TurnPlayerLeftForInteraction();
		}
	}
	
	private function getTired(amount : Float) : Void
	{
		Exhaustion -= amount;
	}

	private function getHungry(amount : Float) : Void
	{
		Hunger -= amount;
	}

	private function getCold(amount : Float) : Void
	{
		Warmth -= amount;
	}
	
	function TurnPlayerLeftForInteraction():Void 
	{
		this.scale.set( -1, 1);
		new FlxTimer().start(0.5, function(t) : Void {this.scale.set( 1, 1); } );
	}
	
	
 
	public override function draw() 
	{
		dustparticles.draw();
		
		super.draw();
	}

    //#################################################################

	public function drawHud()
	{
		_exhaustionBar.draw();
		_hungerBar.draw();
		_warmthBar.draw();
	}

    //#################################################################
	
	
	public function restoreHealth()
	{
		health = healthMax;
	}
}