package components
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class NumberButton extends Sprite
	{
		private var _holder:Sprite;
		
		private var _buttonHolder:Sprite;
		[Embed(source="assets/button.png")]
		private var _buttonNormal:Class;
		
		private var _buttonOverHolder:Sprite;
		[Embed(source="assets/button_over.png")]
		private var _buttonOver:Class;
		
		private var _buttonClickedHolder:Sprite;
		[Embed(source="assets/button_clicked.png")]
		private var _buttonClicked:Class;
		
		private var _textFormat:TextFormat;
		private var _textField:TextField;
		
		private var _overSprite:Sprite;
		
		public function NumberButton(_num:String)
		{
			_holder = new Sprite();
			addChild(_holder);
			
			
			_buttonHolder = new Sprite();
			_buttonHolder.addChild(new _buttonNormal());
			_buttonHolder.visible = false;
			_holder.addChild(_buttonHolder);
			
			
			_buttonOverHolder = new Sprite();
			_buttonOverHolder.addChild(new _buttonOver());
			_buttonOverHolder.visible = false;
			_holder.addChild(_buttonOverHolder);
			
			
			_buttonClickedHolder = new Sprite();
			_buttonClickedHolder.addChild(new _buttonClicked());
			_buttonClickedHolder.visible = false;
			_holder.addChild(_buttonClickedHolder);
			
			
			_buttonHolder.visible = true;
			
			
			_textFormat = new TextFormat();
			_textFormat.font = "number_font";
			
			if(_num == "*")
			{
				_textFormat.size = 40;
			}
			else
			{
				_textFormat.size = 20;
			}
			
			_textFormat.bold = true;
			_textFormat.color = 0x484848;
			_textFormat.align = "center";
			
			_textField = new TextField();
			_textField.defaultTextFormat = _textFormat;
			_textField.width = 40;
			_textField.embedFonts = true;
			_textField.selectable = false;
			_textField.text = _num;
			_textField.x = 10;
			
			if(_num == "*")
			{
				_textField.y = 0;
				_textField.height = 30;
			}
			else
			{
				_textField.y = 5;
				_textField.height = 25;
			}
			
			_holder.addChild(_textField);
			
			
			_overSprite = new Sprite();
			_overSprite.graphics.beginFill(0xff0000, 0);
			_overSprite.graphics.drawRect(0, 0, 60, 40);
			_overSprite.graphics.endFill();
			
			_overSprite.buttonMode = true;
			
			_holder.addChild(_overSprite);
		}
		
		public function goButtonOver():void
		{
			_buttonHolder.visible = false;
			_buttonClickedHolder.visible = false;
			_buttonOverHolder.visible = true;
			
			_holder.x = 0;
			_holder.y = 0;
		}
		
		public function goButtonOut():void
		{
			_buttonHolder.visible = true;
			_buttonOverHolder.visible = false;
			_buttonClickedHolder.visible = false;
			
			_holder.x = 0;
			_holder.y = 0;
		}
		
		public function goButtonClicked():void
		{
			_buttonHolder.visible = false;
			_buttonOverHolder.visible = false;
			_buttonClickedHolder.visible = true;
			
			_holder.x = 1;
			_holder.y = 1;
		}
		
		public function getNumber():String
		{
			return _textField.text;
		}
	}
}