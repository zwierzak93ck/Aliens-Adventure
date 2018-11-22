package pl.kielce.tu.zwierzchowski.unitTests
{
	import flash.display.Sprite;
	
	import Array;
	
	import flexunit.flexui.FlexUnitTestRunnerUIAS;
	
	public class FlexUnitApplication extends Sprite
	{
		public function FlexUnitApplication()
		{
			onCreationComplete();
		}
		
		private function onCreationComplete():void
		{
			var testRunner:FlexUnitTestRunnerUIAS=new FlexUnitTestRunnerUIAS();
			testRunner.portNumber=8765; 
			this.addChild(testRunner); 
			testRunner.runWithFlexUnit4Runner(currentRunTestSuite(), "Alien's Adventure");
		}
		
		public function currentRunTestSuite():Array
		{
			var testsToRun:Array = new Array();
			testsToRun.push(LevelsTest);
			testsToRun.push(ScoreManagerTest);
			testsToRun.push(Level1Test);
			return testsToRun;
		}
	}
}