package;

/**
 * ...
 * @author 
 */
class PlaceableTent extends Placeable
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
	}
	
	public override function Use(p : Player)
	{
		trace("use tent");
		p.Exhaustion = 1;
	}
	
}