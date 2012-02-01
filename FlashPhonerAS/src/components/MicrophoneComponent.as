package components
{
	import components.events.MicrophoneVolumeChangeEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class MicrophoneComponent extends Sprite
	{
		private var _holder:Sprite;
		
		private var _iconBackground:Sprite;
		[Embed(source="assets/device_button.png")]
		private var _backgroundAsset:Class;
		
		private var _iconOverBackground:Sprite;
		[Embed(source="assets/device_button_over.png")]
		private var _backgroundOverAsset:Class;
		
		private var _iconHolder:Sprite;
		[Embed(source="assets/microphone_icon.png")]
		private var _icon:Class;
		
		private var _iconOverSprite:Sprite;
		
		private var _indicatorBackground:Sprite;
		[Embed(source="assets/microphone_indicator.png")]
		private var _indicatorAsset:Class;
		
		private var _indicatorProgress:Sprite;
		[Embed(source="assets/microphone_indicator_progress.png")]
		private var _indicatorProgressAsset:Class;
		
		private var _indicatorMask:Sprite;
		
		private var _sliderHolder:Sprite;
		
		private var _trackBackground:Sprite;
		[Embed(source="assets/device_track.png")]
		private var _trackAsset:Class;
		
		private var _thumbHolder:Sprite;
		[Embed(source="assets/device_track_thumb.png")]
		private var _thumbAsset:Class;
		
		private var _thumbOverSprite:Sprite;
		
		private var _microphoneArray:Array;
		private var _microphoneChoose:MicrophoneChoose;
		
		public function MicrophoneComponent(arr:Array)
		{
			_holder = new Sprite();
			addChild(_holder);
			
			_microphoneArray = arr;
			
			
			_iconBackground = new Sprite();
			_iconBackground.addChild(new _backgroundAsset());
			_iconBackground.visible = false;
			_holder.addChild(_iconBackground);
			
			
			_iconOverBackground = new Sprite();
			_iconOverBackground.addChild(new _backgroundOverAsset());
			_iconOverBackground.visible = false;
			_holder.addChild(_iconOverBackground);
			
			
			_iconHolder = new Sprite();
			_iconHolder.addChild(new _icon());
			_iconHolder.x = 4;
			_iconHolder.y = 4;
			_holder.addChild(_iconHolder);
			
			
			_iconOverSprite = new Sprite();
			_iconOverSprite.graphics.beginFill(0xff0000, 0);
			_iconOverSprite.graphics.drawCircle(0, 0, 11);
			_iconOverSprite.x = 12;
			_iconOverSprite.y = 12;
			_iconOverSprite.buttonMode = true;
			_iconOverSprite.addEventListener(MouseEvent.CLICK, handleIconClick);
			_iconOverSprite.addEventListener(MouseEvent.MOUSE_OVER, handleIconOver);
			_iconOverSprite.addEventListener(MouseEvent.MOUSE_OUT, handleIconOut);
			_holder.addChild(_iconOverSprite);
			
			_iconBackground.visible = true;
			
			
			_indicatorBackground = new Sprite();
			_indicatorBackground.addChild(new _indicatorAsset());
			_holder.addChild(_indicatorBackground);
			
			_indicatorBackground.x = 27;
			_indicatorBackground.y = 9;
			
			
			_indicatorProgress = new Sprite();
			_indicatorProgress.addChild(new _indicatorProgressAsset());
			_indicatorBackground.addChild(_indicatorProgress);
			
			_indicatorProgress.x = 1;
			_indicatorProgress.y = 2;
			
			
			_indicatorMask = new Sprite();
			_indicatorMask.graphics.beginFill(0xff0000, 1);
			_indicatorMask.graphics.drawRect(0, 0, 100, 100);
			_indicatorMask.width = 0;
			_indicatorMask.height = 7;
			_indicatorMask.x = 1;
			_indicatorMask.y = 0;
			_indicatorBackground.addChild(_indicatorMask);
			
			_indicatorProgress.mask = _indicatorMask;
			
			
			_sliderHolder = new Sprite();
			_sliderHolder.visible = false;
			_holder.addChild(_sliderHolder);
			
			
			_trackBackground = new Sprite();
			_trackBackground.addChild(new _trackAsset());
			_sliderHolder.addChild(_trackBackground);
			
			_trackBackground.x = 28;
			_trackBackground.y = 5;
			_trackBackground.addEventListener(MouseEvent.CLICK, handleTrackClick);
			
			
			_thumbHolder = new Sprite();
			_thumbHolder.addChild(new _thumbAsset());
			_sliderHolder.addChild(_thumbHolder);
			
			_thumbHolder.x = 28;
			_thumbHolder.y = 3;
			
			
			_thumbOverSprite = new Sprite();
			_thumbOverSprite.graphics.beginFill(0xff0000, 0);
			_thumbOverSprite.graphics.drawCircle(0, 0, 9);
			_thumbOverSprite.graphics.endFill();
			_thumbOverSprite.buttonMode = true;
			_thumbOverSprite.x = 10;
			_thumbOverSprite.y = 10;
			_thumbOverSprite.addEventListener(MouseEvent.MOUSE_DOWN, handleThumbDown);
			_thumbHolder.addChild(_thumbOverSprite);
			
			
			_microphoneChoose = new MicrophoneChoose(_microphoneArray);
			_microphoneChoose.x = 0;
			_microphoneChoose.y = -96;
			_microphoneChoose.visible = false;
			_holder.addChild(_microphoneChoose);
		}
		
		public function setGain(_num:Number):void
		{
			_thumbHolder.x = 28 + _num * 154/100;
		}
		
		public function setIndicator(_value:Number):void
		{
			_indicatorMask.width = 176 * _value / 100;
		}
		
		public function goToSettingsState():void
		{
			_indicatorBackground.y = -14;
			
			_sliderHolder.visible = true;
			_microphoneChoose.visible = true;
		}
		
		public function goToNormalState():void
		{
			_indicatorBackground.y = 9;
			
			_sliderHolder.visible = false;
			_microphoneChoose.visible = false;
		}
		
		private function handleIconClick(event:MouseEvent):void
		{
			
		}
		
		private function handleIconOver(event:MouseEvent):void
		{
			_iconBackground.visible = false;
			_iconOverBackground.visible = true;
		}
		
		private function handleIconOut(event:MouseEvent):void
		{
			_iconBackground.visible = true;
			_iconOverBackground.visible = false;
		}
		
		private function handleTrackClick(event:MouseEvent):void
		{
			if(_trackBackground.mouseX <= 10)
			{
				_thumbHolder.x = 28;
			}
			else if(_trackBackground.mouseX >= 164)
			{
				_thumbHolder.x = 28 + 154;
			}
			else
			{
				_thumbHolder.x = 28 - 10 +  _trackBackground.mouseX;
			}
		
			var _volume:Number = 100 * (_thumbHolder.x - 28)/154; 
			
			this.dispatchEvent(new MicrophoneVolumeChangeEvent(MicrophoneVolumeChangeEvent.MICROPHONE_VOLUME_CHANGE_EVENT, true, false, _volume));
		}
		
		private function handleThumbDown(event:MouseEvent):void
		{
			this.stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
		}
		
		private function handleMouseUp(event:MouseEvent):void
		{
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
			
			var _volume:Number = 100 * (_thumbHolder.x - 28)/154; 
			
			this.dispatchEvent(new MicrophoneVolumeChangeEvent(MicrophoneVolumeChangeEvent.MICROPHONE_VOLUME_CHANGE_EVENT, true, false, _volume));
		}
		
		private function handleMouseMove(event:MouseEvent):void
		{
			if(_trackBackground.mouseX <= 10)
			{
				_thumbHolder.x = 28;
			}
			else if(_trackBackground.mouseX >= 164)
			{
				_thumbHolder.x = 28 + 154;
			}
			else
			{
				_thumbHolder.x = 28 - 10 +  _trackBackground.mouseX;
			}
		}
	}
}