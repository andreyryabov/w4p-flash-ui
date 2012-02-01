package components
{
	import flash.display.Sprite;
	
	public class CallButton extends Sprite
	{
		private var _holder:Sprite;
		
		private var _callStateHolder:Sprite;
		[Embed(source="assets/call_button.png")]
		private var _callState:Class;
		
		private var _callOverStateHolder:Sprite;
		[Embed(source="assets/call_button_over.png")]
		private var _callOverState:Class;
		
		private var _hungUpStateHolder:Sprite;
		[Embed(source="assets/hung_up_button.png")]
		private var _hungUpState:Class;
		
		private var _hungUpOverStateHolder:Sprite;
		[Embed(source="assets/hung_up_button_over.png")]
		private var _hungUpOverState:Class;
		
		public function CallButton()
		{
			_holder = new Sprite();
			addChild(_holder);
			
			_callStateHolder = new Sprite();
			_callStateHolder.addChild(new _callState());
			_callStateHolder.visible = false;
			_holder.addChild(_callStateHolder);
			
			_callOverStateHolder = new Sprite();
			_callOverStateHolder.addChild(new _callOverState());
			_callOverStateHolder.visible = false;
			_holder.addChild(_callOverStateHolder);
			
			_hungUpStateHolder = new Sprite();
			_hungUpStateHolder.addChild(new _hungUpState());
			_hungUpStateHolder.visible = false;
			_holder.addChild(_hungUpStateHolder);
			
			_hungUpOverStateHolder = new Sprite();
			_hungUpOverStateHolder.addChild(new _hungUpOverState());
			_hungUpOverStateHolder.visible = false;
			_holder.addChild(_hungUpOverStateHolder);
			
			_callStateHolder.visible = true;
		}
		
		public function goCallOver():void
		{
			_callStateHolder.visible = false;
			_callOverStateHolder.visible = true;
			_hungUpStateHolder.visible = false;
			_hungUpOverStateHolder.visible = false;
		}
		
		public function goCall():void
		{
			_callStateHolder.visible = true;
			_callOverStateHolder.visible = false;
			_hungUpStateHolder.visible = false;
			_hungUpOverStateHolder.visible = false;
		}
		
		public function goHungUpOver():void
		{
			_callStateHolder.visible = false;
			_callOverStateHolder.visible = false;
			_hungUpStateHolder.visible = false;
			_hungUpOverStateHolder.visible = true;
		}
		
		public function goHungUp():void
		{
			_callStateHolder.visible = false;
			_callOverStateHolder.visible = false;
			_hungUpStateHolder.visible = true;
			_hungUpOverStateHolder.visible = false;
		}
	}
}