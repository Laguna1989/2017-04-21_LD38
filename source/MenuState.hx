package;

import flixel.FlxG;
import flixel.FlxState;
import flash.system.System;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
	private var _ring : RingMenu;
	private var _playSound : Bool = true;

	override public function create():Void
	{
		super.create();

		MyInput.reset();

		_ring = new RingMenu();
		_ring.setTitleText("Dean's World");
		_ring.setCreditText(
			"A game by\n" +
			"  Julian Dinges (@Thunraz)\n" +
			"  Simon Weis (@Laguna_999)\n" +
			"  @BloodyOrange\n" +
			"  Music 'Survival' by Lee Rosevere (licensed under CC BY NC) \n"+
			"Visit us at https://runvs.io\n" +
			"\n" +
			"Created April 2017"
		);
		
		_ring.addItem("Play Game", startGame);
		_ring.addItem("Sound On/Off", toggleSound);
		_ring.addItem("Exit", quitGame);
		
		add(_ring);
		
		FlxG.sound.playMusic(AssetPaths.music__ogg, 0.35, true);
	}
	
	public function startGame() : Bool
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.75, false, function () {FlxG.switchState(new PlayState()); } );
		return true;
	}

	public function toggleSound() : Bool 
	{
		if (FlxG.sound.volume != 0)
		{
			_playSound = false;
			FlxG.sound.volume = 0;
			return false;
		}
		else
		{
			_playSound = true;
			FlxG.sound.volume = 1;
			return true;
		}
	}
	
	public function quitGame() : Bool 
	{
		System.exit(0);
		return true;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		MyInput.update();
	}
}
