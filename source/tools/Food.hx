package;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Food extends Tool
{

	public function new() 
	{
		super("Food", "Food", 1, "assets/images/bread.png");
		toolCanBeUsedWithDestroyable = false;
		toolCanBePlacedInWorld = true;
		toolQuality = 1;
		toolLifeTime = 1;
	}
	public override function clone() : Food
	{
		return new Food();
	}
	
	public override function UseTool(p : Player) : Void
	{
		//trace("use food");
		p.Flash(0.2, FlxColor.fromRGB(200, 200, 200, 10));
		p.Hunger += 0.5;
		if (p.Hunger > 1) p.Hunger = 1;
	}
	
}