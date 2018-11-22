package pl.kielce.tu.zwierzchowski.Game.logic
{
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	import Box2D.Dynamics.Contacts.b2PolyAndCircleContact;
	import Box2D.Dynamics.Contacts.b2PolygonContact;
	
	import citrus.objects.Box2DPhysicsObject;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.MovingPlatform;
	import citrus.objects.platformer.box2d.Sensor;
	import citrus.objects.platformer.box2d.Teleporter;
	import citrus.physics.box2d.Box2DUtils;
	
	import starling.events.Event;
	
	public class Level1 extends Levels
	{
		private var redKeyBool:Boolean = false;
		private var blueKeyBool:Boolean = false;
		private var redGemBool:Boolean = false;
		private var blueGemBool:Boolean = true;
		private var soundState:int=0;
		private var soundPosition:int;
		
		private var redKey:Sensor;
		private var blueKey:Sensor;
		private var redLockSensor:Sensor;
		private var blueLockSensor:Sensor;
		private var redGem:Sensor;
		private var blueGem:Sensor;
		private var switch_1:Sensor;
		private var end:Sensor;
		private var spikes0:Sensor;
		private var spikes1:Sensor;
		private var spikes2:Sensor;

		
		private var movingPlatform_1_1:MovingPlatform;
		private var movingPlatform_1_2:MovingPlatform;
		private var movingPlatform_2_1:MovingPlatform;
		private var movingPlatform_2_2:MovingPlatform;

		private var teleporterStart_1:Teleporter;
		private var teleporterStart_2:Teleporter;
		private var teleporterStart_3:Teleporter;
				
		private var backgroundUrlLevel1:URLRequest;
		private var backgroundSoundLevel1:Sound;
		private var soundChannelLevel1:SoundChannel;
		
		private var coinArray:Array;
		private var coinArrayLength:uint;
		private var coinVector:Vector.<Coin> = new Vector.<Coin>;
			
		public function Level1(level:MovieClip = null)
		{
			super(level);
		}
		
		override public function initialize():void
		{
			gameWidth = 3000;
			gameHeight = 2000;
			heroX = 103;
			heroY = 550;
			super.initialize();
			
			coinArray = ["coin1", "coin2", "coin3", "coin4", "coin5", "coin6", "coin7", "coin8", "coin9", "coin10",
						"coin11", "coin12", "coin13", "coin14", "coin15", "coin16", "coin17", "coin18", "coin19", "coin20",
						"coin21", "coin22", "coin23", "coin24", "coin25", "coin26", "coin27", "coin28", "coin29", "coin30",
						"coin31", "coin32", "coin33", "coin34", "coin35", "coin36", "coin37", "coin38", "coin39", "coin40",
						"coin41", "coin42", "coin43", "coin44", "coin45", "coin46", "coin47", "coin48", "coin49"];
			coinArrayLength = coinArray.length;
			
			for(var i:uint = 0; i<coinArrayLength; i++)
			{	
				coinVector.push(getObjectByName(coinArray[i]) as Coin);
				coinVector[i].onBeginContact.add(coinListener);	
			}
			
			teleporterStart_1 = getObjectByName("teleporterStart_1") as Teleporter;
			teleporterStart_2 = getObjectByName("teleporterStart_2") as Teleporter;
			teleporterStart_3 = getObjectByName("teleporterStart_3") as Teleporter;
			teleport(teleporterStart_1,2870,1225,10,hero);
			teleport(teleporterStart_2, 1085, 630, 10, hero);
			teleport(teleporterStart_3,2870,1225,10,hero);			
			
			redKey = getObjectByName("redKey") as Sensor;
			redKey.onBeginContact.add(onSensorTouch);
			blueKey = getObjectByName("blueKey") as Sensor;
			blueKey.onBeginContact.add(onSensorTouch);
			
			redLockSensor = getObjectByName("redLockSensor") as Sensor;
			redLockSensor.onBeginContact.add(onSensorTouch);
			blueLockSensor = getObjectByName("blueLockSensor") as Sensor;
			blueLockSensor.onBeginContact.add(onSensorTouch);
			
			redGem = getObjectByName("redGem") as Sensor;
			redGem.onBeginContact.add(onSensorTouch);
			blueGem = getObjectByName("blueGem") as Sensor;
			blueGem.onBeginContact.add(onSensorTouch);
			
			switch_1 = getObjectByName("switch_1") as Sensor;
			switch_1.onBeginContact.add(onSensorTouch);
			
			end = getObjectByName("end") as Sensor;
			end.onBeginContact.add(onSensorTouch);
			
			spikes0 = getObjectByName("spikes0") as Sensor;
			spikes0.onBeginContact.add(onSensorTouch);
			spikes1 = getObjectByName("spikes1") as Sensor;
			spikes1.onBeginContact.add(onSensorTouch);
			spikes2 = getObjectByName("spikes2") as Sensor;
			spikes2.onBeginContact.add(onSensorTouch);

			emitterLocation(portalSprite, end.x, end.y);
			backgroundUrlLevel1 = new URLRequest("../assets/sounds/grassland.mp3");
			backgroundSoundLevel1 = new Sound();
			soundChannelLevel1 = new SoundChannel();
			backgroundSoundLevel1.load(backgroundUrlLevel1);
			soundChannelLevel1=backgroundSoundLevel1.play(0, int.MAX_VALUE, themeTransform);
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
				soundPosition = soundChannelLevel1.position;
				soundChannelLevel1.stop();
				soundState=1;
			}
			else if (soundState==1)
			{
				ui.soundButton.defaultIcon = ui.soundButtonOnTexture;
				soundChannelLevel1=backgroundSoundLevel1.play(soundPosition, int.MAX_VALUE, themeTransform);
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
			
			case "redGem":
				redGem.kill=true;
				blueGem.kill=true;
				redGemBool=true;
				ui.redGemLabel.text="RED";
				ui.gemsLayoutGrp.addChild(ui.redGemLabel);
				if(redGemBool)
				{
					getObjectByName("laser1").kill=true;
					getObjectByName("laser2").kill=true;
					getObjectByName("laser3").kill=true;
				}
				break;
			
			case "blueGem":
				blueGem.kill=true;
				redGem.kill=true;
				blueGemBool=true;
				ui.blueGemLabel.text="BLUE";
				ui.gemsLayoutGrp.addChild(ui.blueGemLabel);
				if(blueGemBool)
				{
					getObjectByName("laser1").kill=true;
					getObjectByName("laser2").kill=true;
					getObjectByName("laser3").kill=true;
				}
				break;
			
			case "redLockSensor":
				if(redKeyBool)
				{
					getObjectByName("redLock").kill=true;
					redLockSensor.kill=true;
				}
				break;
					
			case "blueLockSensor":
				if(blueKeyBool)
				{
					getObjectByName("blueLock").kill=true;
					blueLockSensor.kill=true;
				}
				break;
			
			case "end":
				if(redGemBool)
				{
					nextLevel.dispatch(2);
					soundChannelLevel1.stop();
				}
				else if(blueGemBool)
				{
					nextLevel.dispatch(3);
					soundChannelLevel1.stop();
				}
				break;
				
			case "switch_1":
				movingPlatform_1_1 = getObjectByName("movingPlatform_1_1") as MovingPlatform;
				movingPlatform_1_2 = getObjectByName("movingPlatform_1_2") as MovingPlatform;
				movingPlatform_2_1 = getObjectByName("movingPlatform_2_1") as MovingPlatform;
				movingPlatform_2_2 = getObjectByName("movingPlatform_2_2") as MovingPlatform;
				
				movingPlatform_1_1.startY = 910;
				movingPlatform_1_2.startY = 910;
				movingPlatform_1_1.endY = 1890;
				movingPlatform_1_2.endY = 1890;
				movingPlatform_1_1.speed = 2;
				movingPlatform_1_2.speed = 2;
				
				movingPlatform_2_1.endY = 1050;
				movingPlatform_2_2.endY = 1050;
				movingPlatform_2_1.speed = 2;
				movingPlatform_2_2.speed = 2;
				
				switch_1.view="../assets/graphics/switchLeft.png";
				break;
			
			case "spikes0":
				reset=true;
				ScoreManager.getInstance().addScore(-50);
				ui.numberOfScore.text = ScoreManager.getInstance().getScore().toString();
				break;
			
			case "spikes1":
				reset=true;
				ScoreManager.getInstance().addScore(-50);
				ui.numberOfScore.text = ScoreManager.getInstance().getScore().toString();
				break;
			
			case "spikes2":
				reset=true;
				ScoreManager.getInstance().addScore(-50);
				ui.numberOfScore.text = ScoreManager.getInstance().getScore().toString();
				break;
			}
		}
	}
}