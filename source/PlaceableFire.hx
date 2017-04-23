package;

/**
 * ...
 * @author 
 */
class PlaceableFire extends Placeable
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
	}
	
	public function doAppplySourroundingEffect(p : Player)
	{
		p.Warmth = 1.0;
	}
	
}