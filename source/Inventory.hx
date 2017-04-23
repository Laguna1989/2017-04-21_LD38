package;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;

class Inventory extends FlxTypedGroup<FlxSprite>
{
    private var _sprBG : FlxSprite;

    private var _tweenShow : FlxTween;
    private var _tweenHide : FlxTween;

    public var Slots : Array<InventorySlot>;
	
	

    public function new()
    {
        super();

        Slots = new Array<InventorySlot>();

        var backgroundColor = FlxColor.fromRGB(200, 200, 200, 255);
        _sprBG = new FlxSprite();
		//_sprBG.makeGraphic(FlxG.width - 20, 80, backgroundColor);
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
                trace(slot.Quantity);
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
        _tweenShow = FlxTween.tween(_sprBG, { y : FlxG.height - _sprBG.height }, 0.25);

        for(slot in Slots)
        {
            slot.show();
        }
    }

    public function hide() : Void
    {
        if(_tweenShow != null) _tweenShow.cancel();
        _tweenHide = FlxTween.tween(_sprBG, { y : FlxG.height }, 0.25);

        for(slot in Slots)
        {
            slot.hide();
        }
    }
	
	public function getActiveTool() : Item
	{
		return null;
	}
}