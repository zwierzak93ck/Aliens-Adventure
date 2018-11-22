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

	public class Level3 extends Levels
	{		
		private var end:Sensor;
		private var backgroundUrlLevel3:URLRequest;
		private var backgroundSoundLevel3:Sound;
		private var soundChannelLevel3:SoundChannel;
		private var soundState:int;
		private var soundPosition:int;
		private var coinArray:Array;
		private var coinArrayLength:uint;
		private var coinVector:Vector.<Coin> = new Vector.<Coin>;
			
		public function Level3(level:MovieClip = null)
		{
			super(level);
		}
		
		override public function initialize():void
		{
			gameWidth = 5000;
			gameHeight = 1500;
			heroX = 100;
			heroY = 1100;
			
			super.initialize();
			
			coinArray = ["coin1", "coin2", "coin3", "coin4", "coin5", "coin6", "coin7", "coin8", "coin9", "coin10",
				"coin11", "coin12", "coin13", "coin14", "coin15", "coin16", "coin17", "coin18", "coin19", "coin20",
				"coin21", "coin22", "coin23", "coin24", "coin25", "coin26", "coin27", "coin28", "coin29", "coin30",
				"coin31", "coin32"];
			coinArrayLength = coinArray.length;
			
			for(var i:uint = 0; i<coinArrayLength; i++)
			{	
				coinVector.push(getObjectByName(coinArray[i]) as Coin);
				coinVector[i].onBeginContact.add(coinsListener);	
			}
			ui.keysLayoutGrp.removeFromParent(true);
			ui.gemsLayoutGrp.removeFromParent(true);
			
			end = getObjectByName("end") as Sensor;
			end.onBeginContact.add(onSensorTouch);
			
			emitterLocation(portalSprite, end.x, end.y);	
			backgroundUrlLevel3 = new URLRequest("../assets/sounds/mushroom.mp3");
			backgroundSoundLevel3 = new Sound();
			soundChannelLevel3 = new SoundChannel();
			backgroundSoundLevel3.load(backgroundUrlLevel3);
			soundChannelLevel3=backgroundSoundLevel3.play(0, int.MAX_VALUE, themeTransform);
			ui.soundButton.addEventListener(Event.TRIGGERED, soundButtonListener);
		}
		
		private function coinsListener(c:b2PolyAndCircleContact):void
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
				soundPosition = soundChannelLevel3.position;
				soundChannelLevel3.stop();
				soundState=1;
			}
			else if (soundState==1)
			{
				ui.soundButton.defaultIcon = ui.soundButtonOnTexture;
				soundChannelLevel3=backgroundSoundLevel3.play(soundPosition, int.MAX_VALUE, themeTransform);
				soundState=0;
			}	
		}
		
		override protected function onSensorTouch(c:b2PolygonContact):void
		{
			super.onSensorTouch(c);
			switch(objName)
			{		
				case "end":
					ScoreManager.getInstance().addScore(100);
					soundChannelLevel3.stop();
					nextLevel.dispatch(4);
					break;
			}
		}
	}
}