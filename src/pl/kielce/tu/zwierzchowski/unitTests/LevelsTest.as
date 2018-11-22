package pl.kielce.tu.zwierzchowski.unitTests 
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;
	
	public class LevelsTest
	{		
		private var test:Boolean;
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function testQuitButtonListener():void
		{
			test=NativeApplication.nativeApplication.dispatchEvent(new Event(Event.EXITING));
			assertTrue(test);
		}
	}
}