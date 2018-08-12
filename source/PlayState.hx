package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.math.FlxAngle;
import flixel.tile.FlxTilemap;
import flixel.util.FlxStringUtil;
import flixel.math.FlxPoint;
import generate.GenerateState;
import flixel.group.FlxGroup;
import flixel.math.FlxRandom;
import flixel.util.FlxColor;
import flixel.system.FlxSound;

class PlayState extends FlxState
{
	static inline var TILE_SIZE : Int = 16;
	static public var score : Int;
	var mapData : FlxSprite;
	var map : FlxTilemap;
	var emptyTiles : Array<FlxPoint>;
	var randomEmptyTile : FlxPoint;

	var second : Float = 0;

	private var angleShotX : Float;
	private var angleShotY : Float;

	var timer : haxe.Timer;
	var heatIndicator : FlxSprite;
	var player : Player;
	var playerEmitter : ParticleShoot;
	var hud : HUD;

	var groupEnemies:FlxTypedGroup<Enemy_melee>;
	public var groupSpawner:FlxTypedGroup<FlxObject>;
	static public var groupDrop:FlxTypedGroup<Drop>;
	static public var totemItem:Totem;

	public static var respawnerPoint : FlxObject;

	//World Stat
	static public var roomHeatVal : Float = 0;
	static public var amountOfTotem : Int = 3;

	static public var totemSpawnAble : Bool = true;

	//AUDIO
	var hitSound:FlxSound;
	var pickUpSound:FlxSound;
	var shootSound:FlxSound;
	var playerDeadSound:FlxSound;

	override public function create():Void
	{
		roomHeatVal = 0;
		score = 0;
		amountOfTotem = 3;
		roomHeatVal = 0;
		totemSpawnAble = true;

		declareSound();

		add(mapData = new GenerateState(0,0));
		map = new FlxTilemap();
		var csvData:String = FlxStringUtil.bitmapToCSV(GenerateState.mapData);
		map.loadMapFromCSV(csvData, AssetPaths.tiles__png, TILE_SIZE, TILE_SIZE, AUTO);

		//FlxG.debugger.visible = true;

		// Randomly pick room for player to start in
		emptyTiles= map.getTileCoords(0, false);
		randomEmptyTile = emptyTiles[FlxG.random.int(0, emptyTiles.length)];

		var PosPlayerX= randomEmptyTile.x;
		var PosPlayerY= randomEmptyTile.y;

		player = new Player(randomEmptyTile.x, randomEmptyTile.y);		
		
		playerEmitter = new ParticleShoot(player.x, player.y);
		playerEmitter.speed.set(150);
		playerEmitter.lifespan.set(0.5);
		playerEmitter.allowCollisions = FlxObject.ANY;

		totemItem = new Totem(0,0);
        totemItem.kill();
		add(totemItem);

		groupEnemies = new FlxTypedGroup<Enemy_melee>();
 		add(groupEnemies);

		groupSpawner = new FlxTypedGroup<FlxObject>(50);
 		add(groupSpawner);

		groupDrop = new FlxTypedGroup<Drop>();
		add(groupDrop);

		add(map);

		add(playerEmitter);

		add(player);

		heatIndicator = new FlxSprite(player.x, player.y, AssetPaths.char_api__png);
		heatIndicator.alpha = 0;

		add(heatIndicator);

		for (i in 0 ... 50)
        {
			randomEmptyTile = emptyTiles[FlxG.random.int(0, emptyTiles.length)];
        	groupSpawner.add(new FlxObject(randomEmptyTile.x, randomEmptyTile.y, null));
        }	

		for (i in 0 ... 20)
        {
			var spawner : FlxObject = groupSpawner.getRandom(0, groupSpawner.length);
			groupEnemies.add(new Enemy_melee(spawner.x, spawner.y));
        }	 

		for (i in 0 ... 20)
        {
			var dropItem : Drop = new Drop(0,0);
        	dropItem.kill();
			groupDrop.add(dropItem);
        }	

		timer = new haxe.Timer(1000); // 1000ms delay
		timer.run = addSecond;

		hud = new HUD();
 		add(hud);

		FlxG.camera.follow(player, 0.1);
		FlxG.camera.zoom = 2;
		FlxG.camera.setScrollBounds(0, 640, 0, 480);

		FlxG.camera.fade(FlxColor.BLACK, .33, true);
	}

