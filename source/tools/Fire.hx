package;

/**
 * ...
 * @author 
 */
class Fire extends Tool
{

	public function new() 
	{
		super("Fire", "Fire", 1, "assets/images/dummy.png");
		this.loadGraphic(AssetPaths.fire__png, true, 16, 16);
		this.animation.add("idle", [0]);
		this.animation.play("idle");
		toolCanBeUsedWithDestroyable = false;
		toolCanBePlacedInWorld = true;
		toolQuality = 1;
		toolLifeTime = 1;
	}
	public override function clone() : Fire
	{
		return new Fire();
	}
	
	public override function UseTool(p : Player) : Void
	{
		//trace("place fire");
		var t : PlaceableFire = new PlaceableFire(p.x + 16, p.y);
		p._state._level.addPlaceable(t);
	}
	
}