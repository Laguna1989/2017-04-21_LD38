package;

class StonePickaxe extends Tool
{
    public function new()
    {
        super("StonePickaxe", "Stone Pickaxe", 1, "assets/images/picaxe_icon.png");
		toolCanBeUsedWithDestroyable = true;
		toolCanBePlacedInWorld = false;
		toolQuality = 1;
		toolLifeTime = 1;
    }
}