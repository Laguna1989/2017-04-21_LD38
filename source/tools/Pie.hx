package;
import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Pie extends Tool
{
	private var _snd : FlxSound;
	public function new() 
	{
		super("Pie", "Pie", 3, "assets/images/pie.png");
		toolCanBeUsedWithDestroyable = false;
		toolCanBePlacedInWorld = true;
		toolQuality = 1;
		toolLifeTime = 1;
		_snd = FlxG.sound.load(AssetPaths.heal__ogg, 0.5);
	}
	public override function clone() : Pie
	{
		return new Pie();
	}
	
	public override function UseTool(p : Player) : Void
	{
		//trace("use food");
		p.Flash(0.2, FlxColor.fromRGB(200, 200, 200, 10));
		
		_snd.play();
		p.getHungry( -0.6);
	}
	
}