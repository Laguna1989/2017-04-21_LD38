package;

import flixel.FlxG;
import flixel.FlxState;
import flash.system.System;

class MenuState extends FlxState
{
	private var _ring : RingMenu;
	private var _playSound : Bool = true;

	override public function create():Void
	{
		super.create();

		MyInput.reset();

		_ring = new RingMenu();
		_ring.setTitleText("LD38");
		_ring.setCreditText(
			"A game by\n" +
			"  Julian Dinges (@Thunraz)\n" +
			"  Simon Weis (@Laguna_999)\n" +
			"  @BloodyOrange\n" +
			"Visit us at https://runvs.io\n" +
			"\n" +
			"Created April 2017"
		);
		
		_ring.addItem("Play Game", startGame);
		_ring.addItem("Sound On/Off", toggleSound);
		_ring.addItem("Exit", quitGame);
		
		add(_ring);
	}
	
	public function startGame() : Bool
	{
		FlxG.switchState(new PlayState());
		return true;
	}

	public function toggleSound() : Bool 
	{
		_playSound = !_playSound;
		return _playSound;
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
