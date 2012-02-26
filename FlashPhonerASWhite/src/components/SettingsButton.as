package components
{
	import flash.display.Sprite;
	
	public class SettingsButton extends Sprite
	{
		private var _holder:Sprite;
		
		private var _settingsStateHolder:Sprite;
		[Embed(source="assets/settings.png")]
		private var _settingsState:Class;
		
		private var _okStateHolder:Sprite;
		[Embed(source="assets/ok_button.png")]
		private var _okState:Class;
		
		private var _okOverStateHolder:Sprite;
		[Embed(source="assets/ok_button_over.png")]
		private var _okOverState:Class;
		
		private var _okClickedStateHolder:Sprite;
		[Embed(source="assets/ok_button_clicked.png")]
		private var _okClickedState:Class;
		
		private var _circle:Sprite;
		
		public function SettingsButton()
		{
			_holder = new Sprite();
			addChild(_holder);
			
			_settingsStateHolder = new Sprite();
			_settingsStateHolder.addChild(new _settingsState());
			_settingsStateHolder.visible = false;
			_holder.addChild(_settingsStateHolder);
			
			_okStateHolder = new Sprite();
			_okStateHolder.addChild(new _okState());
			_okStateHolder.visible = false;
			_holder.addChild(_okStateHolder);
			
			_okOverStateHolder = new Sprite();
			_okOverStateHolder.addChild(new _okOverState());
			_okOverStateHolder.visible = false;
			_holder.addChild(_okOverStateHolder);
			
			_okClickedStateHolder = new Sprite();
			_okClickedStateHolder.addChild(new _okClickedState());
			_okClickedStateHolder.visible = false;
			_holder.addChild(_okClickedStateHolder);
			
			_settingsStateHolder.visible = true;
			
			_circle = new Sprite();
			_circle.graphics.beginFill(0x000000, 1);
			_circle.graphics.drawCircle(0, 0, 14);
			_circle.graphics.endFill();
			
			_circle.x = 19;
			_circle.y = 19;
			_circle.alpha = 0;
			
			_holder.addChild(_circle);
		}
		
		public function goSettings():void
		{
			_settingsStateHolder.visible = true;
			_okStateHolder.visible = false;
			_okOverStateHolder.visible = false;
			_okClickedStateHolder.visible = false;
			_circle.alpha = 0;
		}
		
		public function goSettingsOver():void
		{
			_circle.alpha = 0.1;
		}
		
		public function goSettingsClicked():void
		{
			_circle.alpha = 0.2;
		}
		
		public function goOk():void
		{
			_settingsStateHolder.visible = false;
			_okStateHolder.visible = true;
			_okOverStateHolder.visible = false;
			_okClickedStateHolder.visible = false;
			_circle.alpha = 0;
		}
		
		public function goOkOver():void
		{
			_settingsStateHolder.visible = false;
			_okStateHolder.visible = false;
			_okOverStateHolder.visible = true;
			_okClickedStateHolder.visible = false;
			_circle.alpha = 0;
		}
		
		public function goOkClicked():void
		{
			_settingsStateHolder.visible = false;
			_okStateHolder.visible = false;
			_okOverStateHolder.visible = false;
			_okClickedStateHolder.visible = true;
			_circle.alpha = 0;
		}
	}
}