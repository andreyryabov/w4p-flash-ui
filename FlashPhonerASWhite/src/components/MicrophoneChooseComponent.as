package components
{
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class MicrophoneChooseComponent extends Sprite
	{
		private var _holder:Sprite;
		private var _overSprite:Sprite;
		
		private var _textFormat:TextFormat;
		private var _textField:TextField;
		
		public function MicrophoneChooseComponent(_name:String)
		{
			_holder = new Sprite();
			_holder.graphics.beginFill(0xeeeeee, 1);
			_holder.graphics.drawRoundRect(0, 0, 204, 26, 20, 20);
			_holder.graphics.endFill();
			
			addChild(_holder);
			
			
			_textFormat = new TextFormat();
			_textFormat.font = "Arial";
			_textFormat.color = 0x000000;
			_textFormat.size = 14;
			
			_textField = new TextField();
			_textField.defaultTextFormat = _textFormat;
			_textField.x = 7;
			_textField.y = 3;
			_textField.width = 190;
			_textField.height = 20;
			_textField.text = _name;
			addChild(_textField);
			
			_overSprite = new Sprite();
			_overSprite.graphics.beginFill(0xff0000, 0);
			_overSprite.graphics.drawRoundRect(0, 0, 204, 26, 20, 20);
			_overSprite.graphics.endFill();
			
			_overSprite.buttonMode = true;
			_overSprite.addEventListener(MouseEvent.MOUSE_OVER, handleOver);
			_overSprite.addEventListener(MouseEvent.MOUSE_OUT, handleOut);
			
			addChild(_overSprite);
		}
		
		private function handleOver(event:MouseEvent):void
		{
			TweenMax.to(_holder, 0.5, {tint:0xbbbbbb});
		}
		
		private function handleOut(event:MouseEvent):void
		{
			TweenMax.to(_holder, 0.5, {tint:0xdddddd});
		}
	}
}