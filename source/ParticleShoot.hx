package;

import flixel.FlxG;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.FlxSprite;
import flixel.FlxObject;

class ParticleShoot extends FlxEmitter
{
	var bullet : FlxParticle;

	public function new(x:Float, y:Float)
	{
        super(x,y);

		for (i in 0 ... 100)
        {
        	bullet = new FlxParticle();
        	bullet.loadGraphic(AssetPaths.water_ball__png, true, 8, 8);
			bullet.animation.add("idle", [0, 1, 2, 3], 4, true);
			bullet.animation.play("idle");

        	bullet.exists = false;
        	this.add(bullet);
        }	
	}
}
