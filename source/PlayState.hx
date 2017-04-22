package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class PlayState extends FlxState
{
	public var _level : Level;
	public var _player : Player;
	override public function create():Void
	{
		super.create();
		
		_level = new Level();
		
		
		_player = new Player(this);
		//add(_player);
		
		FlxG.camera.follow(_player);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);	
		MyInput.update();
		
		_level.update(elapsed);
		_player.update(elapsed);
		
	}
	
	override public function draw()
	{
		super.draw();
		_level.draw();
		_player.draw();
	}
}