	public function declareSound():Void
	{
		hitSound = FlxG.sound.load(AssetPaths.hit__wav, 0.5);
		pickUpSound = FlxG.sound.load(AssetPaths.pickup__wav, 0.3);
		shootSound = FlxG.sound.load(AssetPaths.shoot__wav, 0.2);
		playerDeadSound = FlxG.sound.load(AssetPaths.gameover__wav, 0.5);
	}

	function addSecond() : Void
	{
		second++;
		
		if(second == 1)
		{
			HUD.showWarn("I need to be careful, they can active at any moment now... ");
		}

		if(second % 30 == 0 && totemSpawnAble)
		{
			//FlxG.watch.addQuick("Spawn  Totem : ", "soon");	
			HUD.showWarn("It seems the 'Fire Totem' will appear soon...");
		}

		if(second % 45 == 0 && totemSpawnAble)
		{
			//FlxG.watch.addQuick("Spawn  Totem : ", "soon");	
			HUD.showWarn("The 'Fire Totem' appear !, i need to destroy it before it explode !");
			totemSpawnAble = false;
			spawnTotem();
		}

		// show Text For heat Level
		/* if(roomHeatVal > 70 && roomHeatVal < 71)
		{
			HUD.showWarn("I think i can still handle the heat, but better look for water by killing the Banyugeni Demon");
		}

		if(roomHeatVal > 90 && roomHeatVal < 91)
		{
			HUD.showWarn("I'm running out of space for heat in my body !, i need water by killing the Banyugeni Demon fast !");
		} */
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		collision();

		// MOUSE INPUT
		if(FlxG.mouse.justReleased && player.dead == false)
		{
			playerEmitter.start(false, 0, 1);
			PlayState.roomHeatVal += 1;		
			shootSound.play();
		}
		
		playerEmitter.launchAngle.set(FlxAngle.angleBetweenMouse(player, true));
		playerEmitter.setPosition(player.x + player.width/2, player.y + player.height/2);

		if(heatIndicator.alive)
		{
			heatIndicator.setPosition(player.x, player.y);
			heatIndicator.alpha = roomHeatVal/113;
		}

		// roomheatVal 113
		if(roomHeatVal >= 113 && player.dead == false)
		{
			gameOver();
		}

		if(score >= 3 && player.dead == false)
		{
			win();
		}

		FlxG.watch.addQuick("Heat room val : ", roomHeatVal);	

		FlxG.watch.addQuick("second : ", second);
	}

	function collision() : Void
	{
		FlxG.collide(player, map);
		FlxG.collide(playerEmitter, map);
		FlxG.collide(map, groupEnemies);
		FlxG.collide(groupEnemies, groupEnemies);

		groupEnemies.forEachAlive(checkEnemyVision);

		FlxG.overlap(groupEnemies, playerEmitter, function HitEnemy(obj1:Enemy_melee, obj2:FlxObject):Void
			{
				obj2.kill();

				if(obj1.stoneForm == false)
				{
					obj1.getHit();

					hitSound.play();
				}
				// yeah this is stupid, DO NOT use this, for some reason haxe wont keep the value, and keep returning null, this is the only way i can get just a point of reference for respawn
				respawnerPoint = groupSpawner.getRandom(0, groupSpawner.length);
			});

		FlxG.overlap(totemItem, player, function HitEnemy(obj1:Totem, obj2:Player):Void
			{
				roomHeatVal += 0.03;
				obj1.healthCheck();
				obj1.stopTimer();
				
			});

		FlxG.overlap(groupEnemies, player, function HitEnemy(obj1:Enemy_melee, obj2:FlxObject):Void
			{
				if(obj1.stoneForm == false)
				{
					roomHeatVal += 0.08;
				}
			});

		FlxG.overlap(groupDrop, player, function HitEnemy(obj1:Drop, obj2:FlxSprite):Void
			{
				obj1.disableTimer();
				obj1.kill();

				pickUpSound.play();
					
					if(roomHeatVal > 0)
					{
						roomHeatVal -= 5;
						if(roomHeatVal < 0)
						{
							roomHeatVal = 0;
						}
					}
			});
	}

