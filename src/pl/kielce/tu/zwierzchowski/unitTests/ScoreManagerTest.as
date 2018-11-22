package pl.kielce.tu.zwierzchowski.unitTests
{
	import org.flexunit.asserts.assertEquals;
	
	public class ScoreManagerTest
	{	
		private var score:int=1000;
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
		public function testAddScore():void
		{
			score+=10;
			assertEquals(score, 1010);
		}
		
		[Test]
		public function testGetScore():void
		{
			assertEquals(score, 1000);
		}
		
		[Test]
		public function testSetScore():void
		{
			score=500;
			assertEquals(score, 500);
		}
	}
}