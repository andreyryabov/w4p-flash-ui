package components
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class ChooseMicrophoneText extends Sprite
	{
		private var _textFormat:TextFormat;
		private var _textField:TextField;
		
		public function ChooseMicrophoneText()
		{
			_textFormat = new TextFormat();
			_textFormat.font = "PT Sans";
			_textFormat.size = 13;
			_textFormat.color = 0xffffff;
			_textFormat.bold = true;
			
			_textField = new TextField();
			_textField.defaultTextFormat = _textFormat;
			_textField.width = 200;
			_textField.height = 25;
			_textField.text = "Выберите микрофон:";
			_textField.selectable = false;
			
			addChild(_textField);
		}
	}
}