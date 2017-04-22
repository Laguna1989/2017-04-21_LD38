package;

class Item
{
    public var Name : String;
    public var DisplayName : String;
    public var StackSize : Int;
    public var ImageName : String;

    public function new(name : String, displayName : String, stackSize : Int, imageName : String)
    {
        Name = name;
        DisplayName = displayName;
        StackSize = stackSize;
        ImageName = imageName;
    }
}