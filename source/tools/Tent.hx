package;

import flixel.system.debug.interaction.tools.Tool;

/**
 * ...
 * @author 
 */
class Tent extends Tool
{

	public function new() 
	{
		super("Tent", "Tent", 1, "assets/images/dummy.png");
		toolCanBeUsedWithDestroyable = false;
		toolCanBePlacedInWorld = true;
		toolQuality = 1;
		toolLifeTime = 1;
	}
	
}