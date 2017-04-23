package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;

class InventorySlot extends FlxSprite
{
    public var Item : Item;
    public var Quantity : Int = 0;

    private var _initialPosition : FlxPoint;
    private var _hidePosition    : FlxPoint;

    private var _quantityText : FlxText;

    private var _tweenShow : FlxTween;
    private var _tweenHide : FlxTween;

    public override function new(xPos : Int, yPos : Int, parentWidth : Int, parentHeight : Int)
    {
        super();

        Quantity = 0;

        _quantityText = new FlxText(xPos, yPos, 0, Std.string(Quantity), 8);
        _quantityText.scrollFactor.set();

        var slotColor = FlxColor.fromRGB(180, 180, 180, 255);
        makeGraphic(GP.TileSize, GP.TileSize, slotColor);
        scrollFactor.set();
        setPosition(xPos, yPos + parentHeight);
        _initialPosition = new FlxPoint(xPos, yPos);
        _hidePosition    = new FlxPoint(xPos, yPos + parentHeight);
    }

    public override function draw()
    {
        //super.draw();

        if(Item != null)
        {
            Item.draw();
            if(Quantity > 1)
            {
                _quantityText.draw();
            }
        }
    }

    public override function update(elapsed : Float)
    {
        super.update(elapsed);

        _quantityText.update(elapsed);
        _quantityText.text = Std.string(Quantity);

        if(Item != null)
        {
            Item.setPosition(x, y);
            _quantityText.setPosition(x - 2, y - 2);
            Item.scrollFactor.set();
        }
    }
	
	public function isMouseOver () : Bool
	{
		var mousePosition : FlxPoint = FlxG.mouse.getScreenPosition();
		return (mousePosition.x >= x && mousePosition.x < x + width
        && mousePosition.y >= y && mousePosition.y < y + height);
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