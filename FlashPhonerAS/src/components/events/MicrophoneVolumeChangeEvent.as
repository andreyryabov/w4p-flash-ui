package components.events
{
	import flash.events.Event;
	
	public class MicrophoneVolumeChangeEvent extends Event
	{
		public static var MICROPHONE_VOLUME_CHANGE_EVENT:String = "MicrophoneVolumeChangeEvent";
		public var _vol:Number;
		public var _isInitiatorButton:Boolean;
		
		public function MicrophoneVolumeChangeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, vol:Number = 0, isInitiatorButton:Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this._vol = vol;
			this._isInitiatorButton = isInitiatorButton;
		}
	}
}