	function checkEnemyVision(e:Enemy_melee):Void
	{
		if (map.ray(e.getMidpoint(), player.getMidpoint()))
		{
			e.seesPlayer = true;
			e.playerPos.copyFrom(player.getMidpoint());
		}
		else
			e.seesPlayer = false;
	}

	public function respawnEnemy(enem : Enemy_melee):Void
	{
		var spawner : FlxObject = new FlxObject();
		spawner = respawnerPoint;

		dropItem(enem);
		
		enem.resetEnemy(spawner.x, spawner.y);
	}

	public function dropItem(enem : Enemy_melee):Void
	{
		//FlxG.watch.addQuick("Pos Drop ", enem);	
		var spawnDrop : Bool = new FlxRandom().bool(80);

		if(spawnDrop)
		{
			for (i in 0 ... groupDrop.length)
			{
				if(groupDrop.members[i].exists == false)
				{
					groupDrop.members[i].disableTimer();
					groupDrop.members[i].reset(enem.x, enem.y);
					groupDrop.members[i].enableTimer();
					break;
				}
			}	
		}
	}

	public function spawnTotem() : Void
	{
		randomEmptyTile = emptyTiles[FlxG.random.int(0, emptyTiles.length)];
		totemItem.reset(randomEmptyTile.x, randomEmptyTile.y);
		totemItem.startTimer();
	}

	public function startCountRespawnTotem():Void
	{
		amountOfTotem -= 1;

		if(amountOfTotem > 0)
		{
			HUD.showWarn("Finally, what a nasty thing, " +amountOfTotem+ " 'Fire Totem' to go.");

			new FlxTimer().start(10, 
			
			function callback(Timer:FlxTimer):Void
			{
				totemSpawnAble = true;
			}

			, 1);

			score++;
		}
		else
		{
			score++;
		}
	}

	public function failDestroyTotem():Void
	{
		HUD.showWarn("Damn it !, i failed, the heat increasing fast, i must destroy " +amountOfTotem+ " more 'Fire Totem', Gods speed.");

		new FlxTimer().start(10, 
		
		function callback(Timer:FlxTimer):Void
		{
			totemSpawnAble = true;
		}

		, 1);

		FlxG.camera.shake(0.01, 0.2);
	}

	public function gameOver():Void
	{
		player.dead = true;
		timer.stop();

		for (i in 0 ... groupEnemies.length)
		{
			if(groupEnemies.members[i].exists == true)
			{
				groupEnemies.members[i].kill();
			}
		}	

		for (i in 0 ... groupDrop.length)
		{
			if(groupDrop.members[i].exists == true)
			{
				groupDrop.members[i].kill();
			}
		}

		totemItem.kill();

		new FlxTimer().start(1, 
		function callback(Timer:FlxTimer):Void
		{
			heatIndicator.kill();
			player.deadFunc();

			playerDeadSound.play();
		}
		, 1);
		
		new FlxTimer().start(2, 
		function callback(Timer:FlxTimer):Void
		{
			hud.enableGameOverPanel();
		}
		, 1);
	}

	public function win():Void
	{
		player.dead = true;
		timer.stop();

		for (i in 0 ... groupEnemies.length)
		{
			if(groupEnemies.members[i].exists == true)
			{
				groupEnemies.members[i].killThis();
			}
		}	

		for (i in 0 ... groupDrop.length)
		{
			if(groupDrop.members[i].exists == true)
			{
				groupDrop.members[i].kill();
			}
		}

		totemItem.kill();
		
		new FlxTimer().start(2, 
		function callback(Timer:FlxTimer):Void
		{
			hud.enableWinPanel();
		}
		, 1);
	}
}
