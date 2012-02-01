package ru.w4p.util {
    import org.osflash.thunderbolt.Logger;

    public class TLogger {
        public static const DEBUG: int = 0;
        public static const INFO:  int = 1;
        public static const WARN:  int = 2;
        public static const ERROR: int = 3;
        public static const FATAL: int = 4;
        public static const OFF:   int = 5;

        private static var minLevel: int = OFF;
		private static var callback:Function;
        
        private var category:String;
        
        public static function setLogLevel(level:int):void {
            minLevel = level;
        }

        public static function getLogLevel():int {
            return minLevel;
        }
        
        public static function getLogger(category:String): TLogger {
            return new TLogger(category);
        }
        
        public function TLogger(category:String):void {
            this.category = category;
        }
		
		public static function setCallback(cb:Function):void {
			callback = cb;
		}
        
        private function doLog(level: int, logFn: Function, msg: String, args:Array):void {
            if (level >= minLevel) {
                msg = category + Logger.FIELD_SEPERATOR + msg;
                for (var i:int = 0; i < args.length; i++) {
                    msg = msg.replace(new RegExp("\\{"+i+"\\}", "g"), args[i]);
                }
                
                logFn.apply(null, [msg]);
				if (callback != null) {
					callback(msg);
				}
            }
        }
        
        public function debug(msg:String, ... rest):void {
            doLog(DEBUG, Logger.debug, msg, rest);
        }

        public function info(msg:String, ... rest):void {
            doLog(INFO, Logger.info, msg, rest);
        }
        
        public function warn(msg:String, ... rest):void {
            doLog(WARN, Logger.warn, msg, rest);
        }

        public function error(msg:String, ... rest):void {
            doLog(ERROR, Logger.error, msg, rest);
        }
    }
}