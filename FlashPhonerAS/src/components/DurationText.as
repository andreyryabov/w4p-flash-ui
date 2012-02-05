package components
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class DurationText extends Sprite
	{
		private var _textFormat:TextFormat;
		private var _textField:TextField;
		
		public function DurationText()
		{
			_textFormat = new TextFormat();
			_textFormat.font = "duration_font";
			_textFormat.size = 16;
			_textFormat.color = 0xffffff;
			_textFormat.align = "center";
			
			_textField = new TextField();
			_textField.defaultTextFormat = _textFormat;
			_textField.embedFonts = true;
			_textField.width = 200;
			_textField.height = 25;
			_textField.text = "";
			_textField.selectable = false;
			
			addChild(_textField);
		}
		
		public function setText(_txt:String):void
		{
			_textField.text = _txt;
		}
	}
}