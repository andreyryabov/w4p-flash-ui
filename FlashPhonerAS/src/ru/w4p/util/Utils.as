package ru.w4p.util {
    
    import flash.events.TimerEvent;
    import flash.system.*;
    import flash.utils.Timer;
    
    public class Utils {
        public static var PLATFORM:String;
        public static var V_MAJOR:int;
        public static var V_MINOR:int;
              
        private static function _s_init():* {
            var a:Array = Capabilities.version.split(" ");
            PLATFORM = a[0];
            a = a[1].split(",");
            V_MAJOR = parseInt(a[0]);
            V_MINOR = parseInt(a[1]);
            return null;
        }        
        private static var __init:* = _s_init();
        
        public function Utils() {
        }
        
        public static function isFlashCompatible(major:Number, minor:Number):Boolean {
            return major < V_MAJOR || (major == V_MAJOR && minor <= V_MINOR);            
        }        
        
        public static function range(v:Number, min:Number, max:Number):Number {
            if (v < min) {
                return min;
            }
            if (v > max) {
                return max;
            }
            return v;
        }
        
        public static function trim(s:String):String {
            return s.replace(/^\s+|\s+$/gs, '');
        }
        
        public static function timeout(f:Function, timeout:Number):Timer {
            var t:Timer = new Timer(timeout, 1);
            t.addEventListener(TimerEvent.TIMER, f);
            t.start();
            return t;
        }
        
        public static function interval(f:Function, interval:Number):Timer {
            var t:Timer = new Timer(interval);
            t.addEventListener(TimerEvent.TIMER, f);
            t.start();
            return t;
        }
        
        public static function object(...params):Object {
            var object:Object = {};
            for (var i:int = 0; i < params.length / 2; i++ ) {
                object[params[i * 2]] = params[i * 2 + 1];
            }
            return object;
        }
		
		public static function clone(obj:Object):Object {
			if (obj == null) {
				return null;
			}
			var rObj:Object = {};
			for (var k:String in obj) {
				rObj[k] = obj[k];
			}
			return rObj;
		}	
		
		public static function toStr(obj:*):String {
			if (obj == null) {
				return "null";
			}
			if (obj is Array) {
				return toStrArray(obj);
			}
			if (obj is Object) {
				return toStrObj(obj);
			}
			return "unknown: " + obj;
		}
		
		public static function toStrArray(array:*):String {
			if (array == null) {
				return "null";
			}
			var s:String = "[";
			var comma:Boolean = false;
			for (var i:int = 0; i < array.length; i++ ) {
				if (comma) {
					s += ", "
				} else {
					comma = true;
				}
				s += _toStr(array[i]);
			}
			return s + "]";
		}
		
		public static function toStrObj(obj:Object):String {
			if (obj == null) {
				return "null";
			}
			var str:String = "{";	
			var comma:Boolean = false;
			for (var n:String in obj) {
				var v:Object = obj[n];
				if (comma) {
					str += ", ";
				} else {
					comma = true;
				}
				str += "\"" + n + "\": " + _toStr(v);
			}
			return str + "}";
		}
		
		private static function _toStr(v:*):String {
			if (v == null) {
				return "null";
			} else if (v is Array) {
				return toStrArray(v);
			} else if (v is String) {
				if (v.length > 100) {
					v = v.substring(0, 97) + "...";
				}
				return "\"" + v + "\"";
			} else if (v is Number) {
				return "" + v;
			} else if (v is Boolean) {
				return "" + v;
			} else if (v is Object) {
				return toStrObj(v);
			}
			return "TODO:";
		} 
    }
}