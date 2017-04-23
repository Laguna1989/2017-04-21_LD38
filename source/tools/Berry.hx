package;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Berry extends Tool
{

	public function new() 
	{
		super("Berry", "Berry", 8, "assets/images/berries.png");
		toolCanBeUsedWithDestroyable = false;
		toolCanBePlacedInWorld = true;
		toolQuality = 1;
		toolLifeTime = 1;
	}
	public override function clone() : Berry
	{
		return new Berry();
	}
	
	public override function UseTool(p : Player) : Void
	{
		//trace("use food");
		p.Flash(0.2, FlxColor.fromRGB(200, 200, 200, 10));
		p.Hunger += 0.1;
		if (p.Hunger > 1) p.Hunger = 1;
	}
	
}