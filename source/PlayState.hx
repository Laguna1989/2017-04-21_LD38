package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
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
	
	private var _flakes : Flakes;
	private var _vignette : Vignette;
	
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
		FlxG.camera.setScrollBoundsRect(0, 0, GP.TileSize * GP.WorldSizeInTiles, GP.TileSize * GP.WorldSizeInTiles);
		
		
		_flakes = new Flakes(FlxG.camera);
		
		_vignette = new Vignette(FlxG.camera);
		_vignette.scrollFactor.set();
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
		_flakes.update(elapsed);
		
		FlxG.collide(_player, _level.collisionTiles);
	}
	
	override public function draw()
	{
		super.draw();
		_level.draw();
		_player.draw();
		_level.drawAbovePlayer();
		_flakes.draw();
		_vignette.draw();

		_inventory.draw();
		_craftHud.draw();
	}
}
