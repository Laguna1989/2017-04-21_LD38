package;
import flixel.FlxSprite;
import flixel.FlxG;

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

        loadGraphic(imageName, true, 16, 16);
        trace(name, imageName);
        var numberOfAnimations = Std.int(pixels.width / 16);
        for(i in 0...numberOfAnimations)
        {
            animation.add("anim" + i, [i], 1, false);
        }

        animation.play("anim" + FlxG.random.int(0, numberOfAnimations - 1));
    }

    public override function toString()
    {
        return "Name: " + Name;
    }
	
	public override function clone () : Item
	{
		
		var i : Item = new Item(Name, DisplayName, StackSize, ImageName);
		i.loadGraphicFromSprite(this);
		
		return i ;
	}
}