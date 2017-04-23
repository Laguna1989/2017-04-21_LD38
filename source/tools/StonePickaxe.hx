package;

class StonePickaxe extends Tool
{
    public function new()
    {
        super("StonePickaxe", "Stone Pickaxe", 1, "assets/images/dummy.png");
		toolCanBeUsedForChopping = true;
		toolQuality = 1;
		toolLifeTime = 1;
		
    }
}