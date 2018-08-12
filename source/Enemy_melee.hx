package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.math.FlxVelocity;
import flixel.util.FlxTimer;
import flixel.math.FlxRandom;
import flixel.util.FlxCollision;
import PlayState;

class Enemy_melee extends FlxSprite
 {
    public var speed:Float;
    var playState : PlayState;

    var brain:FSM;
    var idleTimer:Float;
    var moveDir:Float;
    public var seesPlayer:Bool = false;
    public var playerPos(default, null):FlxPoint;
    
    public var stoneForm : Bool;
    
    public function new(X:Float=0, Y:Float=0)
    {
        super(X, Y);

        enemy_melee_Type(0);

        brain = new FSM(idle);
        idleTimer = 0;
        playerPos = FlxPoint.get();

        playState = new PlayState();

        stoneForm = true;

        this.allowCollisions = FlxObject.NONE;

        animation.play("spawn");
        new FlxTimer().start(new FlxRandom().int(5,10), startMove, 1);
    }

    public function enemy_melee_Type(type : Int)
    {
        if(type == 0)
        {
            loadGraphic(AssetPaths.enemy__png, true, 8, 16);
            health = 2;
            speed = 50;

            animation.add("spawn", [0, 1, 2, 3], 4, false);
            animation.add("idle", [4,4,4,4], 4, false);
            animation.add("dead", [5, 6, 7, 8, 9], 5, false);
        }
        else if(type == 1)
        {
           /*  loadGraphic(AssetPaths.enemy_b__png, true, 8, 16);
            health = 5;
            speed = 40;

            animation.add("spawn", [0, 1, 2, 3], 4, false);
            animation.add("idle", [4,4,4,4], 4, false); */
        }
    }

     
    public function getHit() : Void
    {
        if(health <= 0)
        {           
            health = 3;
            
            if(this.alive && this.exists)
            {
                dead();
            }
        }
        else
        {
            health--;

            if(PlayState.roomHeatVal > 0)
            {
                PlayState.roomHeatVal -= 1;

                if(PlayState.roomHeatVal < 0)
                {
                    PlayState.roomHeatVal = 0;
                }
            }
        }
    }

    public function dead() : Void
    {
        stoneForm = true;
        killThis();
    }

    public function resetEnemy(x:Float,y:Float) : Void
    {
        this.reset(x,y);
        animation.play("spawn");
        new FlxTimer().start(new FlxRandom().int(2,6), startMove, 1);
    }

    function startMove(Timer:FlxTimer):Void
    {
        this.allowCollisions = FlxObject.ANY;
        animation.play("idle");
        stoneForm = false;   
    }

    public function idle():Void
    {
        if (seesPlayer)
        {
            brain.activeState = chase;
        }
        else if (idleTimer <= 0)
        {
            if (FlxG.random.bool(1))
            {
                moveDir = -1;
                velocity.x = velocity.y = 0;
            }
            else
            {
                moveDir = FlxG.random.int(0, 8) * 45;

                velocity.set(speed * 0.5, 0);
                velocity.rotate(FlxPoint.weak(), moveDir);

            }
            idleTimer = FlxG.random.int(1, 4);            
        }
        else
            idleTimer -= FlxG.elapsed;

    }

    public function chase():Void
    {
        if (!seesPlayer)
        {
            brain.activeState = idle;
        }
        else
        {
            FlxVelocity.moveTowardsPoint(this, playerPos, Std.int(speed));
        }
    }

    public function knockBack():Void
    {
        FlxVelocity.moveTowardsPoint(this, playerPos, Std.int(speed));
    }

    override public function update(elapsed:Float):Void
    {
        if(stoneForm == false && alive)
        {
            brain.update();
        }
        
        super.update(elapsed);
    }

    public function killThis():Void
    {
        this.allowCollisions = FlxObject.NONE;

        alive = false;
        animation.play("dead");

        velocity.x = 0;
        velocity.y = 0;

        new FlxTimer().start(1, 
		
		function callback(Timer:FlxTimer):Void
		{
			exists = false;
            playState.respawnEnemy(this);
		}
		, 1);
    }
 }

 