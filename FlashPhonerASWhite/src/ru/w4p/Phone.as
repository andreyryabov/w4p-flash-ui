package ru.w4p {
    import flash.events.*;
    import flash.media.Microphone;
    import flash.media.SoundTransform;
    import flash.net.NetStream;
    
    import ru.w4p.net.Connection;
    import ru.w4p.util.*;

    public class Phone extends EventDispatcher {
        private static const log:TLogger = TLogger.getLogger("Phone");
        private var servers  :Array;
        private var connect  :Connection; 
        private var number   :String;
        private var accountId:String;
        private var security :String;
        private var input    :NetStream;
        private var output   :NetStream;
        private var config   :Object;
        private var volume   :Number = 0.75;
        private var mic      :Microphone;
        
        public function Phone()
		{
			
        }
        
        public function setServers(addrs:Array):Phone 
		{
            this.servers = addrs;
            return this;
        }
        
        public function setNumber(number:String):Phone
		{
            this.number = number;
            return this;
        }
        
        public function setAccountId(accountId:String):Phone
		{
            this.accountId = accountId;
            return this;
        }
        
        public function setSecurity(security:String):Phone 
		{
            this.security = security;
            return this;
        }
        
        public function setVolume(v:Number):Phone
		{            
            this.volume = Utils.range(v, 0, 1);
			
            if (input != null)
			{                
                input.soundTransform = new SoundTransform(volume);
                log.debug("setVolume: " + v);
            }
			
            return this;
        }
        
        public function getVolume():Number
		{
            return volume;
        }
        
        public function getMicrophone():Microphone
		{
            return mic;
        }
        
        public function setMicrophone(mic:Microphone):Phone
		{
            this.mic = mic;
			
            if (output != null) {
                output.attachAudio(null);
                if (mic) {                    
                    log.debug("attach mic: " + mic.name);
                    mic.codec = "speex";
                    mic.framesPerPacket = 2;
                    mic.encodeQuality = 8;
                    output.attachAudio(mic);
                }
            }
			
            return this;
        }
        
        public function call():Phone 
		{
            connect = new Connection(servers, "phone", ["rtmfp", "rtmp"]);
            connect.connect();
            connect.onConnected.join(dial);
            connect.onClosed.join(onError, "connect.closed");
            connect.onError.join(onError);
            return this;
        }
        
        public function dtmf(digits:String):Phone
		{
            connect.invoke("phone_dtmf", null, digits);
            return this;
        }
        
        public function close():void 
		{
            connect.close();
        }
        
        private function dial():void
		{
            connect.netConnect.client = {
                "phone_ringing" : onRinging,
                "phone_answered": onAnswered,
                "phone_busy"    : onBusy,
                "phone_hangup"  : onHangup,
                "phone_error"   : onError
            };

            connect.invoke("phone_call", function(r:Object):* {
                if (r["status"] == "error") {
                    onError(r["details"]);                  
                } else {
                    config = r["config"];
                }
            }, accountId, number, security);
        }
        
        private function onRinging():void
		{
            log.info("ringing");

            input = new NetStream(connect.netConnect);
            input.bufferTime = 0;
//          input.bufferTimeMax = 0.5;
            input.play(config["sip2flash"]);
            setVolume(volume);
            
            dispatchEvent(new PhoneEvent(PhoneEvent.RINGING));
        }
        
        private function onAnswered():void
		{
            log.info("answered");            
            
            output = new NetStream(connect.netConnect);
            output.publish(config["flash2sip"], "live");
            setMicrophone(mic);
            
            dispatchEvent(new PhoneEvent(PhoneEvent.ANSWERED));
        }
        
        private function onBusy():void
		{
            log.info("busy");
            dispatchEvent(new PhoneEvent(PhoneEvent.BUSY));
        }
        
        private function onHangup():void
		{
            log.info("hangup");            
            dispatchEvent(new PhoneEvent(PhoneEvent.HANGUP));
        }
        
        private function onError(reason:*):void 
		{
            log.error("server error: " + reason);
            dispatchEvent(new PhoneEvent(PhoneEvent.ERROR));
        }
    }
}