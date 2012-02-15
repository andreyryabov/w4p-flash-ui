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
		}
		
		public function goSettings():void
		{
			_settingsStateHolder.visible = true;
			_okStateHolder.visible = false;
			_okOverStateHolder.visible = false;
			_okClickedStateHolder.visible = false;
		}
		
		public function goOk():void
		{
			_settingsStateHolder.visible = false;
			_okStateHolder.visible = true;
			_okOverStateHolder.visible = false;
			_okClickedStateHolder.visible = false;
		}
		
		public function goOkOver():void
		{
			_settingsStateHolder.visible = false;
			_okStateHolder.visible = false;
			_okOverStateHolder.visible = true;
			_okClickedStateHolder.visible = false;
		}
		
		public function goOkClicked():void
		{
			_settingsStateHolder.visible = false;
			_okStateHolder.visible = false;
			_okOverStateHolder.visible = false;
			_okClickedStateHolder.visible = true;
		}
	}
}