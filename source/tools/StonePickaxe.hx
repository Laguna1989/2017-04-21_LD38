package;

class StonePickaxe extends Tool
{
    public function new()
    {
        super("StonePickaxe", "Stone Pickaxe", 1, AssetPaths.picaxe_icon__png);
		toolCanBeUsedWithDestroyable = true;
		toolCanBePlacedInWorld = false;
		toolQuality = 0.6;
		toolLifeTime = 1;
    }
	
	public override function clone() : StonePickaxe
    {
       return new StonePickaxe();
    }
}