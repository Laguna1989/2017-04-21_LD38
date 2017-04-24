package;

class IronPickaxe extends Tool
{
    public function new()
    {
        super("IronPickaxe", "Iron Pickaxe", 1, AssetPaths.IronPickaxe__png);
		toolCanBeUsedWithDestroyable = true;
		toolCanBePlacedInWorld = false;
		toolQuality = 1;
		toolLifeTime = 1;
    }
	public override function clone() : IronPickaxe
    {
       return new IronPickaxe();
    }
}