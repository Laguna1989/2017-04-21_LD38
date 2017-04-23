package;

import flixel.math.FlxPoint;
import flixel.math.FlxRandom;
import flixel.util.FlxColor;

class GP
{
    // ################################################################
    // # General ######################################################
    // ################################################################
	public static var rng             : FlxRandom = new FlxRandom();
    public static var TileSize        : Int       = 16;

    // ################################################################
    // # Player #######################################################
    // ################################################################
    public static var PlayerMovementAcceleration  : Float    = 500.0;
    public static var PlayerMovementDrag          : FlxPoint = new FlxPoint(2000, 2000);
    public static var PlayerMovementMaxVelocity  (default, null) : FlxPoint = new FlxPoint(65, 65);
    public static var PlayerMovementDashCooldown  : Float    = 1.0;
	public static var PlayerMovementMaxDashLength : Float    = 40.0;
	public static var PlayerHealthMaxDefault      : Float    = 1.0;
	static public var PlayerViewRange			  : Float = 4 * GP.TileSize;
	static public var PlayerMagnetRange			  : Float = 3* GP.TileSize;
	static public var ColorDustParticles          : FlxColor = FlxColor.fromRGB(255, 255, 255);
	static public var ExhaustionFactor            : Float = 0.05;
	static public var HungerFactor                : Float = 0.035;
	static public var WarmthFactor                : Float = 0.005;
	static public var ExhaustionTimer             : Float = 10.0;
	static public var ExhaustionTickFactor        : Float = ExhaustionFactor / 2;
	static public var HungerTimer                 : Float = 5.0;
	static public var HungerTickFactor            : Float = HungerFactor / 2;
	static public var WarmthTimer                 : Float = 5.0;
	static public var WarmthTickFactor            : Float = WarmthFactor / 2;
	
	// ################################################################
    // # World  #######################################################
    // ################################################################	
	static public var WorldSizeInTiles			  : Int = 64;
	static public var WorldWaterLevel			  : Float = 0.25;
	static public var WorldStoneLevel			  : Float = 0.77;
	static public var WorldLengthScale  		  : Float = 0.2;
	static public var WorldWoodCount			  : Int = 60;
	static public var WorldRockCount			  : Int = 80;
	static public var WorldShrubCount			  : Int = 60;
}