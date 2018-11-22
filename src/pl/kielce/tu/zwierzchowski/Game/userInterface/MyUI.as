package pl.kielce.tu.zwierzchowski.Game.userInterface
{
	
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class MyUI extends Screen
	{
		private var container:ScrollContainer;
		private var scoreLayoutGrp:LayoutGroup;
		public var keysLayoutGrp:LayoutGroup;
		public var gemsLayoutGrp:LayoutGroup;
		public var scoreboardLayoutGrp:LayoutGroup;
		public var buttonLayoutGrp:LayoutGroup;
		private var VLayout:VerticalLayout;
		private var HLayout:HorizontalLayout;
	
		public var authorLabel:TextField;
		public var scoreLabel:TextField;
		public var keysLabel:TextField;
		public var gemsLabel:TextField;
		public var numberOfScore:TextField;
		public var redKeyLabel:TextField;
		public var blueKeyLabel:TextField;
		public var redGemLabel:TextField;
		public var blueGemLabel:TextField;
		public var soundButton:Button;
		public var quitGameButton:Button;
		public var soundButtonOnTexture:Image;
		public var soundButtonOffTexture:Image;
		
		[Embed(source="../../../../../../assets/graphics/speaker_on.png")]
		protected var soundButtonOnImg:Class;
		
		[Embed(source="../../../../../../assets/graphics/speaker_off.png")]
		protected var soundButtonOffImg:Class;
		
		override protected function initialize():void
		{
			buildContainer();
			loadTitles();
		}
		
		
		private function buildContainer():void
		{
			HLayout = new HorizontalLayout();
			HLayout.gap = 0;
			
			VLayout = new VerticalLayout();
			VLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_TOP;
			VLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_LEFT;
			VLayout.gap = 1;

			container = new ScrollContainer();
			container.layout = VLayout;
			container.width = this.stage.stageWidth;
			container.height = this.stage.stageHeight;
			
			scoreLayoutGrp = new LayoutGroup();
			scoreLayoutGrp.layout = HLayout;
			keysLayoutGrp = new LayoutGroup();
			keysLayoutGrp.layout = HLayout;
			gemsLayoutGrp = new LayoutGroup();
			gemsLayoutGrp.layout = HLayout;
			buttonLayoutGrp = new LayoutGroup();
			buttonLayoutGrp.layout = HLayout; 
			
			addChild(container);
		}
		
		private function loadTitles():void
		{
			authorLabel = new TextField(1000,40,"Projekt Inżynierski: Damian Zwierzchowski"
										, "Verdana", 15, 0xFF0000, true);
			scoreLabel = new TextField(55,20,"Score: "
										,"Verdana", 12, 0xFF0000, true);
			numberOfScore = new TextField(50,20,"","Verdana", 12, 0xFF0000, true);
			
			keysLabel = new TextField(45, 35, "Keys: "
				, "Verdana", 12, 0x000000, true);
			scoreLayoutGrp.addChild(scoreLabel);
			scoreLayoutGrp.addChild(numberOfScore);
			redKeyLabel = new TextField(45,35, "", "Verdana", 12, 0xFF0000, true);
			blueKeyLabel = new TextField(45,35, "", "Verdana", 12, 0x0000FF, true);
			keysLayoutGrp.addChild(keysLabel);
			
			gemsLabel = new TextField(50, 35, "Gems: "
										, "Verdana", 12, 0x000000, true);
			redGemLabel = new TextField(45, 35, "", "Verdana", 12, 0xFF0000, true);
			blueGemLabel = new TextField(45, 35, "", "Verdana", 12, 0x0000FF, true);
			gemsLayoutGrp.addChild(gemsLabel);
			
			soundButtonOnTexture = new Image(Texture.fromBitmap(new  soundButtonOnImg()));
			soundButtonOffTexture = new Image(Texture.fromBitmap(new  soundButtonOffImg()));
			
			soundButton = new Button();
			soundButton.defaultIcon = soundButtonOnTexture;
			soundButton.scaleX = 0.3;
			soundButton.scaleY = 0.3;
			quitGameButton = new Button();
			quitGameButton.label = "Quit Game";
			quitGameButton.scale = 2;
			buttonLayoutGrp.addChild(soundButton);
			buttonLayoutGrp.addChild(quitGameButton);
			
			container.addChild(authorLabel);
			container.addChild(buttonLayoutGrp);
			container.addChild(scoreLayoutGrp);
			container.addChild(keysLayoutGrp);
			container.addChild(gemsLayoutGrp);
		}
	}
}