package;
import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Berry extends Tool
{
	private var _snd : FlxSound;
	public function new() 
	{
		super("Berry", "Berry", 8, AssetPaths.berries__png);
		toolCanBeUsedWithDestroyable = false;
		toolCanBePlacedInWorld = true;
		toolQuality = 1;
		toolLifeTime = 1;
		alive = true;
		_snd = FlxG.sound.load(AssetPaths.heal__ogg, 0.5);
	}
	public override function clone() : Berry
	{
		return new Berry();
	}
	
	public override function UseTool(p : Player) : Void
	{
		trace("use food");
		p.Flash(0.2, FlxColor.fromRGB(200, 200, 200, 10));
		p.getHungry( -0.1);
		_snd.play();
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		alive = true;
	}
	
}