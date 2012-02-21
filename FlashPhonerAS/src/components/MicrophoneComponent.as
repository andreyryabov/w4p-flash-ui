package components
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
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
		
		private var _iconClickedBackground:Sprite;
		[Embed(source="assets/device_button_clicked.png")]
		private var _backgroundClickedAsset:Class;
		
		private var _iconHolder:Sprite;
		[Embed(source="assets/microphone_icon.png")]
		private var _icon:Class;
		
		private var _disabledHolder:Sprite;
		[Embed(source="assets/microphone_disabled.png")]
		private var _disabledAsset:Class;
		
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
		private var _trackMask:Sprite;
		
		private var _trackNormal:Sprite;
		[Embed(source="assets/device_track.png")]
		private var _trackNormalAsset:Class;
		
		private var _trackHighlighted:Sprite;
		[Embed(source="assets/device_track_highlighted.png")]
		private var _trackHighlightedAsset:Class;
		
		
		private var _thumbHolder:Sprite;
		
		private var _thumbNormalHolder:Sprite;
		[Embed(source="assets/device_track_thumb.png")]
		private var _thumbNormalAsset:Class;
		
		private var _thumbOverHolder:Sprite;
		[Embed(source="assets/device_track_thumb_over.png")]
		private var _thumbOverAsset:Class;
		
		private var _thumbClickedHolder:Sprite;
		[Embed(source="assets/device_track_thumb_clicked.png")]
		private var _thumbClickedAsset:Class;
		
		private var _thumbOverSprite:Sprite;
		
		private var _microphoneFlag:Boolean = true;
		private var _thumbPosition:Number = 28 + 50 * 154/100;
		
		private var _microphoneArray:Array;
		private var _microphoneChoose:MicrophoneChoose;
		
		public function MicrophoneComponent(arr:Array, _ind:int)
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
			
			
			_iconClickedBackground = new Sprite();
			_iconClickedBackground.addChild(new _backgroundClickedAsset());
			_iconClickedBackground.visible = false;
			_holder.addChild(_iconClickedBackground);
			
			
			_iconHolder = new Sprite();
			_iconHolder.addChild(new _icon());
			_iconHolder.x = 4;
			_iconHolder.y = 4;
			_holder.addChild(_iconHolder);
			
			
			_disabledHolder = new Sprite();
			_disabledHolder.addChild(new _disabledAsset());
			_disabledHolder.visible = false;
			_holder.addChild(_disabledHolder);
			
			
			_iconOverSprite = new Sprite();
			_iconOverSprite.graphics.beginFill(0xff0000, 0);
			_iconOverSprite.graphics.drawCircle(0, 0, 11);
			_iconOverSprite.x = 12;
			_iconOverSprite.y = 12;
			_iconOverSprite.buttonMode = true;
			_iconOverSprite.addEventListener(MouseEvent.CLICK, handleIconClick);
			_iconOverSprite.addEventListener(MouseEvent.MOUSE_OVER, handleIconOver);
			_iconOverSprite.addEventListener(MouseEvent.MOUSE_OUT, handleIconOut);
			_iconOverSprite.addEventListener(MouseEvent.MOUSE_DOWN, handleIconDown);
			_iconOverSprite.addEventListener(MouseEvent.MOUSE_UP, handleIconUp);
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
			_trackBackground.x = 28;
			_trackBackground.y = 5;
			_trackBackground.addEventListener(MouseEvent.CLICK, handleTrackClick);
			_sliderHolder.addChild(_trackBackground);
			
			_trackNormal = new Sprite();
			_trackNormal.addChild(new _trackNormalAsset());
			_trackBackground.addChild(_trackNormal);
			
			_trackMask = new Sprite();
			_trackMask.graphics.beginFill(0xff0000, 1);
			_trackMask.graphics.drawRect(0, 0, 100, 13);
			_trackMask.graphics.endFill();
			
			_trackMask.width = _thumbPosition - 28;
			
			_trackBackground.addChild(_trackMask);
			
			_trackHighlighted = new Sprite();
			_trackHighlighted.addChild(new _trackHighlightedAsset());
			_trackBackground.addChild(_trackHighlighted);
			_trackHighlighted.mask = _trackMask;
			
			
			_thumbHolder = new Sprite();
			
			_thumbHolder.x = 28;
			_thumbHolder.y = 3;
			
			_sliderHolder.addChild(_thumbHolder);
			
			_thumbNormalHolder = new Sprite();
			_thumbNormalHolder.addChild(new _thumbNormalAsset());
			_thumbNormalHolder.visible = false;
			_thumbHolder.addChild(_thumbNormalHolder);
			
			
			_thumbOverHolder = new Sprite();
			_thumbOverHolder.addChild(new _thumbOverAsset());
			_thumbOverHolder.visible = false;
			_thumbHolder.addChild(_thumbOverHolder);
			
			
			_thumbClickedHolder = new Sprite();
			_thumbClickedHolder.addChild(new _thumbClickedAsset());
			_thumbClickedHolder.visible = false;
			_thumbHolder.addChild(_thumbClickedHolder);
			
			
			_thumbNormalHolder.visible = true;
			
			_thumbOverSprite = new Sprite();
			_thumbOverSprite.graphics.beginFill(0xff0000, 0);
			_thumbOverSprite.graphics.drawCircle(0, 0, 9);
			_thumbOverSprite.graphics.endFill();
			_thumbOverSprite.buttonMode = true;
			_thumbOverSprite.x = 10;
			_thumbOverSprite.y = 10;
			_thumbOverSprite.addEventListener(MouseEvent.MOUSE_OVER, handleThumbOver);
			_thumbOverSprite.addEventListener(MouseEvent.MOUSE_OUT, handleThumbOut);
			_thumbOverSprite.addEventListener(MouseEvent.MOUSE_DOWN, handleThumbDown);
			_thumbOverSprite.addEventListener(MouseEvent.MOUSE_UP, handleThumbUp);
			_thumbHolder.addChild(_thumbOverSprite);
			
			
			_microphoneChoose = new MicrophoneChoose(_microphoneArray, _ind);
			_microphoneChoose.x = 0;
			_microphoneChoose.y = -96;
			_microphoneChoose.visible = false;
			_holder.addChild(_microphoneChoose);
		}
		
		public function setGain(_num:Number):void
		{
			_thumbHolder.x = 28 + _num * 154/100;
			
			_trackMask.width = _thumbHolder.x - 28;
		}
		
		public function setDisableState():void
		{
			_microphoneFlag = false;
			_disabledHolder.visible = true;
		}
		
		public function setIndicator(_value:Number):void
		{
			_indicatorMask.width = 176 * _value / 100;
		}
		
		public function goToSettingsState():void
		{
//			TweenMax.to(_indicatorBackground, 0.5, {y:-14, ease:Expo.easeOut});
			
			_indicatorBackground.y = -14;
			
//			_sliderHolder.alpha = 0;
//			_microphoneChoose.alpha = 0;
			
			_sliderHolder.visible = true;
			_microphoneChoose.visible = true;
			
//			TweenMax.to(_sliderHolder, 1, {alpha:1, ease:Expo.easeOut});
//			TweenMax.to(_microphoneChoose, 1, {alpha:1, ease:Expo.easeOut});
		}
		
		public function goToNormalState():void
		{
//			TweenMax.to(_indicatorBackground, 0.5, {y:9, ease:Expo.easeOut});
			
			_indicatorBackground.y = 9;
			
			_sliderHolder.visible = false;
			_microphoneChoose.visible = false;
			
//			TweenMax.to(_sliderHolder, 1, {alpha:0, ease:Expo.easeOut, onComplete:hideSlider});
//			TweenMax.to(_microphoneChoose, 1, {alpha:0, ease:Expo.easeOut});
		}
		
