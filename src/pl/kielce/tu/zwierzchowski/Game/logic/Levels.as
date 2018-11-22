package pl.kielce.tu.zwierzchowski.Game.logic
{
	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.SoundTransform;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import Box2D.Dynamics.Contacts.b2PolygonContact;
	
	import citrus.core.starling.StarlingState;
	import citrus.objects.Box2DPhysicsObject;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Crate;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.MovingPlatform;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.objects.platformer.box2d.Sensor;
	import citrus.objects.platformer.box2d.Teleporter;
	import citrus.physics.box2d.Box2D;
	import citrus.physics.box2d.Box2DUtils;
	import citrus.utils.objectmakers.ObjectMaker2D;
	import citrus.view.ACitrusCamera;
	import citrus.view.starlingview.StarlingArt;
	import citrus.view.starlingview.StarlingCamera;
	
	import org.osflash.signals.Signal;
	
	import starling.events.Event;
	import starling.extensions.particles.PDParticleSystem;
	import starling.textures.Texture;
	import pl.kielce.tu.zwierzchowski.Game.userInterface.MyUI;
	
	public class Levels extends StarlingState
	{
		protected var reset:Boolean = false;
		protected var heroY:Number;
		protected var heroX:Number;
		protected var gameWidth:Number;
		protected var gameHeight:Number;
		protected var objName:String;
		
		protected var lvl:MovieClip;
		public var nextLevel:Signal;
		protected var hero:Hero;
		
		protected var fall:Sensor;
		protected var checkpoint_1:Sensor;
		
		protected var ui:MyUI;
		protected var themeTransform:SoundTransform;
		protected var portalParticle:PDParticleSystem;
		protected var portalSprite:CitrusSprite;
		
		[Embed(source="../../../../../../assets/particles/particlePortal.pex", mimeType="application/octet-stream")]
		private var particlePortal:Class;
		
		[Embed(source="../../../../../../assets/particles/texture.png")]
		protected var particleTexture:Class;
						
		public function Levels(level:MovieClip = null)
		{
			super();
			lvl = level;
			var objects:Array = [Hero, Platform, Sensor, MovingPlatform, Coin, Teleporter, Crate, CitrusSprite];
			
			nextLevel = new Signal();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			ui = new MyUI();
			addChild(ui);
			ui.numberOfScore.text = ScoreManager.getInstance().getScore().toString();
			
			Mouse.cursor = MouseCursor.BUTTON;
			Mouse.show();
			
			var box2D:Box2D = new Box2D("Box2D");
			box2D.visible = false;
			add(box2D);
			ObjectMaker2D.FromMovieClip(lvl);
			
			portalParticle = new PDParticleSystem(XML(new particlePortal()), Texture.fromBitmap(new particleTexture()));
			portalParticle.start();			
			portalSprite = new CitrusSprite("portalSprite", {view:portalParticle});
			add(portalSprite);
			
			hero = new Hero("hero", {x:heroX, y:heroY, width:66, height:92, view:"../assets/graphics/hero.swf"});
			add(hero);
			hero.canDuck = false;
			hero.acceleration = 0.6;
			
			fall = getObjectByName("fall") as Sensor;
			fall.onBeginContact.add(onSensorTouch);
			
			checkpoint_1 = getObjectByName("checkpoint_1") as Sensor;
			checkpoint_1.onBeginContact.add(onSensorTouch);
			
			themeTransform = new SoundTransform(0.1, 0);
			
			StarlingArt.setLoopAnimations(["idle"]);
			
			var cam:ACitrusCamera;
			cam = view.camera as StarlingCamera;
			cam.setUp(hero, new Rectangle(0, 0, gameWidth, gameHeight), new Point(.5, .5));
			cam.parallaxMode = ACitrusCamera.PARALLAX_MODE_TOPLEFT;	
			
			ui.quitGameButton.addEventListener(Event.TRIGGERED, quitButtonListener);
		}
		
		public function quitButtonListener(e:Event):void
		{
			NativeApplication.nativeApplication.exit();
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			if(reset) 
			{
				heroStart(heroX, heroY);	
			}
		}
		
		protected function emitterLocation(sprite:CitrusSprite, x:int, y:int):void
		{
			(sprite.view as PDParticleSystem).emitterX = x;
			(sprite.view as PDParticleSystem).emitterY = y;
		}
		
		protected function heroStart(x:int, y:int):void
		{
			hero.x=x;
			hero.y=y;
			reset= false;
		}
		
		protected function teleport(teleport:Teleporter, endX:int, endY:int, waitingTime:int, object:Box2DPhysicsObject):void
		{
			teleport.endX = endX;
			teleport.endY = endY;
			teleport.waitingTime = waitingTime;
			teleport.object = object;
		}
		
		protected function onSensorTouch(c:b2PolygonContact):void
		{
			var obj:Box2DPhysicsObject=Box2DUtils.CollisionGetOther(hero, c).body.GetUserData() as Box2DPhysicsObject;
			objName=obj.name;
			switch(objName)
			{
				case "fall":
					reset = true;
					ScoreManager.getInstance().addScore(-100);
					ui.numberOfScore.text = ScoreManager.getInstance().getScore().toString();					
					break;
				
				case "checkpoint_1":
					heroX=checkpoint_1.x;
					heroY=checkpoint_1.y;
					checkpoint_1.view="../assets/graphics/flagBlue2.png";
					break;
			}
		}
	}
}