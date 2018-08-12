package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;
using flixel.util.FlxTimer;
import flixel.ui.FlxButton;
import flixel.ui.FlxBar;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxEase.EaseFunction;
import flixel.tweens.FlxTween;
import haxe.Timer;
import flixel.system.FlxSound;
import flash.filters.DropShadowFilter;
import flixel.graphics.frames.FlxFilterFrames;
import flash.filters.BitmapFilter;

class HUD extends FlxTypedGroup<FlxSprite>
 {
    static inline var SIZE_INCREASE:Int = 50;

    var background:FlxSprite;

    static var textBlock:FlxSprite;
    static var textWarn:FlxText;

    static var textEnd:FlxText;

    var textHeat:FlxText;

    var buttonReset : FlxButton;
    var buttonMenu : FlxButton;

    public static var sprintIcon : FlxBar;
    public static var sprintIconCooldown : FlxBar;
    public static var sprintIconVal : Float;
    public static var sprintIconCooldownVal : Float;
    var textHeatVal : Float;
    
    var dropShadowFilter:DropShadowFilter;
    var spr4Filter:FlxFilterFrames;

    var timerType : haxe.Timer;

    var endString : String;

    private var menuSprite : FlxSprite;

    //AUDIO
	static public var talkSound:FlxSound;

    public function new()
    {
        timerType = new haxe.Timer(200); // 1000ms delay
        endString = "Game Over";
        // UKURAN TEXTURE 160x120
        sprintIconVal = 0;
        sprintIconCooldownVal = 300;
        textHeatVal = 0;
        super();

        sprintIcon = new FlxBar(0,0,LEFT_TO_RIGHT, 32, 32, HUD, "sprintIconVal", 0, 25);
        sprintIcon.createImageBar(null, AssetPaths.sprint__png, FlxColor.TRANSPARENT);
        sprintIcon.setPosition(FlxG.width/2 + 120 , FlxG.height/2 - 95);
		add(sprintIcon);

        sprintIconCooldown = new FlxBar(0,0,LEFT_TO_RIGHT, 32, 32, HUD, "sprintIconCooldownVal", 0, 300);
        sprintIconCooldown.createImageBar(null, AssetPaths.sprint_cooldown__png, FlxColor.TRANSPARENT);
        sprintIconCooldown.setPosition(FlxG.width/2 + 120 , FlxG.height/2 - 95);
		add(sprintIconCooldown);

        textHeat = new FlxText(0, 0, 80, "0 °C");
        textHeat.setPosition(FlxG.width/2 + 80 , FlxG.height/2 - 117);
        textHeat.setFormat( 15, FlxColor.RED, RIGHT);
        textHeat.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
        add(textHeat);

        background = new FlxSprite().makeGraphic(640, 480, FlxColor.BLACK);
        background.alpha = 0.85;
        background.setPosition(FlxG.width/2 - 320/2, FlxG.height/2 - (FlxG.height/2)/2);
        add(background);

        textBlock = new FlxSprite(160, 120, AssetPaths.textBlock__png);
        textBlock.setPosition(FlxG.width/2 - 320/2, FlxG.height/2 + 60);

        textWarn = new FlxText(320, 120, 300, "-", 8);
        textWarn.setPosition(FlxG.width/2 - 320/2 + 10, FlxG.height/2 + 70);
        textWarn.setFormat(8, FlxColor.WHITE, LEFT);
        textWarn.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);

        add(textBlock);
        add(textWarn);

        // GAME OVER AND WIN

        menuSprite = new FlxSprite(0,0, AssetPaths.menu__png);
        menuSprite.scale.set(0.5, 0.5);
        add(menuSprite);

        buttonReset = new FlxButton(0, 0, "", resetGame);
        buttonReset.setPosition(FlxG.width/2 - 320/2 + buttonReset.width + buttonReset.width /2 - 5, FlxG.height/2 + 65);
        buttonReset.loadGraphic(AssetPaths.replayBut__png, 32,32);
        buttonReset.scale.set(1.3,1.3);
        buttonReset.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		add(buttonReset);

         //DROP SHADOW
        dropShadowFilter = new DropShadowFilter(4, 45, 0, .75, 10, 10, 1, 1);
		spr4Filter = createFilterFrames(buttonReset, dropShadowFilter);
        //END

        buttonMenu = new FlxButton(0, 0, "", menuGame);
        buttonMenu.setPosition(FlxG.width/2 - 320/2 + buttonMenu.width + buttonMenu.width /2 + 50, FlxG.height/2 + 65);
        buttonMenu.loadGraphic(AssetPaths.homeBut__png, 32,32);
        buttonMenu.scale.set(1.3,1.3);
        buttonMenu.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		add(buttonMenu);

         //DROP SHADOW
        dropShadowFilter = new DropShadowFilter(4, 45, 0, .75, 10, 10, 1, 1);
		spr4Filter = createFilterFrames(buttonMenu, dropShadowFilter);
        //END

        textEnd = new FlxText(320, 120, 300, "-");
        textEnd.setPosition(FlxG.width/2 - 320/2 , FlxG.height/2 - 120);
        textEnd.setFormat(AssetPaths.monsterhunterwarprotal__ttf, 50, FlxColor.WHITE, CENTER);
        textEnd.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
        add(textEnd);

        var tween : FlxTween= FlxTween.linearMotion(textEnd,
				                               textEnd.x, textEnd.y,
				                               textEnd.x, textEnd.y - 5,
				                               2, true, { type: FlxTween.PINGPONG, ease: FlxEase.sineInOut });

        // END

        textWarn.kill();
        textBlock.kill();

        background.kill();
        buttonMenu.kill();
        buttonReset.kill();
        textEnd.kill();
        menuSprite.kill();
 
        sprintIconCooldown.kill();

        forEach(function(spr:FlxSprite)
        {
            spr.scrollFactor.set(0, 0);
        });

        talkSound = FlxG.sound.load(AssetPaths.talk__wav, 0.3);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        textHeatVal = PlayState.roomHeatVal + 37;
        textHeat.text = Std.int(textHeatVal) + "°C";
    }

    static public function showWarn(textShow : String) : Void
    {
        textWarn.text = "";

        textBlock.revive();
        textWarn.revive();

        var textTemp : String = "";
        var countChar : Int = 0;
        var timer = new haxe.Timer(25); // 1000ms delay
        
        timer.run = function() 
            { 
                textTemp += textShow.charAt(countChar);
                countChar++;
                textWarn.text = textTemp;

                talkSound.play();

                if(textTemp.length >= textShow.length)
                {
                    timer.stop();
                    new FlxTimer().start(2, disableWarn, 1);
                }
            }
    }

    static public function disableWarn(Timer:FlxTimer):Void
    {
        textBlock.kill();
        textWarn.kill();

        textWarn.text = "";
    }

    public function resetGame() : Void
    {
        FlxG.switchState(new PlayState());
    }

    public function menuGame() : Void
    {
        FlxG.switchState(new MenuState());
    }

    public function enableGameOverPanel() : Void
    {
        textEnd.text = "Game Over";

        background.revive();
        buttonMenu.revive();
        buttonReset.revive();
        textEnd.revive();
        menuSprite.revive();

    }
    
    public function enableWinPanel() : Void
    {
        textEnd.text = "Congrats you save the day !";

        background.revive();
        buttonMenu.revive();
        buttonReset.revive();
        textEnd.revive();
        menuSprite.revive();

    }

    static public function startCooldown()
    {
        sprintIcon.kill();
        sprintIconCooldown.revive();
    }

    static public function endCoolDown()
    {
        sprintIconCooldownVal = 300;
        sprintIcon.revive();
        sprintIconCooldown.kill();
    }

    // FUNGSI WAJIB BUAT DROP SHADOW

    function createSprite(xFactor:Float, yOffset:Float, label:String)
	{
		var sprite = new FlxSprite(
			FlxG.width * xFactor - SIZE_INCREASE,
			FlxG.height / 2 + yOffset - SIZE_INCREASE,
			"assets/logo.png");
		add(sprite);
		
		var text = new FlxText(sprite.x, sprite.y + 120, sprite.width, label, 10);
		text.alignment = CENTER;
		add(text);
		
		return sprite;
	}

    function createFilterFrames(sprite:FlxSprite, filter:BitmapFilter)
	{
		var filterFrames = FlxFilterFrames.fromFrames(
			sprite.frames, SIZE_INCREASE, SIZE_INCREASE, [filter]);
		updateFilter(sprite, filterFrames);
		return filterFrames;
	}

    function updateFilter(spr:FlxSprite, sprFilter:FlxFilterFrames)
	{
		sprFilter.applyToSprite(spr, false, true);
	}
}