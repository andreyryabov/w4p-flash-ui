package components.events
{
	import flash.events.Event;
	
	public class SoundChangeEvent extends Event
	{
		public static var SOUND_CHANGE_EVENT:String = "SoundChangeEvent";
		public var _vol:Number;
		public var _isInitiatorButton:Boolean;
		
		public function SoundChangeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, vol:Number = 0, isInitiatorButton:Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this._vol = vol;
			this._isInitiatorButton = isInitiatorButton;
		}
	}
}