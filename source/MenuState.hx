package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.graphics.frames.FlxFilterFrames;
import flash.filters.BitmapFilter;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxEase.EaseFunction;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.system.FlxSound;
import flash.filters.DropShadowFilter;
import flixel.graphics.frames.FlxFilterFrames;

class MenuState extends FlxState
{
    static inline var SIZE_INCREASE:Int = 50;

    private var menuSprite : FlxSprite;
    private var backgroundBlack : FlxSprite;
    var tween:FlxTween;
    
    var buttonPlay : FlxButton;
    var buttonTutorStory : FlxButton;

    var emitter : FlxEmitter;
    var emitter2 : FlxEmitter;

    var dropShadowFilter:DropShadowFilter;
    var spr4Filter:FlxFilterFrames;

    private var titleSprite : FlxSprite;

    // FOR TUTOR AND STORY
    var background:FlxSprite;
    var bookBG:FlxSprite;
    var butNextPage : FlxButton;
    var butPrevPage : FlxButton;
    var butClosePage : FlxButton;
    var textTutor : FlxText;

    var format1 = new FlxTextFormat(FlxColor.BLACK, true, false, null);
	var format2 = new FlxTextFormat(FlxColor.RED, true, false, null);
	var format3 = new FlxTextFormat(FlxColor.BLUE, true, false, null);
	var format4 = new FlxTextFormat(FlxColor.GREEN, false, false, null);
    var pageCounter : Int;

    // sound
    var clickSound : FlxSound;

