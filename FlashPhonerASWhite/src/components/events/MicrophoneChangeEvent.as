package components.events
{
	import flash.events.Event;
	
	public class MicrophoneChangeEvent extends Event
	{
		public static var MICROPHONE_CHANGE_EVENT:String = "MicrophoneChangeEvent";
		public var _index:uint;
		
		public function MicrophoneChangeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, ind:uint = 0)
		{
			super(type, bubbles, cancelable);
			
			_index = ind;
		}
	}
}