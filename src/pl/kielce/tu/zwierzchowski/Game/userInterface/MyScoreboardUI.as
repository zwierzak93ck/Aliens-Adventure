package pl.kielce.tu.zwierzchowski.Game.userInterface
{
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	
	import starling.text.TextField;
		
	public class MyScoreboardUI extends Screen
	{
		private var container:ScrollContainer;
		public var scoreboardLayoutGrp:LayoutGroup;
		private var VLayout:VerticalLayout;
		private var HLayout:HorizontalLayout;
		
		public var finalScoreLabel:TextField;
		public var finalNumberOfScore:TextField;
		public var restartButton:Button;
		public var quitGameButton:Button;
		
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
			VLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			VLayout.gap = 1;
			
			container = new ScrollContainer();
			container.layout = VLayout;
			container.width = this.stage.stageWidth;
			container.height = this.stage.stageHeight;
			container.paddingTop = 20;
			
			scoreboardLayoutGrp = new LayoutGroup();
			scoreboardLayoutGrp.layout = VLayout;
			
			addChild(container);
		}
		
		private function loadTitles():void
		{
			finalScoreLabel = new TextField(100, 50, "SCORE", "Verdana", 15, 0x000000, true);
			finalNumberOfScore = new TextField(100, 50, "", "Verdana", 15, 0x000000, true);
			
			restartButton = new Button();
			restartButton.label = "Restart Game";
			restartButton.scale = 4;
			quitGameButton = new Button();
			quitGameButton.label = "Quit Game";
			quitGameButton.scale = 4;
			
			scoreboardLayoutGrp.addChild(finalScoreLabel);
			scoreboardLayoutGrp.addChild(finalNumberOfScore);
			scoreboardLayoutGrp.addChild(restartButton);
			scoreboardLayoutGrp.addChild(quitGameButton);
			
			container.addChild(scoreboardLayoutGrp);
		}
	}
}