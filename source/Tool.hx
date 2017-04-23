package;

class Tool extends Item
{
    public var toolQuality : Float = 0;
	public var toolLifeTime : Float = 1;
	
	public function new(name : String, displayName : String, stackSize : Int, imageName : String)
    {
		super(name,  displayName, stackSize, imageName);
        toolQuality = 1;
		toolLifeTime = 1;
    }
	
}