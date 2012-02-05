package components
{
	import components.events.MicrophoneChangeEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class MicrophoneChoose extends Sprite
	{
		private var _holder:Sprite;
		
		private var _microphoneChoose:Sprite;
		[Embed(source="assets/microphone_choose.png")]
		private var _microphoneChooseAsset:Class;
		
		private var _microphoneChooseOver:Sprite;
		[Embed(source="assets/microphone_choose_over.png")]
		private var _microphoneChooseOverAsset:Class;
		
		private var _textFormat:TextFormat;
		private var _textField:TextField;
		
		private var _chooserOverSprite:Sprite;
		
		private var _microphoneArray:Array;
		private var _dropDownList:Sprite;
		
		private var _array:Array = new Array();
		private var _currentIndex:int;
		
		public function MicrophoneChoose(arr:Array, _ind:int)
		{
			_microphoneArray = arr;
			_currentIndex = _ind;
			
			_holder = new Sprite();
			addChild(_holder);
			
			_microphoneChoose = new Sprite();
			_microphoneChoose.addChild(new _microphoneChooseAsset());
			_microphoneChoose.visible = false;
			_holder.addChild(_microphoneChoose);
			
			_microphoneChooseOver = new Sprite();
			_microphoneChooseOver.addChild(new _microphoneChooseOverAsset());
			_microphoneChooseOver.visible = false;
			_holder.addChild(_microphoneChooseOver);
			
			_microphoneChoose.visible = true;
			
			
			_textFormat = new TextFormat();
			_textFormat.font = "Arial";
			_textFormat.color = 0x000000;
			_textFormat.size = 14;
			
			_textField = new TextField();
			_textField.defaultTextFormat = _textFormat;
			_textField.x = 5;
			_textField.y = 1;
			_textField.width = 170;
			_textField.height = 20;
			_textField.text = String(_microphoneArray[_currentIndex]);
			_holder.addChild(_textField);
			
			
			
			_chooserOverSprite = new Sprite();
			_chooserOverSprite.graphics.beginFill(0xff0000, 0);
			_chooserOverSprite.graphics.drawRoundRect(0, 0, 200, 22, 20, 20);
			_chooserOverSprite.graphics.endFill();
			
			_chooserOverSprite.buttonMode = true;
			_chooserOverSprite.addEventListener(MouseEvent.CLICK, handleChooserClick);
			_chooserOverSprite.addEventListener(MouseEvent.MOUSE_OVER, handleChooserOver);
			_chooserOverSprite.addEventListener(MouseEvent.MOUSE_OUT, handleChooserOut);
			
			_holder.addChild(_chooserOverSprite);
			
			
			_dropDownList = new Sprite();
			_dropDownList.graphics.beginFill(0xeeeeee, 1);
			_dropDownList.graphics.drawRoundRect(0, 0, 200, 20*_microphoneArray.length, 20, 20);
			_dropDownList.graphics.endFill();
			
			_dropDownList.y = 23;
			_dropDownList.visible = false;
			
			for(var i:uint = 0; i < _microphoneArray.length; ++i)
			{
				var _microphoneChooseComponent:MicrophoneChooseComponent = new MicrophoneChooseComponent(String(_microphoneArray[i]));
				
				_microphoneChooseComponent.y = 22 * i;
				_microphoneChooseComponent.addEventListener(MouseEvent.CLICK, handleComponentClick);
				
				_dropDownList.addChild(_microphoneChooseComponent);
				
				_array[i] = _microphoneChooseComponent;
			}
			
			_holder.addChild(_dropDownList);
		}
		
		private function handleComponentClick(event:MouseEvent):void
		{
			for(var i:uint = 0; i < _array.length; ++i)
			{
				if(event.currentTarget == MicrophoneChooseComponent(_array[i]))
				{
					if(_currentIndex != i)
					{
						_currentIndex = i;
						
						_textField.text = String(_microphoneArray[_currentIndex]);
						
						this.dispatchEvent(new MicrophoneChangeEvent(MicrophoneChangeEvent.MICROPHONE_CHANGE_EVENT, true, false, _currentIndex));
					}
					
					_dropDownList.visible = false;
				}
			}
		}
		
		private function handleChooserClick(event:MouseEvent):void
		{
			if(_dropDownList.visible == true)
			{
				_dropDownList.visible = false;
			}
			else
			{
				_dropDownList.visible = true;
			}
		}
		
		private function handleChooserOver(event:MouseEvent):void
		{
			_microphoneChoose.visible = false;
			_microphoneChooseOver.visible = true;
		}
		
		private function handleChooserOut(event:MouseEvent):void
		{
			_microphoneChoose.visible = true;
			_microphoneChooseOver.visible = false;
		}
	}
}