    override public function create():Void
    {
        pageCounter = 0;

        clickSound = new FlxSound();

        backgroundBlack = new FlxSprite(0,0, AssetPaths.background__jpg);
        backgroundBlack.scale.set(0.5, 0.5);
        add(backgroundBlack);

        titleSprite = new FlxSprite(0,90, AssetPaths.title__png);
        titleSprite.scale.set(0.5, 0.5);
        add(titleSprite);

        tween = FlxTween.linearMotion(titleSprite,
				                               titleSprite.x, titleSprite.y,
				                               titleSprite.x, titleSprite.y - 5,
				                               2, true, { type: FlxTween.PINGPONG, ease: FlxEase.sineInOut });

        emitter = new FlxEmitter(200,100);
        emitter2 = new FlxEmitter(400,100);
        for (i in 0 ... 100)
        {
        	var leaf = new FlxParticle();
        	leaf.loadGraphic(AssetPaths.leaf_fall__png, true, 16, 16);
			leaf.animation.add("leaf1", [0], 1, true);
            leaf.animation.add("leaf2", [1], 1, true);
            leaf.animation.add("leaf3", [2], 1, true);
            leaf.animation.add("leaf4", [3], 1, true);
            leaf.animation.play("leaf1");
            var rand : Int = Std.random(4); 

            if(rand == 0)
            {
                leaf.animation.play("leaf1");
            }
            else if(rand == 1)
            {
                leaf.animation.play("leaf2");
            }
            else if(rand == 2)
            {
                leaf.animation.play("leaf3");
            }
            else if(rand == 3)
            {
                leaf.animation.play("leaf4");
            }
            else
            {
                leaf.animation.play("leaf1");
            }

        	leaf.exists = false;
        	emitter.add(leaf);
            emitter2.add(leaf);
        }	

        
        emitter.acceleration.start.min.y = emitter2.acceleration.start.min.y =  1;
		emitter.acceleration.start.max.y = emitter2.acceleration.start.max.y =  5;
		emitter.acceleration.end.min.y = emitter2.acceleration.end.min.y = 1;
		emitter.acceleration.end.max.y = emitter2.acceleration.end.max.y = 5; 
        
		emitter.lifespan.set(10);
        emitter.launchMode = FlxEmitterMode.CIRCLE;
        add(emitter);
        emitter.start(false, 0.5, 0);

        emitter2.lifespan.set(10);
        emitter2.launchMode = FlxEmitterMode.CIRCLE;
        add(emitter2);
        emitter2.start(false, 0.5, 0);

        menuSprite = new FlxSprite(0,0, AssetPaths.menu__png);
        menuSprite.scale.set(0.5, 0.5);
        add(menuSprite);

        buttonPlay = new FlxButton(0, 0, "", playGame);
        buttonPlay.setPosition(FlxG.width/2 - 320/2 + buttonPlay.width + buttonPlay.width /2 - 5, FlxG.height/2 + 65);
        buttonPlay.loadGraphic(AssetPaths.playBut__png, 32,32);
        buttonPlay.scale.set(1.3,1.3);
        buttonPlay.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		add(buttonPlay);

        //DROP SHADOW
        dropShadowFilter = new DropShadowFilter(4, 45, 0, .75, 10, 10, 1, 1);
		spr4Filter = createFilterFrames(buttonPlay, dropShadowFilter);
        //END

        buttonTutorStory = new FlxButton(0, 0, "", tutorStory);
        buttonTutorStory.setPosition(FlxG.width/2 - 320/2 + buttonTutorStory.width + buttonTutorStory.width /2 + 50, FlxG.height/2 + 65);
        buttonTutorStory.loadGraphic(AssetPaths.guideBut__png, 32,32);
        buttonTutorStory.scale.set(1.3,1.3);
        buttonTutorStory.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		add(buttonTutorStory);

        //DROP SHADOW
        dropShadowFilter = new DropShadowFilter(4, 45, 0, .75, 10, 10, 1, 1);
		spr4Filter = createFilterFrames(buttonTutorStory, dropShadowFilter);
        //END

        background = new FlxSprite().makeGraphic(640, 480, FlxColor.BLACK);
        background.alpha = 0.5;
        background.setPosition(FlxG.width/2 - 320/2, FlxG.height/2 - (FlxG.height/2)/2);
        add(background);

        bookBG = new FlxSprite(0, 0, AssetPaths.bookPage__png);
        bookBG.scale.set(0.85, 0.85);
        bookBG.setPosition(FlxG.width/2 - 320/2, FlxG.height/2 - 240/2);
        add(bookBG);

        textTutor = new FlxText(0, 0, 240);
        textTutor.setPosition(FlxG.width/2 - 320/2 + 30, FlxG.height/2 - 240/2 + 20);
        textTutor.setFormat(8, FlxColor.BLACK);
        add(textTutor);

        butNextPage = new FlxButton(0, 0, nextPage);
        butNextPage.loadGraphic(AssetPaths.next__png, false, 16, 16);
        butNextPage.scale.set(2,2);
        butNextPage.updateHitbox();
        butNextPage.setPosition(bookBG.x + bookBG.width/2 + 80, bookBG.y + bookBG.height/2 + 65);
        butNextPage.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		add(butNextPage);

        butPrevPage = new FlxButton(0, 0, prevPage);
        butPrevPage.loadGraphic(AssetPaths.back__png, false, 16, 16);
        butPrevPage.scale.set(2,2);
        butPrevPage.updateHitbox();
        butPrevPage.setPosition(bookBG.x + bookBG.width/2 - 120, bookBG.y + bookBG.height/2 + 65);
        butPrevPage.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		add(butPrevPage);

        butClosePage = new FlxButton(0, 0, openCloseGuidePage);
        butClosePage.loadGraphic(AssetPaths.close__png, false, 16, 16);
        butClosePage.scale.set(2,2);
        butClosePage.updateHitbox();
        butClosePage.setPosition(bookBG.x + bookBG.width/2 + 110, bookBG.y + 5);
        butClosePage.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		add(butClosePage);

        FlxG.camera.zoom = 2;

        openCloseGuidePage();

        super.create();
    }

