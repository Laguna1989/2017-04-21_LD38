package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.math.FlxRect;

class Workbench extends FlxSprite
{
    private var _state : PlayState;
    private var _proximityRect : FlxRect;

    public override function new(xPos : Float, yPos : Float, state : PlayState)
    {
        super(xPos, yPos);

        _state = state;

        //makeGraphic(32, 16, FlxColor.CYAN);
		this.loadGraphic(AssetPaths.Capsule_Bench__png, false, 80,64 );
        _proximityRect = new FlxRect(xPos - width / 2, yPos - height / 2, width * 2, height * 2);
    }

    public override function update(elapsed : Float)
    {
        super.update(elapsed);

        if(_proximityRect.containsPoint(_state._player.getPosition()))
        {
            _state.PlayerIsNearWorkbench = true;
        }
        else
        {
            _state.PlayerIsNearWorkbench = false;
        }
		
    }
}