package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Tree extends FlxSprite
{

	public function new() 
	{
		super();
		
		this.makeGraphic(GP.TileSize / 2, GP.TileSize, FlxColor.GREEN);
		
		
	}
	
}