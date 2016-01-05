package;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.SimpleButton;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.TextEvent;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.ui.Keyboard;
import openfl.text.TextField;
import openfl.Assets;
import FileDialog.FileDialogResultEventArgs;

class Main extends Sprite
{
    
    private var _cwd:String;
    private var _btnTextField:SimpleButton;
    private var _btnBitmap:SimpleButton;
    private var _canvas:Canvas;
    private var _canvasWidth:Int;
    private var _canvasHeight:Int;
    
    public function new()
    {
        super();
        
        _cwd = Sys.getCwd();
        
        _canvasWidth = Lib.current.stage.stageWidth;
        _canvasHeight = Lib.current.stage.stageHeight - 32;
        
        _canvas = new Canvas(_canvasWidth, _canvasHeight);
        _canvas.y = 32;
        
        _btnTextField = new SimpleButton(new Bitmap(Assets.getBitmapData("img/TextFieldIcon.png")));
        _btnBitmap = new SimpleButton(new Bitmap(Assets.getBitmapData("img/BitmapIcon.png")));
        _btnBitmap.x = _btnTextField.width;
        
        _btnTextField.addEventListener(MouseEvent.CLICK, function(e)
        {
            var txt = new TextField();
            txt.text = "Default text.";
            _canvas.addObject(txt);
        });
        
        _btnBitmap.addEventListener(MouseEvent.CLICK, function(e)
        {
            var fd = new FileDialog([
                {
                    text: "Image: ", dialogCaption: "Import Image", data: [
                        { ext: "png", desc: "PNG Files" },
                        { ext: "bmp", desc: "BMP Files" },
                        { ext: "jpg", desc: "JPG Files" },
                        { ext: "jpeg", desc: "JPEG Files" }
                    ]
                }
            ], 200);
            
            fd.x = stage.stageWidth / 2 - fd.width / 2;
            fd.y = stage.stageHeight / 2 - fd.height / 2;
            
            fd.onFileDialogOkay.add(function(result:FileDialogResultEventArgs)
            {
                _canvas.addObject(new Bitmap(BitmapData.fromFile(result.files[0])));
            });
            
            addChild(fd);
        });
        
        addChild(_btnTextField);
        addChild(_btnBitmap);
        addChild(_canvas);
    }

}
