package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import ItemManager;
import CraftManager;
import Resource;

class PlayState extends FlxState
{
	public var _level : Level;
	public var _player : Player;
	override public function create():Void
	{
		super.create();

		ItemManager.init();
		CraftManager.init();

		var arr = new Array<Item>();
		arr.push(ItemManager.getItem("Stone"));
		arr.push(ItemManager.getItem("Stone"));
		arr.push(ItemManager.getItem("Stone"));
		arr.push(null);
		arr.push(ItemManager.getItem("Wood"));
		arr.push(null);
		arr.push(null);
		arr.push(ItemManager.getItem("Wood"));
		arr.push(null);
		trace(CraftManager.craft(arr));
		
		_level = new Level();
		
		
		_player = new Player(this);
		
		FlxG.camera.follow(_player);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);	
		MyInput.update();
		
		_level.update(elapsed);
		_level.updateVisibility(_player);
		_player.update(elapsed);
		
		FlxG.collide(_player, _level.collisionTiles);
		
	}
	
	override public function draw()
	{
		super.draw();
		_level.draw();
		_player.draw();
	}
}
