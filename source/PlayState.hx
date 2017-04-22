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
	public var _level  : Level;
	public var _player : Player;

	public var _inventory    : Inventory;
	public var ShowInventory : Bool;

	public var _craftHud    : CraftHud;
	public var ShowCraftHud : Bool;

	override public function create():Void
	{
		super.create();

		ItemManager.init();
		CraftManager.init();
		
		_level = new Level();
		
		_player = new Player(this);

		_inventory = new Inventory(this);
		ShowInventory = false;

		_craftHud = new CraftHud(this);
		ShowCraftHud  = false;
		
		FlxG.camera.follow(_player);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);	
		MyInput.update();
		
		_level.update(elapsed);
		_level.updateVisibility(_player);
		_player.update(elapsed);
		_inventory.update(elapsed);
		_craftHud.update(elapsed);
	}
	
	override public function draw()
	{
		super.draw();
		_level.draw();
		_player.draw();
		_inventory.draw();
		_craftHud.draw();
	}
}
