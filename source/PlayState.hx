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

	private var _workbench : Workbench;
	public var PlayerIsNearWorkbench : Bool;
	
	private var _draggingItem : Item = null;
	private var _draggingItemQuantity : Int = 0;
	
	override public function create():Void
	{
		super.create();

		ItemManager.init();
		CraftManager.init();
		
		_level = new Level(this);
		
		_player = new Player(this);

		_inventory = new Inventory();
		ShowInventory = false;

		_craftHud = new CraftHud();
		ShowCraftHud  = false;
		
		FlxG.camera.follow(_player);
		FlxG.camera.setScrollBoundsRect(0, 0, GP.TileSize * GP.WorldSizeInTiles, GP.TileSize * GP.WorldSizeInTiles);
		
		
		_flakes = new Flakes(FlxG.camera);
		
		_vignette = new Vignette(FlxG.camera);
		_vignette.scrollFactor.set();

		_workbench = new Workbench(32, 32, this);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);	
		MyInput.update();
		handleInput();
		
		if (_draggingItem != null)
		{
			_draggingItem.setPosition(FlxG.mouse.getScreenPosition().x, FlxG.mouse.getScreenPosition().y);
		}
		
		_level.update(elapsed);
		_level.updateVisibility(_player);
		_player.update(elapsed);
		_inventory.update(elapsed);
		_craftHud.update(elapsed);
		_flakes.update(elapsed);
		_workbench.update(elapsed);
		
		FlxG.collide(_player, _level.collisionTiles);
	}

	private function handleInput()
	{
		InventoryOpenClose();
		
		ItemDragging();
		
	}
	
	function ItemDragging() 
	{
		if (ShowInventory)
		{
			if (FlxG.mouse.justPressed)
			{
				if (_draggingItem == null)
				{
					// pick up item
					for (s in _inventory.Slots)
					{
						pickUpItem(s);
					}
					for (s in _craftHud.Slots)
					{
						pickUpItem(s);
					}
					pickUpItem(_craftHud.ResultSlot);
				}
				else
				{
					// drop Item
					
					// pick up item
					for (s in _inventory.Slots)
					{
						DropItem(s);
					}
					for (s in _craftHud.Slots)
					{
						DropItem(s);
					}
				}
			}
			if (FlxG.mouse.justPressedRight)
			{
				for (s in _inventory.Slots)
				{
					DropItem(s, false);
				}
				for (s in _craftHud.Slots)
				{
					DropItem(s, false);
				}
			}
		}
	}

	function InventoryOpenClose():Void 
	{
		if(MyInput.InventoryButtonJustPressed)
		{
			ShowInventory = !ShowInventory;
			
			if(ShowInventory)
			{
				_inventory.show();
				if(PlayerIsNearWorkbench)
				{
					ShowCraftHud = true;
					_craftHud.show();
				}
			}
			else
			{
				_inventory.hide();
				if(ShowCraftHud)
				{
					ShowCraftHud = false;
					_craftHud.hide();
				}
			}
		}
	
		if(MyInput.InteractButtonJustPressed && PlayerIsNearWorkbench)
		{
			ShowCraftHud = !ShowCraftHud;
	
			if(ShowCraftHud)
			{
				_craftHud.show();
				if(!ShowInventory)
				{
					ShowInventory = true;
					_inventory.show();
				}
			}
			else
			{
				_craftHud.hide();
				if(ShowInventory)
				{
					ShowInventory = false;
					_inventory.hide();
				}
			}
		}
	
		if(ShowCraftHud && !PlayerIsNearWorkbench)
		{
			ShowCraftHud = false;
			_craftHud.hide();
		}
	}
	
	function pickUpItem(s:InventorySlot) : Void
	{
		if (s.Item == null) return;	// cant pickup nothing
			
			if (s.isMouseOver())
			{
				_draggingItem = s.Item;
				_draggingItemQuantity = s.Quantity;
				s.Item = null;
				s.Quantity = 0;
				return;
			}
	}
	function DropItem(s:InventorySlot, full : Bool = true)  : Void
	{
		if (_draggingItem == null) return;
		
		if (s.Item != null && s.Item.Name != _draggingItem.Name) return;	// cant drop if there is anything
			
			if (s.isMouseOver())
			{
				if (full || _draggingItemQuantity < 2)
				{
					s.Item = _draggingItem;
					s.Quantity += _draggingItemQuantity;
					_draggingItem = null;
					_draggingItemQuantity = 0;
				}
				else
				{
					s.Item = _draggingItem.clone();
					s.Item.animation.play("anim0");
					s.Quantity += Std.int(_draggingItemQuantity / 2);
					_draggingItemQuantity =  Std.int(_draggingItemQuantity / 2 + (_draggingItemQuantity % 2));
				}
			}
	}
		
	override public function draw()
	{
		super.draw();
		_level.draw();
		_workbench.draw();
		_player.draw();
		_level.drawAbovePlayer();
		_flakes.draw();
		_vignette.draw();

		_inventory.draw();
		_craftHud.draw();
		
		if (ShowInventory)
		{
			if (_draggingItem != null)
			{
				_draggingItem.draw();
			}
		}
	}
}
