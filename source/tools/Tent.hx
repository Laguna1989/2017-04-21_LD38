package;
import flixel.FlxG;
import flixel.system.FlxSound;


/**
 * ...
 * @author 
 */
class Tent extends Tool
{

	private var _snd : FlxSound;
	public function new() 
	{
		super("Tent", "Tent", 1, "assets/images/Tent_Icon.png");
		toolCanBeUsedWithDestroyable = false;
		toolCanBePlacedInWorld = true;
		toolQuality = 1;
		toolLifeTime = 1;
		
		_snd = FlxG.sound.load(AssetPaths.heal__ogg, 0.5);
	}
	public override function clone() : Tent
	{
		return new Tent();
	}
	
	public override function UseTool(p : Player) : Void
	{
		//trace("place tent");
		var t : PlaceableTent = new PlaceableTent(p.x + 16, p.y);
		p._state._level.addPlaceable(t);
		
		_snd.play();
		
		
		
	}
	
}