package;

/**
 * ...
 * @author 
 */
class Oven extends Tool
{

	public function new() 
	{
		super("Oven", "Oven", 1, "assets/images/Oven_Icon.png");
		toolCanBeUsedWithDestroyable = false;
		toolCanBePlacedInWorld = false;
		toolExtendsWorkBench = true;
		toolQuality = 1;
		toolLifeTime = 1;
	}
	public override function clone() : Oven
	{
		//trace("clone oven");
		return new Oven();
	}
	
	public override function UseTool(p : Player) : Void
	{
	}
	
}