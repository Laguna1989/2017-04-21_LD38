package;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;

class CraftHud extends FlxTypedGroup<FlxSprite>
{
    private var _sprBG : FlxSprite;

    private var _tweenShow : FlxTween;
    private var _tweenHide : FlxTween;

    public var Slots : Array<CraftSlot>;
    public var ResultSlot : CraftSlot;

    private var _craftButton : SpriteButton;
    private var _craftButtonInitialPosition : FlxPoint;
    private var _tweenShowCraftButton : FlxTween;
    private var _tweenHideCraftButton : FlxTween;

    public function new()
    {
        super();

        Slots = new Array<CraftSlot>();

		_sprBG = new FlxSprite();
		_sprBG.loadGraphic(AssetPaths.Itemslots1__png, false, 120, 72);
        _sprBG.scrollFactor.set();
        _sprBG.setPosition(-_sprBG.width, FlxG.height - 80 - 16 - _sprBG.height);
        add(_sprBG);

        var row = -1;
        var maxTiles = 9;
        var tilesPerRow = 3;
        for(i in 0...maxTiles)
        {
            if(i % tilesPerRow == 0) row++;

            var xPos = 8 + (i % tilesPerRow) * GP.TileSize + 4 * (i % tilesPerRow);
            var yPos = _sprBG.y + 8 + row * GP.TileSize + row * 4;
            
            var slot = new CraftSlot(cast xPos, cast yPos, cast _sprBG.width, cast _sprBG.height);
            add(slot);
            Slots.push(slot);
        }

        var xPos = 8 + 3 * GP.TileSize + 2 * 4 + 8;
        var yPos = _sprBG.y + 8 + GP.TileSize + 4;

        _craftButton = new SpriteButton(xPos - _sprBG.width, yPos, AssetPaths.CraftButton__png, craft);
        _craftButton.scrollFactor.set();
        _craftButtonInitialPosition = new FlxPoint(xPos, yPos);
        add(_craftButton);

        ResultSlot = new CraftSlot(cast xPos + 24, cast yPos, cast _sprBG.width, cast _sprBG.height);
        add(ResultSlot);
    }
    
    private function craft() : Void
    {
        var items : Array<Item> = new Array<Item>();

        for(slot in Slots)
        {
            items.push(slot.Item);
        }
		
        var newItem = CraftManager.craft(items);
        //trace("newItem finished");
		if(newItem != null)
        {
            // Return if there's already a
            // different item in the result slot
            if(ResultSlot.Item != null && newItem.Result.Name != ResultSlot.Item.Name) return;

            // Return if there's the same item but
            // crafting would exceed the stack size
            if(ResultSlot.Item != null && ResultSlot.Quantity + newItem.Quantity > ResultSlot.Item.StackSize) return;

			//trace("remove Items from Slots");
            for(slot in Slots)
            {
                if(slot.Item == null) continue;
                
                slot.Quantity--;
                if(slot.Quantity == 0) slot.Item = null;
            }
			//trace("remove Items done");
			//trace("start Clone");
			if (newItem.Result == null) throw "Recipe Result is null";
            ResultSlot.Item = newItem.Result.clone();
            ResultSlot.Item.animation.play("anim0");
            ResultSlot.Quantity += newItem.Quantity;
        }
		//trace("finished");
		if (Std.is(ResultSlot.Item, Tool))
		{
			var t : Tool = cast ResultSlot.Item;
			if (t.toolExtendsWorkBench)
			{
				trace("extended");
				CraftManager.extended = true;
				ResultSlot.Item = null;
				ResultSlot.Quantity = 0;
			}
		}
    }

    public function show() : Void
    {
        if(_tweenHide != null) _tweenHide.cancel();
        _tweenShow = FlxTween.tween(_sprBG, { x : 0 }, 0.25);

        for(slot in Slots)
        {
            slot.show();
        }
        ResultSlot.show();

        if(_tweenHideCraftButton != null) _tweenHideCraftButton.cancel();
        _tweenShowCraftButton = FlxTween.tween(_craftButton, { x: _craftButtonInitialPosition.x }, 0.25);
    }

    public function hide() : Void
    {
        if(_tweenShow != null) _tweenShow.cancel();
        _tweenHide = FlxTween.tween(_sprBG, { x : -_sprBG.width }, 0.25);

        for(slot in Slots)
        {
            slot.hide();
        }
        ResultSlot.hide();

        if(_tweenShowCraftButton != null) _tweenShowCraftButton.cancel();
        _tweenHideCraftButton = FlxTween.tween(_craftButton, { x: _craftButtonInitialPosition.x - _sprBG.width }, 0.25);
    }
}