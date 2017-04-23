package;
import flixel.FlxSprite;

class Item extends FlxSprite
{
    public var Name : String;
    public var DisplayName : String;
    public var StackSize : Int;
    public var ImageName : String;

    public function new(name : String, displayName : String, stackSize : Int, imageName : String)
    {
		super();
        Name = name;
        DisplayName = displayName;
        StackSize = stackSize;
        ImageName = imageName;
    }
	
	public override function clone () : Item
	{
		return new Item(Name, DisplayName, StackSize, ImageName);
	}
}