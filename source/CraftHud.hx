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
    private var _state : PlayState;

    private var _tweenShow : FlxTween;
    private var _tweenHide : FlxTween;

    public var Slots : Array<CraftSlot>;
    public var ResultSlot : CraftSlot;

    private var _craftButton : SpriteButton;
    private var _craftButtonInitialPosition : FlxPoint;
    private var _tweenShowCraftButton : FlxTween;
    private var _tweenHideCraftButton : FlxTween;

    public function new(state : PlayState)
    {
        super();

        _state = state;

        Slots = new Array<CraftSlot>();

        var backgroundColor = FlxColor.fromRGB(200, 200, 200, 255);
        _sprBG = new FlxSprite().makeGraphic(120, 72, backgroundColor);
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
        trace("Crafting!");
    }

    public override function update(elapsed: Float) : Void
    {
        super.update(elapsed);
        handleInput();
    }

    private function handleInput() : Void
    {
        if(MyInput.InteractButtonJustPressed && _state.PlayerIsNearWorkbench)
        {
            _state.ShowCraftHud = !_state.ShowCraftHud;

            if(_state.ShowCraftHud) show();
            else hide();
        }
    }

    public function show() : Void
    {
        _state.ShowCraftHud  = true;
        
        if(_tweenHide != null) _tweenHide.cancel();
        _tweenShow = FlxTween.tween(_sprBG, { x : 0 }, 0.25);

        for(slot in Slots)
        {
            slot.show();
        }
        ResultSlot.show();

        if(_tweenHideCraftButton != null) _tweenHideCraftButton.cancel();
        _tweenShowCraftButton = FlxTween.tween(_craftButton, { x: _craftButtonInitialPosition.x }, 0.25);

        _state._inventory.show();
    }

    public function hide() : Void
    {
        _state.ShowCraftHud  = false;

        if(_tweenShow != null) _tweenShow.cancel();
        _tweenHide = FlxTween.tween(_sprBG, { x : -_sprBG.width }, 0.25);

        for(slot in Slots)
        {
            slot.hide();
        }
        ResultSlot.hide();

        if(_tweenShowCraftButton != null) _tweenShowCraftButton.cancel();
        _tweenHideCraftButton = FlxTween.tween(_craftButton, { x: _craftButtonInitialPosition.x - _sprBG.width }, 0.25);

        _state._inventory.hide();
    }
}