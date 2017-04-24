package;

/**
 * ...
 * @author 
 */
class SpaceShip extends Tool
{

	public function new() 
	{
		super("SpaceShip", "SpaceShip", 1, "assets/images/dummy.png");
		toolCanBeUsedWithDestroyable = false;
		toolCanBePlacedInWorld = false;
		toolExtendsWorkBench = true;
		toolQuality = 1;
		toolLifeTime = 1;
	}
	public override function clone() : SpaceShip
	{
		//trace("clone oven");
		return new SpaceShip();
	}
	
	public override function UseTool(p : Player) : Void
	{
		p._state.EndGame("I managed to build a Spaceship and escape from Dean's Planet.");
	}
	
}