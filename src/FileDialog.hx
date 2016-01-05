package;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.SimpleButton;
import openfl.display.Sprite;

import openfl.events.MouseEvent;

import openfl.gui.TextControl;
import openfl.gui.TextBox;
import openfl.gui.styles.FontStyle;
import openfl.gui.styles.TextBoxStyle;

import dialogs.Dialogs;

import msignal.Signal.Signal1;

import openfl.Assets;

class FileDialog extends Sprite
{

    private var _btnClose:SimpleButton;
    private var _btnOkay:SimpleButton;
    
    public var onFileDialogOkay:Signal1<FileDialogResultEventArgs>;
    
    public function new(metadata:Array<FileDialogMetaData>, width:Float)
    {
        super();
        
        onFileDialogOkay = new Signal1();
        
        var totalHeight = 44;
        
        for (i in 0...metadata.length)
        {
            var value = metadata[i];
            var lblText = new TextControl(value.text, "font/OpenSans-Regular", new FontStyle(10, 0xFFFFFF, false), true);
            lblText.x = 3;
            lblText.y = i * 8 + 18;
            
            var txtLocation = new TextBox("Click here.", width - lblText.width - 6, 30, "font/OpenSans-Regular", new FontStyle(10, 0xFFFFFF, false), true);
            txtLocation.x = lblText.width + 3;
            txtLocation.y = i * 2 + 18;
            txtLocation.addEventListener(MouseEvent.RIGHT_CLICK, function(e)
            {
                var result = Dialogs.open(value.dialogCaption, value.data);
                if (result != "")
                    txtLocation.text = result;
            });
            
            totalHeight += 30;
            
            addChild(lblText);
            addChild(txtLocation);
        }
        
        _btnClose   = new SimpleButton(new Bitmap(Assets.getBitmapData("img/CloseButton.png")));
        _btnClose.x = width - 17;
        _btnClose.y = 1;
        
        _btnClose.addEventListener(MouseEvent.CLICK, function(e)
        {
            parent.removeChild(this);
        });
        
        _btnOkay = new SimpleButton(new Bitmap(Assets.getBitmapData("img/ButtonOk.png")), 
                                    new Bitmap(Assets.getBitmapData("img/ButtonOkOver.png")),
                                    new Bitmap(Assets.getBitmapData("img/ButtonOkDown.png")));
        
        _btnOkay.x = width - _btnOkay.width - 1;
        _btnOkay.y = totalHeight - _btnClose.height - 1;
        
        _btnOkay.addEventListener(MouseEvent.CLICK, function(e)
        {
            var result = new FileDialogResultEventArgs();
            
            for (i in 0...numChildren)
                if (Std.is(getChildAt(i), TextBox))
                    result.files.push(cast (getChildAt(i), TextBox).text);
            
            onFileDialogOkay.dispatch(result);
            
            parent.removeChild(this);
        });
        
        addChild(_btnClose);
        addChild(_btnOkay);
        
        graphics.beginFill(0x0000A9);
        graphics.drawRect(0, 0, width, totalHeight);
    }
    
}

typedef FileDialogMetaData = { var text:String; var dialogCaption:String; var data:Array<{ ext:String, desc:String }>; };

class FileDialogResultEventArgs
{
    
    public var files:Array<String>;
    
    public function new()
    {
        files = [];
    }
    
}