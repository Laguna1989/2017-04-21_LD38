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
    public static var PlayerMovementMaxVelocity  (default, null) : FlxPoint = new FlxPoint(95, 95);
    public static var PlayerMovementDashCooldown  : Float    = 1.0;
	public static var PlayerMovementMaxDashLength : Float    = 40.0;
	public static var PlayerHealthMaxDefault      : Float    = 1.0;
	
	static public var ColorDustParticles          : FlxColor = FlxColor.fromRGB(150,150, 150);
	static public var WorldSizeInTiles			  : Int = 64;
	static public var WorldWaterLevel			  : Float = 0.23;
	static public var WorldStoneLevel			  : Float = 0.8;
	static public var WorldLengthScale  		  : Float = 0.2;
	static public var PlayerViewRange			  : Float = 4* GP.TileSize;

    
}