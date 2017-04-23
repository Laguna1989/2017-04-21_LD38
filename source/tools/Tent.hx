package;


/**
 * ...
 * @author 
 */
class Tent extends Tool
{

	public function new() 
	{
		super("Tent", "Tent", 1, "assets/images/dummy.png");
		toolCanBeUsedWithDestroyable = false;
		toolCanBePlacedInWorld = true;
		toolQuality = 1;
		toolLifeTime = 1;
	}
	public override function clone() : Tent
	{
		return new Tent();
	}
	
	public override function UseTool(p : Player) : Void
	{
		trace("place tent");
		var t : PlaceableTent = new PlaceableTent(p.x + 16, p.y);
		p._state._level.addPlaceable(t);
	}
	
}