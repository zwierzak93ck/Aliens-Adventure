package pl.kielce.tu.zwierzchowski.Game.main
{	
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.utils.LevelManager;
	import pl.kielce.tu.zwierzchowski.Game.logic.Level1;
	import pl.kielce.tu.zwierzchowski.Game.logic.Level2;
	import pl.kielce.tu.zwierzchowski.Game.logic.Level3;
	import pl.kielce.tu.zwierzchowski.Game.logic.Levels;
	import pl.kielce.tu.zwierzchowski.Game.logic.ScoreboardLevel;

	[SWF(width="1024", height="720", frameRate="60", backgroundColor="0xCFF3F7")]
	public class Main extends StarlingCitrusEngine
	{	
		public function Main()
		{
			setUpStarling(true);
		
			levelManager = new LevelManager(Levels);
			levelManager.onLevelChanged.add(changeLevel);
			levelManager.levels = [[Level1, "../assets/levels/level1.swf"], [Level2, "../assets/levels/level2.swf"]
									, [Level3, "../assets/levels/level3.swf"],[ScoreboardLevel, "../assets/levels/scoreboard.swf"]];
			levelManager.gotoLevel(1);
		}
		
		protected function changeLevel(level:Levels):void
		{
			state = level;
			level.nextLevel.add(nextLevel);
		}
		
		protected function nextLevel(levelNumber:uint):void
		{
			levelManager.gotoLevel(levelNumber);
		}
	}
}