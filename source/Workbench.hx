package;

import flixel.FlxSprite;
import flixel.math.FlxRect;

class Workbench extends FlxSprite
{
    private var _state : PlayState;
    private var _proximityRect : FlxRect;
	private var _Smelter : FlxSprite;

    public override function new(xPos : Float, yPos : Float, state : PlayState)
    {
        super(xPos, yPos);

        _state = state;

        //makeGraphic(32, 16, FlxColor.CYAN);
		this.loadGraphic(AssetPaths.Capsule_Bench__png, false, 80,64 );
        _proximityRect = new FlxRect(xPos , yPos, width, height);
		
		_Smelter = new FlxSprite(x + 80, y);
		_Smelter.loadGraphic(AssetPaths.Oven_Icon__png, false, 16, 16);
		_Smelter.scale.set(2, 2);
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
	
	override public function draw():Void 
	{
		super.draw();
		if (CraftManager.extended)
		{
			_Smelter.draw();
		}
	}
}