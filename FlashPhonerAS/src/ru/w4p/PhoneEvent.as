package ru.w4p {
    import flash.events.Event;
    
    public class PhoneEvent extends Event {
        public static const ERROR   :String = "PhoneEvent.ERROR";
        public static const RINGING :String = "PhoneEvent.RINGING";
        public static const ANSWERED:String = "PhoneEvent.ANSWERED";
        public static const BUSY    :String = "PhoneEvent.BUSY";
        public static const HANGUP  :String = "PhoneEvent.HANGUP";       
        
        public function PhoneEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
            super(type, bubbles, cancelable);
        }
    }
}