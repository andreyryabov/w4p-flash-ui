package ru.w4p.util {    
    
    public class ActionState {
        private static const log:TLogger = TLogger.getLogger("ActionState");
        private var name:String;
        private var actions:Array = [];
        private var params:Array  = [];
        private var entered:Boolean = false;
        
        public function ActionState(name:String) {
            this.name = name;
        }
		
		public function isOn():Boolean {
			return entered;
		}
        
        public function await():Boolean {
            return this.actions.length > 0; 
        }
        
        public function enter():void {
            if (this.entered) {
                return;
            }
            log.debug("enter state: " + this.name);
            this.entered = true;
            for (var i:int = 0; i < this.actions.length; i++ ) {
                activate(this.actions[i], this.params[i]);
            }      
        }
        
        public function joinState(action:ActionState):Boolean {
            return join(function(a:ActionState):void {a.enter();}, action);
        }
        
        public function join(action:Function, param:Object=null):Boolean {
            if (this.entered) {
                activate(action, param);
            } else {
                this.actions.push(action);
                this.params.push(param);
            }
            return this.entered;
        }
        
        public function reset():void {
            entered = false;
        }
        
        private function activate(action:Function, param:*):void {
            if (action.length > 0) {
                action(param)
            } else {
                action();
            }
        }
    }
}