package;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;
import Tool;

class Inventory extends FlxTypedGroup<FlxSprite>
{
    private var _sprBG : FlxSprite;

    private var _tweenShow : FlxTween;
    private var _tweenHide : FlxTween;

    public var Slots : Array<InventorySlot>;
	public var ActiveSlot : InventorySlot;
	
	public var _activeToolLifeTime : HudBar;
	

    public function new()
    {
        super();

        Slots = new Array<InventorySlot>();

        _sprBG = new FlxSprite();
		_sprBG.loadGraphic(AssetPaths.Itemslots2__png, false, 380, 80);
        _sprBG.scrollFactor.set();
        _sprBG.setPosition(10, FlxG.height);
        add(_sprBG);

        var row = -1;
        var maxTiles = 18;
        var tilesPerRow = 6;
        for(i in 0...maxTiles)
        {
            if(i % tilesPerRow == 0) row++;

            var xPos = _sprBG.x + 8 + (i % tilesPerRow) * GP.TileSize + 4 * (i % tilesPerRow);
            var yPos = FlxG.height - _sprBG.height + 8 + row * GP.TileSize + row * 4;

            var slot = new InventorySlot(cast xPos, cast yPos, cast _sprBG.width, cast _sprBG.height);
            add(slot);
            Slots.push(slot);
        }
		ActiveSlot = new InventorySlot(cast(_sprBG.x + 128), cast( 8 + FlxG.height - _sprBG.height), cast _sprBG.width, cast _sprBG.height);
		add(ActiveSlot);
		
		_activeToolLifeTime = new HudBar(_sprBG.x + 128, 8 + FlxG.height - _sprBG.height - 6, 16, 4, false, FlxColor.WHITE);
		_activeToolLifeTime.scrollFactor.set();
		
		//add(_activeToolLifeTime);
    }

    public function hasFreeSlot(item : Item) : Bool
    {
        for(slot in Slots)
        {
            // Look for empty slots
            // or slots with the same item
            // with less than maximum stack size
            if(slot.Item == null || (item.Name == slot.Item.Name && slot.Quantity < slot.Item.StackSize))
                return true;
        }

        // Inventory must be full
        return false;
    }

    public function pickupItem(item : Item) : Void
    {
        // Look first for stacks to fill up...
        for(slot in Slots)
        {
            if (slot.Item == null) continue;
            if(slot.Item.Name == item.Name && slot.Quantity < slot.Item.StackSize)
            {
                slot.Quantity++;
                return;
            }
        }

        // ... then for empty slots
        for(slot in Slots)
        {
            if(slot.Item == null)
            {
                slot.Item = item;
                slot.Item.animation.play("anim0");
                slot.Item.scrollFactor.set();
                return;
            }
        }
    }

    public function show() : Void
    {
        if(_tweenHide != null) _tweenHide.cancel();
        _tweenShow = FlxTween.tween(_sprBG, { y : FlxG.height - _sprBG.height }, 0.25, { onComplete:function(t) { _activeToolLifeTime.alpha = _activeToolLifeTime._background.alpha = 1; }} );

        for(slot in Slots)
        {
            slot.show();
        }
		ActiveSlot.show();
    }

    public function hide() : Void
    {
        if (_tweenShow != null) _tweenShow.cancel();
		
		_activeToolLifeTime.alpha = _activeToolLifeTime._background.alpha = 0;
		
        _tweenHide = FlxTween.tween(_sprBG, { y : FlxG.height }, 0.25);

        for(slot in Slots)
        {
            slot.hide();
        }
		ActiveSlot.hide();
    }
	
	public function getActiveTool() : Item
	{
		return ActiveSlot.Item;
	}
	
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		//trace("inventory.update");
		handleActiveItem(elapsed);
	}
	
	override public function draw():Void 
	{
		super.draw();
		//_activeToolLifeTime.draw();
	}
	
	public function hasValidTool() : Bool
	{
		return Std.is(ActiveSlot.Item, Tool);
	}
	
	function handleActiveItem(elapsed : Float):Void 
	{
		if (!hasValidTool()) return;
		var t : Tool = cast ActiveSlot.Item;
		
		_activeToolLifeTime.health = (t.toolLifeTime);
		_activeToolLifeTime.update(elapsed);
		
		
		t.update(elapsed);
		
		if (!t.alive)
		{
			trace("item destroyed 2: lt= " + t.toolLifeTime);
			ActiveSlot.Item = null;
			ActiveSlot.Quantity = 0;
		}
		
	}
}