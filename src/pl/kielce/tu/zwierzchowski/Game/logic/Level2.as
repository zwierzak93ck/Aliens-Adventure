package pl.kielce.tu.zwierzchowski.Game.logic
{
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	import Box2D.Dynamics.Contacts.b2PolyAndCircleContact;
	import Box2D.Dynamics.Contacts.b2PolygonContact;
	
	import citrus.objects.Box2DPhysicsObject;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Sensor;
	import citrus.physics.box2d.Box2DUtils;
	
	import starling.events.Event;
	
	public class Level2 extends Levels
	{
		
		private var redKeyBool:Boolean = false;
		private var blueKeyBool:Boolean = false;
		private var soundState:int;
		private var soundPosition:int;
		
		private var redKey:Sensor;
		private var blueKey:Sensor;
		private var redLockSensor:Sensor;
		private var blueLockSensor:Sensor;
		private var end:Sensor;
		
		private var backgroundUrlLevel2:URLRequest;
		private var backgroundSoundLevel2:Sound;
		private var soundChannelLevel2:SoundChannel;
		
		private var coinArray:Array;
		private var coinArrayLength:uint;
		private var coinVector:Vector.<Coin> = new Vector.<Coin>;
		
		public function Level2(level:MovieClip = null)
		{
			super(level);
		}
		
		override public function initialize():void
		{
			gameWidth = 2500;
			gameHeight = 1500;
			heroX = 2415;
			heroY = 1200;
			
			super.initialize();
			coinArray = ["coin1", "coin2", "coin3", "coin4", "coin5", "coin6", "coin7", "coin8", "coin9", "coin10",
				"coin11", "coin12", "coin13", "coin14", "coin15", "coin16", "coin17", "coin18", "coin19"];
			coinArrayLength = coinArray.length;
			
			for(var i:uint = 0; i<coinArrayLength; i++)
			{	
				coinVector.push(getObjectByName(coinArray[i]) as Coin);
				coinVector[i].onBeginContact.add(coinListener);	
			}
			ui.gemsLayoutGrp.removeFromParent(true);
			
			redKey = getObjectByName("redKey") as Sensor;
			redKey.onBeginContact.add(onSensorTouch);
			blueKey = getObjectByName("blueKey") as Sensor;
			blueKey.onBeginContact.add(onSensorTouch);
			
			redLockSensor = getObjectByName("redLockSensor") as Sensor;
			redLockSensor.onBeginContact.add(onSensorTouch);
			blueLockSensor = getObjectByName("blueLockSensor") as Sensor;
			blueLockSensor.onBeginContact.add(onSensorTouch);
			
			end = getObjectByName("end") as Sensor;
			end.onBeginContact.add(onSensorTouch);
			
			emitterLocation(portalSprite, end.x, end.y);	
			backgroundUrlLevel2 = new URLRequest("../assets/sounds/iceland.mp3");
			backgroundSoundLevel2 = new Sound();
			soundChannelLevel2 = new SoundChannel();
			backgroundSoundLevel2.load(backgroundUrlLevel2);
			soundChannelLevel2=backgroundSoundLevel2.play(0, int.MAX_VALUE, themeTransform);
			ui.soundButton.addEventListener(Event.TRIGGERED, soundButtonListener);
		}
		
		private function coinListener(c:b2PolyAndCircleContact):void
		{
			var obj:Box2DPhysicsObject=Box2DUtils.CollisionGetOther(hero, c).body.GetUserData() as Box2DPhysicsObject;
			for (var i:uint = 0; i < coinArrayLength; i++)
			{
				switch(Box2DUtils.CollisionGetObjectByType(Coin, c))
				{
					case coinVector[i]:
						ScoreManager.getInstance().addScore(10);
						ui.numberOfScore.text = ScoreManager.getInstance().getScore().toString();
						break;
				}
			}
		}
		
		public function soundButtonListener(e:Event):void
		{
			if(soundState==0)
			{
				ui.soundButton.defaultIcon = ui.soundButtonOffTexture;
				soundPosition = soundChannelLevel2.position;
				soundChannelLevel2.stop();
				soundState=1;
			}
			else if (soundState==1)
			{
				ui.soundButton.defaultIcon = ui.soundButtonOnTexture;
				soundChannelLevel2=backgroundSoundLevel2.play(soundPosition, int.MAX_VALUE, themeTransform);
				soundState=0;
			}
		}
		
		override protected function onSensorTouch(c:b2PolygonContact):void
		{
			super.onSensorTouch(c);
			switch(objName)
			{
				case "redKey":
					redKey.kill=true;
					redKeyBool=true;
					ui.redKeyLabel.text="RED";
					ui.keysLayoutGrp.addChild(ui.redKeyLabel);
					break;
				
				case "blueKey":
					blueKey.kill=true;
					blueKeyBool=true;
					ui.blueKeyLabel.text="BLUE";
					ui.keysLayoutGrp.addChild(ui.blueKeyLabel);	
					break;
				
				case "redLockSensor":
					if(redKeyBool)
					{
						trace("REDLOCK");
						getObjectByName("redLock").kill=true;
						redLockSensor.kill=true;
					}
					break;
				
				case "blueLockSensor":
					if(blueKeyBool)
					{
						trace("BLUELOCK");
						getObjectByName("blueLock").kill=true;
						blueLockSensor.kill=true;
					}
					break;
				
				case "end":
					ScoreManager.getInstance().addScore(100);
					soundChannelLevel2.stop();
					nextLevel.dispatch(4);
					break;
			}
		}
	}
}