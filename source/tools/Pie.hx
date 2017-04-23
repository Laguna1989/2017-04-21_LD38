package;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Pie extends Tool
{

	public function new() 
	{
		super("Pie", "Pie", 1, "assets/images/pie.png");
		toolCanBeUsedWithDestroyable = false;
		toolCanBePlacedInWorld = true;
		toolQuality = 1;
		toolLifeTime = 1;
	}
	public override function clone() : Pie
	{
		return new Pie();
	}
	
	public override function UseTool(p : Player) : Void
	{
		//trace("use food");
		p.Flash(0.2, FlxColor.fromRGB(200, 200, 200, 10));
		p.getHungry( -0.6);
	}
	
}