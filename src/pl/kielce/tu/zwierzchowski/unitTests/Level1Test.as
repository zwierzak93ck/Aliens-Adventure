package pl.kielce.tu.zwierzchowski.unitTests
{
	import flash.events.Event;
	import flash.media.SoundChannel;
	
	import org.flexunit.asserts.assertTrue;
	
	public class Level1Test
	{
		private var test:Boolean;
		private var soundChannel:SoundChannel = new SoundChannel();
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
		public function testSoundButtonListener():void
		{
			test=soundChannel.dispatchEvent(new Event(Event.CLOSE));
			assertTrue(test);
		}
	}
}