package;

import openfl.display.Bitmap;
import openfl.display.SimpleButton;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.TextEvent;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.ui.Keyboard;
import openfl.text.TextField;
import openfl.Assets;

class Main extends Sprite
{
	
	private var _btnTextField:SimpleButton;
	private var _canvas:Canvas;
	private var _canvasWidth:Int;
	private var _canvasHeight:Int;
	
	public function new()
	{
		super();
		
		_canvasWidth = Lib.current.stage.stageWidth;
		_canvasHeight = Lib.current.stage.stageHeight - 32;
		
		_canvas = new Canvas(_canvasWidth, _canvasHeight);
		_canvas.y = 32;
		
		_btnTextField = new SimpleButton(new Bitmap(Assets.getBitmapData("img/TextFieldIcon.png")));
		
		_btnTextField.addEventListener(MouseEvent.CLICK, function(e)
		{
			var txt = new TextField();
			txt.text = "Default text.";
			txt.name = "My Text Field";
			_canvas.addObject(txt);
		});
		
		addChild(_btnTextField);
		addChild(_canvas);
	}

}
