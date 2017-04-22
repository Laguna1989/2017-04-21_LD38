package;

import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;

class CraftSlot extends InventorySlot
{
    public override function new(xPos : Int, yPos : Int, parentWidth : Int, parentHeight : Int)
    {
        super(xPos, yPos, parentWidth, parentHeight);

        setPosition(xPos - parentWidth, yPos);
        _initialPosition = new FlxPoint(xPos, yPos);
        _hidePosition    = new FlxPoint(xPos - parentWidth, yPos);
    }

    public override function show() : Void
    {
        if(_tweenHide != null) _tweenHide.cancel();
        _tweenShow = FlxTween.tween(this, { x : _initialPosition.x }, 0.25);
    }

    public override function hide() : Void
    {
        if(_tweenShow != null) _tweenShow.cancel();
        _tweenHide = FlxTween.tween(this, { x : _hidePosition.x }, 0.25);
    }
}