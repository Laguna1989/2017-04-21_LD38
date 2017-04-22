package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;

class InventorySlot extends FlxSprite
{
    public var Item : Item;
    public var Quantity : Int;

    private var _initialPosition : FlxPoint;
    private var _hidePosition    : FlxPoint;

    private var _tweenShow : FlxTween;
    private var _tweenHide : FlxTween;

    public override function new(xPos : Int, yPos : Int, parentWidth : Int, parentHeight : Int)
    {
        super();

        Quantity = 0;

        var slotColor = FlxColor.fromRGB(180, 180, 180, 255);
        makeGraphic(GP.TileSize, GP.TileSize, slotColor);
        scrollFactor.set();
        setPosition(xPos, yPos + parentHeight);
        _initialPosition = new FlxPoint(xPos, yPos);
        _hidePosition    = new FlxPoint(xPos, yPos + parentHeight);
    }

    public function show() : Void
    {
        if(_tweenHide != null) _tweenHide.cancel();
        _tweenShow = FlxTween.tween(this, { y : _initialPosition.y }, 0.25);
    }

    public function hide() : Void
    {
        if(_tweenShow != null) _tweenShow.cancel();
        _tweenHide = FlxTween.tween(this, { y : _hidePosition.y }, 0.25);
    }
}