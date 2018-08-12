package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;

class Totem extends FlxSprite
{
    var playstate : PlayState;
    var timer : FlxTimer;
    var dead : Bool;

    var explosionSound : FlxSound;
    var totemDoneSound : FlxSound;
    var standInTotemSound : FlxSound;

    public function new(x : Float = 0, y : Float = 0)
    {
        super(x, y);
        loadGraphic(AssetPaths.totem_2__png, true, 64, 64);
        animation.add("idle", [0, 1, 2], 3, true);
        animation.play("idle");

        playstate = new PlayState();
        timer = new FlxTimer();
        dead = false;
        health = 30;

        explosionSound = FlxG.sound.load(AssetPaths.explosion2__wav, 0.8);
        totemDoneSound = FlxG.sound.load(AssetPaths.totemdissapear__wav, 0.5);
        standInTotemSound = FlxG.sound.load(AssetPaths.standonTotem__wav, 0.15);
    } 

    public function startTimer() : Void
    {
       timer.start(30, disable, 1);
    }

    public function stopTimer() : Void
    {
        timer.cancel();
    }

    function disable(Timer:FlxTimer):Void
    {
        PlayState.roomHeatVal += 50;

        playstate.failDestroyTotem();

        this.kill();
        health = 30;
        dead = false;

        explosionSound.play();
    }

    function normalDisable():Void
    {
        timer.cancel();

        FlxTween.tween(this.scale, {x: 0, y: 0}, 1, { onComplete:killThis }); 
        
        totemDoneSound.play();
    }

    function killThis(tween:FlxTween)
    {
        this.kill();
        this.scale.set(1,1);
        health = 30;
        dead = false;
    }


    public function healthCheck() : Void
    {
        health -= 0.03;

        this.angle += 0.1;

        standInTotemSound.play();

        if(health <= 0 && dead == false)
        {   
            dead = true;

            normalDisable();

            playstate.startCountRespawnTotem();
        }
        
        if(health > 0)
        {
            if(this.scale.x <= 1)
            {
                FlxTween.tween(this.scale, {x: 1.3, y: 1.3}, 1, { type:FlxTween.ONESHOT }); 
            }
            else if(this.scale.x >= 1.3)
            {
                FlxTween.tween(this.scale, {x: 1, y: 1}, 1, { type:FlxTween.ONESHOT }); 
            }
        }
    }
}