    function guidePage(index : Int):Void
    {
        if(index == 0)
        {
            textTutor.text = "";
            textTutor.setFormat(12, FlxColor.BLACK, CENTER);
            textTutor.text = "\n\n\nPRIVATE JOURNAL\n\n\nI made this for fun, sorry for any grammar error and such.";
            textTutor.addFormat(format1, 0, 11);
        }
        else if(index == 1)
        {
            textTutor.text = "";
            textTutor.setFormat(8, FlxColor.BLACK, LEFT);
            textTutor.text = "21 July 1567\n\nToday i got a secret order from the Central Temple to do a repression of a demonic outbreak in an unnamed cave near New Alexandria.\n\nFrom what i heard its species name is Banyugeni Demolicus, its a fire-water demon, while it is considered a weak demon, not everyone can fight it, since its only weakness apparently is Infused Holy Water.\n\nIt's no wonder why the Central Temple ordered me, since there's very few priest that can use Water Base magic in the temple, and i'm one of them.'";
            textTutor.addFormat(format1, 0, 11);
            textTutor.addFormat(format2, 185, 204);
            textTutor.addFormat(format3, 332, 352);
            textTutor.addFormat(format3, 446, 456);
        }
        else if(index == 2)
        {
            textTutor.text = "";
            textTutor.setFormat(8, FlxColor.BLACK, LEFT);
            textTutor.text = "The problem with using Water Base magic is it's not mainly uses mana, but it mainly use your bodily fluid, which means the person can easily raise their own body temperature , even just 1 time casting is risky, maintaining body temperature is extremely important for us, if not, we will be cooked or melt inside out, but hopefully i won't panic and can control my action.\n\nFortunately enough Banyugeni Demolicus is a fire-water demon, while i can't be near them, if i can destroy them, they might drop water, which hopefully can be use to reduce my body temp and refresh myself\nAlso i'm not that stupid, i'll bring my Fire Resistent Charm, at least i can handle up to 150 °C";
            textTutor.addFormat(format3, 23, 34);
            textTutor.addFormat(format2, 92, 105);
            textTutor.addFormat(format4, 210, 270);
            textTutor.addFormat(format2, 392,412);
            textTutor.addFormat(format4, 460, 532);
            textTutor.addFormat(format2, 640, 680);
        }

        else if(index == 3)
        {
            textTutor.text = "";
            textTutor.setFormat(8, FlxColor.BLACK, LEFT);
            textTutor.text = "There's also another thing that make this demon hard to fight, they tend to do a Demonic Ritual to spawn the Fire Totem, no one know for sure what it did, but what i know is i need to destroy it as fast as i can, because it can explode and releases fume of high temp toxic \ncloud.\n\nI need to destroy at least 3 of them to completely break the Ritual for the time being, but how to destroy it is the problem, it can only destroyed by direct prayer, which means i need to stand for quite a while inside its fiery zone, another heat source to worry about.";
            textTutor.addFormat(format2, 109, 120);
            textTutor.addFormat(format4, 282, 369);
            textTutor.addFormat(format4, 408, 515);
        }

        else if(index == 4)
        {
            textTutor.text = "";
            textTutor.setFormat(8, FlxColor.BLACK, LEFT);
            textTutor.text = "Honestly speaking, this will be a tough fight, i'm not sure if there's enough space in my body for .... this amount of heat, but i hope i will succeed and won't disappoint my Gods.\n\n\nI pray for the 7 Divines to always guide us all.\n\n\n\n\n\n\n\n\n Next Short Tutorial ------>";
            textTutor.addFormat(format2, 46, 123);
        }

        else if(index == 5)
        {
            textTutor.text = "";
            textTutor.setFormat(12, FlxColor.BLACK, CENTER);
            textTutor.text = "\n\n\nShoot = Pointer + Left Click\n\n\nWalk = WASD\n\n\nShort Sprint = Hold Shift";
            textTutor.addFormat(format2, 0, 8);
            textTutor.addFormat(format2, 34, 38);
            textTutor.addFormat(format2, 45, 60);
            textTutor.addFormat(format3, 11, 33);
            textTutor.addFormat(format3, 41, 56);
            textTutor.addFormat(format3, 61, 73);
        }
    }

    function openCloseGuidePage():Void
    {
        if(background.alive)
        {
            background.kill();
            bookBG.kill();
            textTutor.kill();

            butClosePage.kill();
            butNextPage.kill();
            butPrevPage.kill();

            buttonPlay.revive();
            buttonTutorStory.revive();
        }
        else
        {
            textTutor.clearFormats();

            pageCounter = 0;
            guidePage(pageCounter);

            background.revive();
            bookBG.revive();
            textTutor.revive();

            butClosePage.revive();
            butNextPage.revive();
            butPrevPage.revive();

            buttonPlay.kill();
            buttonTutorStory.kill();
        }
    }

    function nextPage()
    {
        pageCounter++;
        if(pageCounter < 6)
        {
            textTutor.clearFormats();
            guidePage(pageCounter);
        }
        else
        {
            pageCounter = 5;
        }
    }
    
    function prevPage()
    {
        pageCounter--;

        if(pageCounter >= 0)
        {
            textTutor.clearFormats();
            guidePage(pageCounter);
        }

        if(pageCounter <= 0)
        {
            pageCounter = 0;
        }
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }

    public function playGame() : Void
    {
        FlxG.camera.fade(FlxColor.BLACK, .33, false);

        new FlxTimer().start(1, 
			
			function callback(Timer:FlxTimer):Void
			{
				FlxG.switchState(new PlayState());
			}

			, 1);
    }

    public function tutorStory() : Void
    {
        openCloseGuidePage();
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