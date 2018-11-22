package pl.kielce.tu.zwierzchowski.Game.logic
{
	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	import pl.kielce.tu.zwierzchowski.Game.userInterface.MyScoreboardUI;
	
	import starling.events.Event;
	
	public class ScoreboardLevel extends Levels
	{
		private var finalScore:int;
		private var scoreboardUI:MyScoreboardUI;
		
		private var backgroundUrlScoreboardLevel:URLRequest;
		private var backgroundSoundScoreboardLevel:Sound;
		private var soundChannelScoreboardLevel:SoundChannel;
		
		public function ScoreboardLevel(level:MovieClip = null)
		{
			super(level);
		}
		
		override public function initialize():void
		{
			gameWidth = 1024;
			gameHeight = 720;
			
			super.initialize();
			scoreboardUI = new MyScoreboardUI();
			addChild(scoreboardUI);

			fall.kill = true;
			checkpoint_1.kill = true;
			portalSprite.kill = true;
			ui.removeFromParent(true);
			scoreboardUI.visible = true;
	
			scoreboardUI.finalNumberOfScore.text = ScoreManager.getInstance().getScore().toString();
			scoreboardUI.restartButton.addEventListener(Event.TRIGGERED, restartButtonListener);
			scoreboardUI.quitGameButton.addEventListener(Event.TRIGGERED, quitButtonListener);
			
			
			backgroundUrlScoreboardLevel = new URLRequest("../assets/sounds/score.mp3");
			backgroundSoundScoreboardLevel = new Sound();
			soundChannelScoreboardLevel = new SoundChannel();
			backgroundSoundScoreboardLevel.load(backgroundUrlScoreboardLevel);
			soundChannelScoreboardLevel=backgroundSoundScoreboardLevel.play(0, int.MAX_VALUE, themeTransform);
		}
		
		private function quitButtonListener(e:Event):void
		{
			NativeApplication.nativeApplication.exit();
		}
		
		private function restartButtonListener(e:Event):void
		{
			ScoreManager.getInstance().setScore(1000);
			nextLevel.dispatch(1);
		}
	}
}