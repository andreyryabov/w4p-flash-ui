package ru.w4p.net {
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	
	import ru.w4p.util.*;
	
	public class Connection {
		private static const log:TLogger = TLogger.getLogger("Connection");
		        
        private var url       :String;
        private var urls      :Array = [];
        private var conns	  :Array = [];
        private var timer     :Timer;        
        
        public var netConnect :NetConnection;
        public var nearPeerId :String;
        public var onConnected:ActionState = new ActionState("Connection.onConnected");
        public var onClosed   :ActionState = new ActionState("Connection.onClosed");
        public var onError    :ActionState = new ActionState("Connection.onError");
        
        public function Connection(addrs:Array, app:String, protos:Array) {            
            for (var i:int = 0; i < protos.length; i++ ) {
                for (var j:int = 0; j < addrs.length; j++ ) {
                    urls.push(protos[i] + "://" + addrs[j] + "/" + app);
                }
            }
        }
        
        public function connect():Connection {
            tryConn();
            if (urls.length > 0) {
                timer = Utils.interval(function():void { tryConn(); }, 700);
            }
            return this;
        }
        
        public function close():void {
            if (netConnect != null) {
                netConnect.close();
            }
            closeEx();
        }
        
        private function closeEx(c:Object = null):void {
            for (var i:int = 0; i < conns.length; i++ ) {
                conns[i].active = false;                        
                if (conns[i] != c) {
                    conns[i].nc.close();;
                }
            }
            conns = [];
        }
        
        private function tryConn():void {
            var url:String = urls.shift();            
            if (urls.length == 0) {
                if (timer != null) {
                    timer.stop();
                }               
                timer = Utils.timeout(onTimeout, 10000);
            }
            var pc:Object = protoConnect(url, 
                function(c:Object):void {
                    log.debug("connected: " + url);
                    if (timer != null) {
                        timer.stop();
                    }
                    closeEx(c);
                    url = c.url;
                    netConnect = c.nc;
                    netConnect.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
                    netConnect.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onNetError);
                    netConnect.addEventListener(IOErrorEvent.IO_ERROR, onNetError);
                    onConnected.enter();                    
                },
                function(c:Object):void {
                    log.warn("failed to connect: " + c.url);
                    c.active = false;
                    c.nc.close();
                    conns = conns.filter(function(i:*, index:int, array:Array):Boolean { 
                        return i != c;   
                    }, null);
                    if (conns.length == 0 && urls.length == 0) {
                        log.error("connect failed due to no more attempts");
                        onError.enter();
                        if (timer != null) {
                            timer.stop();
                        }
                    }
                }
            );
            conns.push(pc);
        }
        
        private function onTimeout(e:*):void {
            closeEx();
            log.error("connect failed by timeout");
            onError.enter();
        }        
        
        private function protoConnect(u:String, succeed:Function, failed:Function):Object {
            var pc:Object = {
                url         : u,
                active      : true, 
                onNetStatus : function(event:NetStatusEvent):void {
                    if (!pc.active) {
                        return;
                    }
                    log.debug("try.netStatus: " + event.info["code"] + ", url: " + pc.url);
                    switch (event.info["code"]) {
                        case "NetConnection.Connect.Success":
                            succeed(pc);
                            break;                        
                        case "NetConnection.Connect.Failed":
                            failed(pc);
                            break;
                        case "NetConnection.Connect.Closed":
                            break;
                    }
                },
                onNetError  : function(event:ErrorEvent):void {
                    if (!pc.active) {
                        return;
                    }
                    log.debug("try.netError: " + event + ", url: " + pc.url);
                    failed(pc);
                }
            }
            var nc:NetConnection = new NetConnection();
            nc.addEventListener(NetStatusEvent.NET_STATUS, pc.onNetStatus);
            nc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, pc.onNetError);
            nc.addEventListener(IOErrorEvent.IO_ERROR, pc.onNetError);			
            pc.nc = nc;
            log.debug("connecting to: " + pc.url + "...");
            nc.connect(pc.url);
            return pc;
        }		
        
        public function invoke(name:String, callback:Function, ...params):void {
            if (!onConnected.isOn()) {
                log.error("invoke failed - not connected: " + name);
                throw new Error("invoke failed - not connected");
            }
            log.debug(">invoke->: {0}, params: {1}", name, Utils.toStr(params));
            var cb:Function = function(result:*):void {
                log.debug("<-invoke<: {0}, result: {1}", name, Utils.toStr(result));
                if (callback != null) {
                    callback(result);
                }
            }
            netConnect.call.apply(netConnect, new Array(name, new Responder(cb, null)).concat(params));
        }
        
        private function onNetStatus(event:NetStatusEvent):void{
            log.debug("onNetStatus: " + event.info.code);
            if (event.info["code"] == "NetConnection.Connect.Success") {
                nearPeerId = netConnect.nearID;
                onConnected.enter();
            }
            if (event.info["code"] == "NetConnection.Connect.Closed") {
                onClosed.enter();
            }
        }
        
        private function onNetError(event:ErrorEvent):void {
            log.debug("onNetError: " + event);
        }
        
        public function toString():String {
            return url + ", peerId: " + nearPeerId;
        }
	}
}