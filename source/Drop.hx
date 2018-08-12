package;

import flixel.FlxSprite;
import flixel.util.FlxTimer;

class Drop extends FlxSprite
 {
     var timer : FlxTimer ;

    public function new(x : Float = 0, y : Float = 0)
    {
        super(x, y);
        loadGraphic(AssetPaths.water_ball__png, true, 8, 8);
        animation.add("idle", [0, 1, 2, 3], 4, true);
        animation.play("idle");

        timer = new FlxTimer();

        //new FlxTimer().start(8, disable, 1);
    } 

    public function enableTimer()
    {
        timer.start(8, disable, 1);
    }

    public function disableTimer()
    {
        timer.cancel();
    }

    function disable(Timer:FlxTimer):Void
    {
        this.kill();
    }
 }
