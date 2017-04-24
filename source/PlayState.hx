package;

import CraftManager;
import ItemManager;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

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
	
	private var _ending : Bool = false; 
	private var _overlay : FlxSprite;
	
	private var _overlayText : FlxText;
	
	
	
	override public function create():Void
	{
		super.create();

		ItemManager.init();
		CraftManager.init();
		
		_level = new Level(this);
		
		_player = new Player(this);

		_inventory = new Inventory();
		ShowInventory = false;

		_craftHud = new CraftHud(this);
		ShowCraftHud  = false;
		
		FlxG.camera.follow(_player);
		FlxG.camera.setScrollBoundsRect(0, 0, GP.TileSize * GP.WorldSizeInTiles, GP.TileSize * GP.WorldSizeInTiles);
		
		
		_flakes = new Flakes(FlxG.camera);
		
		_vignette = new Vignette(FlxG.camera);
		_vignette.scrollFactor.set();

		_workbench = new Workbench(GP.WorldSizeInTiles /2 * GP.TileSize, GP.WorldSizeInTiles /2 * GP.TileSize, this);

		_inventory.pickupItem(ItemManager.getItem("StonePickaxe").clone());
		
		//for (i in 0...24)
		//{
			//_inventory.pickupItem(ItemManager.getItem("Stone").clone());
		//}
		//for (i in 0...24)
		//{
			//_inventory.pickupItem(ItemManager.getItem("Fibers").clone());
		//}
		//for (i in 0...24)
		//{
			//_inventory.pickupItem(ItemManager.getItem("Wood").clone());
		//}
		//for (i in 0...24)
		//{
			//_inventory.pickupItem(ItemManager.getItem("IronOre").clone());
		//}
		//for (i in 0...24)
		//{
			//_inventory.pickupItem(ItemManager.getItem("CopperOre").clone());
		//}
		//for (i in 0...24)
		//{
			//_inventory.pickupItem(ItemManager.getItem("Coal").clone());
		//}

		FlxG.mouse.visible = false;
		
		_overlay = new FlxSprite(0, 0);
		_overlay.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		_overlay.scrollFactor.set();
		FlxTween.tween(_overlay, { alpha : 0 }, 0.25, { onComplete:function(t) { _ending = false; }} );
		_overlay.alpha = 0;
		
		_overlayText = new FlxText(50, 80, 300, "", 12);
		var t : String = "My escape Pod crashed on this Planet.\nI will name it afer me, @Dean's World@.\n\nI should search for food and shelter!";
		var cf : flixel.text.FlxTextFormat = new flixel.text.FlxTextFormat(FlxColor.fromRGB(200,200,255), true);
		var x1 = new FlxTextFormatMarkerPair(cf, "@");
		_overlayText.applyMarkup(t, [x1]);
		_overlayText.alpha = 1;
		_overlayText.scrollFactor.set();
		_overlayText.color = FlxColor.WHITE;
		_overlayText.borderStyle = FlxTextBorderStyle.OUTLINE;
		_overlayText.borderColor = FlxColor.GRAY;
		FlxTween.tween(_overlayText, { alpha : 0 }, 2.5, { startDelay:6.5 } );
		
		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);	
		//trace(_overlay.alpha, _overlay.color.alpha);
		_overlay.update(elapsed);
		if (!_ending)
		{
			MyInput.update();
			handleInput();
			
			if (_player.alive == false)
			{
				if (!_ending)
				{
					EndGame("You died on Dean's World.");
				}
			}
			
			if (_draggingItem != null)
			{
				_draggingItem.setPosition(
					FlxG.mouse.getScreenPosition().x - GP.TileSize / 2,
					FlxG.mouse.getScreenPosition().y - GP.TileSize / 2
				);
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
	}
	
	public function EndGame(message: String = "") 
	{
		_inventory.hide();
		_craftHud.hide();
		_ending = true;
		_overlay.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK, true);
		//FlxG.camera.fade(FlxColor.BLACK, 1, false );
		FlxTween.tween(_overlay, { alpha : 1 }, 1 );
		_overlayText.text = message;
		FlxTween.tween(_overlayText, {alpha : 1}, 0.5);
		
		new FlxTimer().start(4.5, function(t) { FlxG.switchState(new MenuState()); } );
		
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
					pickUpItem(_inventory.ActiveSlot);
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
					DropItem(_inventory.ActiveSlot);
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
				DropItem(_inventory.ActiveSlot,false);
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

		FlxG.mouse.visible = (ShowInventory || ShowCraftHud) && _draggingItem == null;
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
		if (s.Item != null && s.Quantity == s.Item.StackSize)  return;
		
		
			if (s.isMouseOver())
			{
				if (full || _draggingItemQuantity < 2)
				{
					if (s.Item == null)
					{
						s.Item = _draggingItem;
						s.Quantity = _draggingItemQuantity;
						
						_draggingItem = null;
						_draggingItemQuantity = 0;
					}
					else
					{
						if (s.Item.Name == _draggingItem.Name)
						{
							if (_draggingItemQuantity + s.Quantity > s.Item.StackSize)
							{
								_draggingItemQuantity = _draggingItemQuantity + s.Quantity - s.Item.StackSize;
								s.Quantity = s.Item.StackSize;
							}
							else
							{
								s.Quantity += _draggingItemQuantity;
								
								_draggingItem = null;
								_draggingItemQuantity = 0;
							}
						}
					}
				
				}
				else
				{
					s.Item = _draggingItem.clone();
					s.Item.animation.play("anim0");
					s.Quantity += Std.int(_draggingItemQuantity / 2);
					
					_draggingItemQuantity =  Std.int(_draggingItemQuantity / 2 + (_draggingItemQuantity % 2));
					while (s.Quantity > s.Item.StackSize)
					{
						s.Quantity--;
						_draggingItemQuantity++;
					}
					
					if (_draggingItemQuantity <= 0)
					{
						_draggingItemQuantity = 0;
						_draggingItem = null;
					}
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

		_player.drawHud();

		_inventory.draw();
		_craftHud.draw();
		
		if (ShowInventory)
		{
			if (_draggingItem != null)
			{
				_draggingItem.draw();
			}
			if (_inventory.hasValidTool())
				_inventory._activeToolLifeTime.draw();
		}
		_overlay.draw();
		_overlayText.draw();
	}
}
