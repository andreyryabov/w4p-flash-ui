package components
{
	import components.events.SoundChangeEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class SoundSlider extends Sprite
	{
		private var _holder:Sprite;
		
		private var _iconBackground:Sprite;
		[Embed(source="assets/device_button.png")]
		private var _backgroundAsset:Class;
		
		private var _iconOverBackground:Sprite;
		[Embed(source="assets/device_button_over.png")]
		private var _backgroundOverAsset:Class;
		
		private var _iconHolder:Sprite;
		[Embed(source="assets/sound_speaker.png")]
		private var _icon:Class;
		
		private var _iconOverSprite:Sprite;
		
		private var _trackBackground:Sprite;
		[Embed(source="assets/device_track.png")]
		private var _trackAsset:Class;
		
		private var _thumbHolder:Sprite;
		[Embed(source="assets/device_track_thumb.png")]
		private var _thumbAsset:Class;
		
		private var _thumbOverSprite:Sprite;
		
		private var _soundFlag:Boolean = true;
		private var _thumbPosition:Number;
		
		public function SoundSlider()
		{
			_holder = new Sprite();
			addChild(_holder);
			
			
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
			
			
			_trackBackground = new Sprite();
			_trackBackground.addChild(new _trackAsset());
			_holder.addChild(_trackBackground);
			
			_trackBackground.x = 28;
			_trackBackground.y = 5;
			_trackBackground.addEventListener(MouseEvent.CLICK, handleTrackClick);
			
			
			_thumbHolder = new Sprite();
			_thumbHolder.addChild(new _thumbAsset());
			_holder.addChild(_thumbHolder);
			
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
		}
		
		public function setVolume(_num:Number):void
		{
			_thumbHolder.x = 28 + _num * 154/100;
		}
		
		private function handleIconClick(event:MouseEvent):void
		{
			if(_soundFlag)
			{
				_soundFlag = false;
				_thumbPosition = _thumbHolder.x;
				_thumbHolder.x = 28;
				
				var _volume1:Number = 100 * (_thumbHolder.x - 28)/154;
				
				this.dispatchEvent(new SoundChangeEvent(SoundChangeEvent.SOUND_CHANGE_EVENT, true, false, _volume1));
			}
			else
			{
				_soundFlag = true;
				_thumbHolder.x = _thumbPosition;
				
				var _volume2:Number = 100 * (_thumbHolder.x - 28)/154;
				
				this.dispatchEvent(new SoundChangeEvent(SoundChangeEvent.SOUND_CHANGE_EVENT, true, false, _volume2));
			}
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
			
			_soundFlag = true;
			
			this.dispatchEvent(new SoundChangeEvent(SoundChangeEvent.SOUND_CHANGE_EVENT, true, false, _volume));
		}
		
		private function handleThumbDown(event:MouseEvent):void
		{
			this.stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
		}
		
		private function handleMouseUp(event:MouseEvent):void
		{
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			
			var _volume:Number = 100 * (_thumbHolder.x - 28)/154; 
			
			_soundFlag = true;
			
			this.dispatchEvent(new SoundChangeEvent(SoundChangeEvent.SOUND_CHANGE_EVENT, true, false, _volume));
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