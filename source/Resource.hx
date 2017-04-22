package;

class Resource extends Item
{
    public function new(name : String, displayName : String, stackSize : Int, imageName : String)
    {
        super(name, displayName, stackSize, imageName);
    }
	
	public override function clone () : Resource
	{
		return new Resource(Name, DisplayName, StackSize, ImageName);
	}
}