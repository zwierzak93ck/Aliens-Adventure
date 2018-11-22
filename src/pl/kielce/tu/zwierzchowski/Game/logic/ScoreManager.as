package pl.kielce.tu.zwierzchowski.Game.logic
{
	public class ScoreManager
	{
		private var score:int=1000;
		private static var instance:ScoreManager = new ScoreManager();
		
		public function ScoreManager(){}
		
		public function getScore():int
		{
			return score;
		}
		
		public function setScore(val:int):void
		{
			score=val;
		}
		
		public function addScore(val:int):void
		{
			score+=val;
		}
		
		public static function getInstance():ScoreManager
		{
			return instance;
		}
	}
}