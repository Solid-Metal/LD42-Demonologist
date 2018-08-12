package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;

class Player extends FlxSprite
{

	public var dead : Bool;
	var timer : FlxTimer;

	var hud : HUD;

	var sprintCounter : Float;
	var speed : Float;
	var runBool : Bool;
	var runCooldown : Bool;

	public function new(x:Float, y:Float)
	{
        super(x,y);
		dead = false;
		loadGraphic(AssetPaths.char__png, true, 8, 16);
		this.animation.add("idle", [0, 0, 0, 0], 4, true);
		this.animation.add("dead", [1, 2, 3, 4], 4, false);

		animation.play("idle");

		hud = new HUD();

		timer = new FlxTimer();
		sprintCounter = 0;
		runBool = false;
		speed = 1;
		runCooldown = false;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);	

		if(dead == false)
		{
			if(FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.D)
			{
				this.x += speed;
			}
			if(FlxG.keys.pressed.LEFT || FlxG.keys.pressed.A)
			{
				this.x -= speed;
			}
			if(FlxG.keys.pressed.UP || FlxG.keys.pressed.W)
			{
				this.y -= speed;
			}
			if(FlxG.keys.pressed.DOWN || FlxG.keys.pressed.S)
			{
				this.y += speed;
			}

			if(FlxG.keys.pressed.SHIFT && runCooldown == false)
			{
				if(sprintCounter <= 25)
				{
					speed = 1.5;
					sprintCounter++;
					runBool = true;
				}
				else
				{
					speed = 1;
					runCooldown = true;
					HUD.startCooldown();

					timer.start(5, doneCooldown, 1);					
				}
			}
			else if(FlxG.keys.justReleased.SHIFT)
			{
				speed = 1;
				runBool = false;
			}

			if(runBool == false && runCooldown == false)
			{
				if(sprintCounter >= 0)
				{
					sprintCounter--;
					speed = 1;
				}
				else
				{
					speed = 1;
				}
			}

			if(runCooldown == true)
			{
				HUD.sprintIconCooldownVal -= 1;
			}

			HUD.sprintIconVal = sprintCounter;
		}

		FlxG.watch.addQuick("sprintCounter : ", sprintCounter);	
		FlxG.watch.addQuick("speed : ", speed);	
	}

	function doneCooldown(Timer:FlxTimer):Void
    {
		HUD.endCoolDown();

        runCooldown = false;
		sprintCounter = 0;
		speed = 1;
    }

	public function deadFunc() : Void
	{
		this.animation.play("dead");
	}
}