//		private function hideSlider():void
//		{
//			_sliderHolder.visible = false;
//			_microphoneChoose.visible = false;
//		}
		
		private function handleIconClick(event:MouseEvent):void
		{
			if(_microphoneFlag)
			{
				_microphoneFlag = false;
				_disabledHolder.visible = true;
				
				_thumbPosition = _thumbHolder.x;
				_thumbHolder.x = 28;
				
				_trackMask.width = _thumbHolder.x - 28;
				
				var _volume1:Number = 100 * (_thumbHolder.x - 28)/154;
				
				this.dispatchEvent(new MicrophoneVolumeChangeEvent(MicrophoneVolumeChangeEvent.MICROPHONE_VOLUME_CHANGE_EVENT, true, false, _volume1, true));
			}
			else
			{
				_microphoneFlag = true;
				_disabledHolder.visible = false;
				
				_thumbHolder.x = _thumbPosition;
				
				_trackMask.width = _thumbHolder.x - 28;
				
				var _volume2:Number = 100 * (_thumbHolder.x - 28)/154;
				
				this.dispatchEvent(new MicrophoneVolumeChangeEvent(MicrophoneVolumeChangeEvent.MICROPHONE_VOLUME_CHANGE_EVENT, true, false, _volume2, false));
			}
		}
		
		private function handleIconOver(event:MouseEvent):void
		{
			_iconClickedBackground.visible = false;
			_iconBackground.visible = false;
			_iconOverBackground.visible = true;
		}
		
		private function handleIconOut(event:MouseEvent):void
		{
			_iconClickedBackground.visible = false;
			_iconBackground.visible = true;
			_iconOverBackground.visible = false;
		}
		
		private function handleIconDown(event:MouseEvent):void
		{
			_iconClickedBackground.visible = true;
			_iconBackground.visible = false;
			_iconOverBackground.visible = false;
		}
		
		private function handleIconUp(event:MouseEvent):void
		{
			_iconClickedBackground.visible = false;
			_iconBackground.visible = false;
			_iconOverBackground.visible = true;
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
			
			_trackMask.width = _thumbHolder.x - 28;
		
			var _volume:Number = 100 * (_thumbHolder.x - 28)/154; 
			
			_microphoneFlag = true;
			_disabledHolder.visible = false;
			
			this.dispatchEvent(new MicrophoneVolumeChangeEvent(MicrophoneVolumeChangeEvent.MICROPHONE_VOLUME_CHANGE_EVENT, true, false, _volume, false));
		}
		
		private function handleThumbOver(event:MouseEvent):void
		{
			_thumbNormalHolder.visible = false;
			_thumbOverHolder.visible = true;
			_thumbClickedHolder.visible = false;
		}
		
		private function handleThumbOut(event:MouseEvent):void
		{
			_thumbNormalHolder.visible = true;
			_thumbOverHolder.visible = false;
			_thumbClickedHolder.visible = false;
		}
		
		private function handleThumbDown(event:MouseEvent):void
		{
			this.stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
			
			_thumbNormalHolder.visible = false;
			_thumbOverHolder.visible = false;
			_thumbClickedHolder.visible = true;
		}
		
		private function handleThumbUp(event:MouseEvent):void
		{
			_thumbNormalHolder.visible = false;
			_thumbOverHolder.visible = true;
			_thumbClickedHolder.visible = false;
		}
		
		private function handleMouseUp(event:MouseEvent):void
		{
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			
			var _volume:Number = 100 * (_thumbHolder.x - 28)/154; 
			
			_microphoneFlag = true;
			_disabledHolder.visible = false;
			
			this.dispatchEvent(new MicrophoneVolumeChangeEvent(MicrophoneVolumeChangeEvent.MICROPHONE_VOLUME_CHANGE_EVENT, true, false, _volume, false));
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
			
			_trackMask.width = _thumbHolder.x - 28;
		}
	}
}