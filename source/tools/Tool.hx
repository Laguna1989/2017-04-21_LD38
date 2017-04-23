package;

class Tool extends Item
{
    public var toolQuality : Float = 0;
	public var toolLifeTime : Float = 1;
	
	public var toolCanBeUsedWithDestroyable : Bool = false;
	public var toolCanBePlacedInWorld : Bool = false;
	
	public function new(name : String, displayName : String, stackSize : Int, imageName : String)
    {
		super(name,  displayName, stackSize, imageName);
        toolQuality = 1;
		toolLifeTime = 1;
    }
	
	public override function clone() : Tool
	{
		var t : Tool = new Tool(Name, DisplayName, StackSize, ImageName);
		t.toolCanBePlacedInWorld = toolCanBePlacedInWorld;
		t.toolCanBeUsedWithDestroyable = toolCanBeUsedWithDestroyable;
		return t;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		//trace("tool update");
		if (toolLifeTime <= 0)
		{
			trace("item destroyed 1");
			alive = false;
		}
	}
	
	public function UseTool(p : Player) : Void
	{
		
	}
	
}