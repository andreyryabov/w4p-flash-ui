package
{
	import components.CallButton;
	import components.ChooseMicrophoneText;
	import components.DurationText;
	import components.MicrophoneComponent;
	import components.NumberButton;
	import components.SettingsButton;
	import components.SoundSlider;
	import components.events.MicrophoneChangeEvent;
	import components.events.MicrophoneVolumeChangeEvent;
	import components.events.SoundChangeEvent;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.events.SampleDataEvent;
	import flash.events.TimerEvent;
	import flash.media.Microphone;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import ru.w4p.*;
	import ru.w4p.net.*;
	import ru.w4p.util.*;
	
	public class FlashPhonerAS extends Sprite
	{
		private static const MSG_CALL:String 			= "Позвонить";
		private static const MSG_HANGUP:String 			= "Завершить разговор";
		private static const MSG_CALLED_HANGUP:String	= "Собеседник положил трубку";
		private static const MSG_ERROR:String 			= "Ошибка связи";
		private static const MSG_BUSY:String 			= "Занято";
		private static const MSG_COMPLETE:String 		= "Разговор завершен";
		
		private var servers:Array = ["82.181.166.50:1936"];
		private var number:String = null;
		
		private var _soundVolume:Number = 75;
		private var _microphoneGain:Number = 75;
		
		private var microphone:Microphone;
		private var micActivityTimer:Timer;
		private var phone:Phone;
		
		
		private var _holder:Sprite;
		
		private var _lines1Holder:Sprite;
		[Embed(source="assets/lines1.png")]
		private var _assetClass1:Class;
		
		private var _lines2Holder:Sprite;
		[Embed(source="assets/lines2.png")]
		private var _assetClass2:Class;
		
		private var _logoHolder:Sprite;
		[Embed(source="assets/logo.png")]
		private var _assetLogo:Class;
		
		private var _copyrightHolder:Sprite;
		[Embed(source="assets/settings_copyright.png")]
		private var _assetCopyright:Class;
		
		private var _backgroundHolder:Sprite;
		[Embed(source="assets/background.png")]
		private var _assetBackground:Class;
		
		private var _settingsBackgroundHolder:Sprite;
		[Embed(source="assets/settings_background.png")]
		private var _settingsAssetBackground:Class;
		
		private var _callButton:CallButton;
		private var _callButtonOverSprite:Sprite;
		
		private var _text:DurationText;
		private var _timer:Timer;
		private var _time:Number = 0;
		
		private var _settingsButton:SettingsButton;
		private var _settingsButtonOverSprite:Sprite;
		
		private var _buttonsArray:Array = new Array();
		
		private var _soundSlider:SoundSlider;
		private var _microphoneComponent:MicrophoneComponent;
		
		private var _semiTransparentBackground:Sprite;
		
		private var _chooseMicrophoneText:ChooseMicrophoneText;
		
		public function FlashPhonerAS()
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			
			
			_holder = new Sprite();
			addChild(_holder);
		
			
			_lines1Holder = new Sprite();
			_lines1Holder.addChild(new _assetClass1());
			_lines1Holder.y = 145;
			
			_holder.addChild(_lines1Holder);
			
			
			_lines2Holder = new Sprite();
			_lines2Holder.addChild(new _assetClass2());
			_lines2Holder.y = 450;
			
			_holder.addChild(_lines2Holder);
			
			
			var _button1:NumberButton = new NumberButton("1");
			_button1.x = 20;
			_button1.y = 58;
			_button1.visible = false;
			_buttonsArray[_buttonsArray.length] = _button1;
			_holder.addChild(_button1);
			
			
			var _button2:NumberButton = new NumberButton("2");
			_button2.x = 90;
			_button2.y = 58;
			_button2.visible = false;
			_buttonsArray[_buttonsArray.length] = _button2;
			_holder.addChild(_button2);
			
			
			var _button3:NumberButton = new NumberButton("3");
			_button3.x = 160;
			_button3.y = 58;
			_button3.visible = false;
			_buttonsArray[_buttonsArray.length] = _button3;
			_holder.addChild(_button3);
			
			
			var _button4:NumberButton = new NumberButton("4");
			_button4.x = 20;
			_button4.y = 108;
			_button4.visible = false;
			_buttonsArray[_buttonsArray.length] = _button4;
			_holder.addChild(_button4);
			
			
			var _button5:NumberButton = new NumberButton("5");
			_button5.x = 90;
			_button5.y = 108;
			_button5.visible = false;
			_buttonsArray[_buttonsArray.length] = _button5;
			_holder.addChild(_button5);
			
			
			var _button6:NumberButton = new NumberButton("6");
			_button6.x = 160;
			_button6.y = 108;
			_button6.visible = false;
			_buttonsArray[_buttonsArray.length] = _button6;
			_holder.addChild(_button6);
			
			
			var _button7:NumberButton = new NumberButton("7");
			_button7.x = 20;
			_button7.y = 158;
			_button7.visible = false;
			_buttonsArray[_buttonsArray.length] = _button7;
			_holder.addChild(_button7);
			
			
			var _button8:NumberButton = new NumberButton("8");
			_button8.x = 90;
			_button8.y = 158;
			_button8.visible = false;
			_buttonsArray[_buttonsArray.length] = _button8;
			_holder.addChild(_button8);
			
			
			var _button9:NumberButton = new NumberButton("9");
			_button9.x = 160;
			_button9.y = 158;
			_button9.visible = false;
			_buttonsArray[_buttonsArray.length] = _button9;
			_holder.addChild(_button9);
			
			
			var _button10:NumberButton = new NumberButton("*");
			_button10.x = 20;
			_button10.y = 208;
			_button10.visible = false;
			_buttonsArray[_buttonsArray.length] = _button10;
			_holder.addChild(_button10);
			
			
			var _button11:NumberButton = new NumberButton("0");
			_button11.x = 90;
			_button11.y = 208;
			_button11.visible = false;
			_buttonsArray[_buttonsArray.length] = _button11;
			_holder.addChild(_button11);
			
			
			var _button12:NumberButton = new NumberButton("#");
			_button12.x = 160;
			_button12.y = 208;
			_button12.visible = false;
			_buttonsArray[_buttonsArray.length] = _button12;
			_holder.addChild(_button12);
			
			
			for(var i:uint = 0; i < _buttonsArray.length; ++i)
			{
				NumberButton(_buttonsArray[i]).addEventListener(MouseEvent.CLICK, handleNumberButtonClick);
				NumberButton(_buttonsArray[i]).addEventListener(MouseEvent.MOUSE_OVER, handleNumberButtonOver);
				NumberButton(_buttonsArray[i]).addEventListener(MouseEvent.ROLL_OUT, handleNumberButtonOut);
			}
			
			
			_semiTransparentBackground = new Sprite();
			_semiTransparentBackground.graphics.beginFill(0x142136, 1);
			_semiTransparentBackground.graphics.drawRect(0, 0, 240, 540);
			_semiTransparentBackground.graphics.endFill();
			
			_semiTransparentBackground.alpha = 0.9;
			_semiTransparentBackground.visible = false;
			
			_holder.addChild(_semiTransparentBackground);
			
			
			_logoHolder = new Sprite();
			_logoHolder.addChild(new _assetLogo());
			_logoHolder.y = 215;
			_logoHolder.x = 60;
			
			_holder.addChild(_logoHolder);
			
			
			_backgroundHolder = new Sprite();
			_backgroundHolder.addChild(new _assetBackground());
			_backgroundHolder.y = 300;
			
			_holder.addChild(_backgroundHolder);
			
			
			_settingsBackgroundHolder = new Sprite();
			_settingsBackgroundHolder.addChild(new _settingsAssetBackground());
			_settingsBackgroundHolder.y = 240;
			_settingsBackgroundHolder.visible = false;
			
			_holder.addChild(_settingsBackgroundHolder);
			
			
			_copyrightHolder = new Sprite();
			_copyrightHolder.addChild(new _assetCopyright());
			_copyrightHolder.y = 507;
			_copyrightHolder.x = 63;
			
			_holder.addChild(_copyrightHolder);
			
			
			_callButton = new CallButton();
			_callButton.x = 72;
			_callButton.y = 265;
			_holder.addChild(_callButton);
			
			_callButtonOverSprite = new Sprite();
			_callButtonOverSprite.graphics.beginFill(0xff0000, 0);
			_callButtonOverSprite.graphics.drawCircle(0, 0, 48);
			_callButtonOverSprite.graphics.endFill();
			_callButtonOverSprite.x = 48;
			_callButtonOverSprite.y = 48;
			_callButtonOverSprite.buttonMode = true;
			_callButtonOverSprite.addEventListener(MouseEvent.CLICK, handleCallButtonClick);
			_callButtonOverSprite.addEventListener(MouseEvent.MOUSE_OVER, handleCallButtonOver);
			_callButtonOverSprite.addEventListener(MouseEvent.MOUSE_OUT, handleCallButtonOut);
			_callButton.addChild(_callButtonOverSprite);
			
			
			_text = new DurationText();
			_text.x = 20;
			_text.y = 372;
			_text.setText("Позвонить");
			_holder.addChild(_text);
			
			_timer = new Timer(1000);
			_timer.addEventListener(TimerEvent.TIMER, handleTimer);
			
			
			_settingsButton = new SettingsButton();
			_settingsButton.x = 102;
			_settingsButton.y = 469;
			
			_holder.addChild(_settingsButton);
			
			_settingsButtonOverSprite = new Sprite();
			_settingsButtonOverSprite.graphics.beginFill(0xff0000, 0);
			_settingsButtonOverSprite.graphics.drawCircle(0, 0, 18);
			_settingsButtonOverSprite.graphics.endFill();
			_settingsButtonOverSprite.x = 18;
			_settingsButtonOverSprite.y = 18;
			_settingsButtonOverSprite.buttonMode = true;
			_settingsButtonOverSprite.addEventListener(MouseEvent.CLICK, handleSettingsButtonClick);
			_settingsButtonOverSprite.addEventListener(MouseEvent.MOUSE_OVER, handleSettingsButtonOver);
			_settingsButtonOverSprite.addEventListener(MouseEvent.MOUSE_OUT, handleSettingsButtonOut);
			_settingsButton.addChild(_settingsButtonOverSprite);
			
			
			
			_soundSlider = new SoundSlider();
			_soundSlider.x = 19;
			_soundSlider.y = 400;
			_soundSlider.setVolume(_soundVolume);
			_holder.addChild(_soundSlider);
			
			
			_microphoneComponent = new MicrophoneComponent(Microphone.names);
			_microphoneComponent.x = 19;
			_microphoneComponent.y = 430;
			_microphoneComponent.setGain(_microphoneGain);
			_holder.addChild(_microphoneComponent);
			
			
			micActivityTimer = Utils.interval(function():void
			{
				if (microphone)
				{
					var val:Number = Math.max(0, Math.min(microphone.activityLevel, 100));
					_microphoneComponent.setIndicator(val);					
				}
			}, 50);
			
			
			setMicrophone(getMicrophone());
			
			
			
			_chooseMicrophoneText = new ChooseMicrophoneText();
			_chooseMicrophoneText.x = 25;
			_chooseMicrophoneText.y = 310;
			_chooseMicrophoneText.visible = false;
			_holder.addChild(_chooseMicrophoneText);
			
			
			this.addEventListener(SoundChangeEvent.SOUND_CHANGE_EVENT, handleSoundChange);
			this.addEventListener(MicrophoneVolumeChangeEvent.MICROPHONE_VOLUME_CHANGE_EVENT, handleMicrophoneVolumeChange);
			this.addEventListener(MicrophoneChangeEvent.MICROPHONE_CHANGE_EVENT, handleMicrophoneChange);
		}
		
		protected function setMicrophone(mic:Microphone):void
		{
			if (microphone != null) 
			{
				microphone.removeEventListener(SampleDataEvent.SAMPLE_DATA, onSamples);
			}
			
			microphone = mic;
			microphone.framesPerPacket = 2;
			microphone.setSilenceLevel(0, 60000);
			
			microphone.addEventListener(SampleDataEvent.SAMPLE_DATA, onSamples);
			
			if (phone)
			{
				phone.setMicrophone(microphone);
			}
		}
		
		protected function onSamples(event:SampleDataEvent):void 
		{
			
		}
		
		private function getMicrophone(index:int = -1):Microphone 
		{
			var mic:Microphone = null;
			
			if ("getEnhancedMicrophone" in Microphone) 
			{
				mic = Microphone["getEnhancedMicrophone"](index);                    
			}
			else 
			{
				mic = Microphone.getMicrophone(index);
			}
			
			return mic;
		}
		
		private function handleCallButtonClick(event:MouseEvent):void
		{
			if (phone != null)
			{    
				if(_semiTransparentBackground.visible == true)
				{
					_logoHolder.y = 9;
				}
				else
				{
					_logoHolder.y = 215;
				}
				
				for(var i:uint = 0; i < _buttonsArray.length; ++i)
				{
					NumberButton(_buttonsArray[i]).visible = false;
				}
				
				hangup(MSG_COMPLETE);
				
				_callButton.goCallOver();	
				
				
				_text.setText("Позвонить");
				_timer.stop();
				_time = 0;
			} 
			else 
			{
				_logoHolder.y = 9;
				
				for(var j:uint = 0; j < _buttonsArray.length; ++j)
				{
					NumberButton(_buttonsArray[j]).visible = true;
				}
				
				phone = new Phone();
				phone.setServers(servers);
				phone.setNumber(number);
				phone.setAccountId("sberbank");
				phone.setMicrophone(microphone);
				phone.addEventListener(PhoneEvent.ANSWERED, onAccepted);
				phone.addEventListener(PhoneEvent.RINGING,  onRinging);
				phone.addEventListener(PhoneEvent.HANGUP,   onHangup);
				phone.addEventListener(PhoneEvent.ERROR,    onError);
				phone.addEventListener(PhoneEvent.BUSY,     onBusy);
				phone.call();
				
				phone.setVolume(_soundVolume / 100);
				phone.getMicrophone().gain = _microphoneGain;
				
				_callButton.goHungUpOver();
				
				
				_text.setText("Вы говорите " + "00:00:00");
				_timer.start();
			}
		}
		
		protected function onAccepted(pe:PhoneEvent):void
		{	
			
		}
		
		protected function onRinging(pe:PhoneEvent):void
		{
			
		}
		
		protected function onBusy(pe:PhoneEvent):void
		{
			hangup(MSG_BUSY);
		}
		
		protected function onError(pe:PhoneEvent):void 
		{
			hangup(MSG_ERROR);
		}
		
		protected function onHangup(pe:PhoneEvent):void 
		{
			hangup(MSG_CALLED_HANGUP);
		}
		
		protected function hangup(msg:String):void
		{
			if(phone)
			{
				phone.close();
				phone = null;
			} 
		}
		
		private function handleCallButtonOver(event:MouseEvent):void
		{
			if(phone == null)
			{
				_callButton.goCallOver();
			}
			else
			{
				_callButton.goHungUpOver();
			}
		}
		
		private function handleCallButtonOut(event:MouseEvent):void
		{
			if(phone == null)
			{
				_callButton.goCall();
			}
			else
			{
				_callButton.goHungUp();
			}
		}
		
		private function handleSettingsButtonClick(event:MouseEvent):void
		{
			if(_semiTransparentBackground.visible == false)
			{
				_semiTransparentBackground.visible = true;
				
				_chooseMicrophoneText.visible = true;
				
				_settingsButton.goOkOver();
				
				_backgroundHolder.visible = false;
				_settingsBackgroundHolder.visible = true;
				
				_callButton.y = 200;
				
				_logoHolder.y = 9;
				
				_text.visible = false;
				
				_soundSlider.y = 375;
				
				_microphoneComponent.goToSettingsState();
			}
			else
			{
				_semiTransparentBackground.visible = false;
				
				_chooseMicrophoneText.visible = false;
				
				_settingsButton.goSettings();
				
				_backgroundHolder.visible = true;
				_settingsBackgroundHolder.visible = false;
				
				_callButton.y = 265;
				
				if(phone == null)
				{
					_logoHolder.y = 215;
				}
				else
				{
					_logoHolder.y = 9;
				}
				
				_text.visible = true;
				
				_soundSlider.y = 400;
				
				_microphoneComponent.goToNormalState();
			}
		}
		
		private function handleSettingsButtonOver(event:MouseEvent):void
		{
			if(_semiTransparentBackground.visible == true)
			{
				_settingsButton.goOkOver();
			}
		}
		
		private function handleSettingsButtonOut(event:MouseEvent):void
		{
			if(_semiTransparentBackground.visible == true)
			{
				_settingsButton.goOk();
			}
		}
		
		private function handleNumberButtonClick(event:MouseEvent):void
		{
			for(var i:uint = 0; i < _buttonsArray.length; ++i)
			{
				if(event.currentTarget == NumberButton(_buttonsArray[i]))
				{
					if (phone != null) 
					{
						phone.dtmf(NumberButton(_buttonsArray[i]).getNumber()); 
					}
				}
			}
		}
		
		private function handleNumberButtonOver(event:MouseEvent):void
		{
			for(var i:uint = 0; i < _buttonsArray.length; ++i)
			{
				if(event.currentTarget == NumberButton(_buttonsArray[i]))
				{
					NumberButton(_buttonsArray[i]).goButtonOver();
				}
			}
		}
		
		private function handleNumberButtonOut(event:MouseEvent):void
		{
			for(var i:uint = 0; i < _buttonsArray.length; ++i)
			{
				if(event.currentTarget == NumberButton(_buttonsArray[i]))
				{
					NumberButton(_buttonsArray[i]).goButtonOut();
				}
			}
		}
		
		private function handleSoundChange(event:SoundChangeEvent):void
		{
			_soundVolume = event._vol;
			
			if(phone != null)
			{
				phone.setVolume(_soundVolume / 100);
			}
		}
		
		private function handleMicrophoneVolumeChange(event:MicrophoneVolumeChangeEvent):void
		{
			_microphoneGain = event._vol;
			
			if(phone != null)
			{
				phone.getMicrophone().gain = _microphoneGain;
			}
		}
		
		private function handleMicrophoneChange(event:MicrophoneChangeEvent):void
		{
			setMicrophone(getMicrophone(event._index));
		}
		
		private function handleTimer(event:TimerEvent):void
		{
			_time++;
			
			_text.setText("Вы говорите " + convert(_time));
		}
		
		private function convert(tm:Number):String
		{
			var s_:String = "00";
			var m_:String = "00";
			var h_:String = "00";
			
			var hh:Number;
			var mm:Number;
			var ss:Number =  Math.floor(tm)
			
			if(ss < 10) 
			{
				s_ = "0" + ss;
			}
			else
			{
				s_ = ss.toString();
			}
				
			if(ss > 59)	
			{
				mm = Math.floor(ss/60); 
				
				if(mm < 10) 
				{
					m_ = "0" + mm;
				}
				else
				{
					m_ = mm.toString();
				}
				
				ss = (ss % 60);
				
				if(ss < 10) 
				{
					s_ = "0" + ss;
				}
				else
				{
					s_ = ss.toString();
				}
			}
			
			if(ss > 3599)
			{
				hh = Math.floor(ss/3600); 
				
				if(hh < 10) 
				{
					h_ = "0" + hh;
				}
				else
				{
					h_ = hh.toString();
				}
				
				mm = (ss % 3600);
				
				if(mm < 10) 
				{
					m_ = "0" + mm;
				}
				else
				{
					m_ = mm.toString();
				}
				
				ss = (ss % 60);
				
				if(ss < 10) 
				{
					s_ = "0" + ss;
				}
				else
				{
					s_ = ss.toString();
				}
			}
			
			
			return  h_ + ":" + m_ + ":" + s_;
		}
	}
}