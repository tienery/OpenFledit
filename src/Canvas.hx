package;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.Lib;

class Canvas extends Sprite
{
    
    private var __items:Array<DisplayObject>;
    
    private var _mouseX:Float;
    private var _mouseY:Float;
    private var _relatedObjectX:Float;
    private var _relatedObjectY:Float;
    
    private var _mouseDown:Bool;
    private var _selectedObject:DisplayObject;
    
    public function new(width:Float, height:Float)
    {
        super();
        
        __items = [];
        _mouseX = 0;
        _mouseY = 0;
        _relatedObjectX = 0;
        _relatedObjectY = 0;
        
        addEventListener(Event.ADDED_TO_STAGE, function(e)
        {
            graphics.beginFill(0xFFFFFF);
            graphics.lineStyle(1, 0);
            graphics.drawRect(0, 0, width, height);
        });
        
        addEventListener(MouseEvent.MOUSE_DOWN, function(e)
        {
            getObjectAtLocation(e.stageX, e.stageY);
            
            _mouseDown = true;
        });
        
        addEventListener(MouseEvent.CLICK, function(e)
        {
            getObjectAtLocation(e.stageX, e.stageY);
        });
        
        addEventListener(MouseEvent.MOUSE_MOVE, function(e:MouseEvent)
        {
            if (_selectedObject != null && _mouseDown)
            {
                _selectedObject.x = e.stageX + _mouseX;
                _selectedObject.y = e.stageY + _mouseY;
            }
        });
        
        addEventListener(MouseEvent.MOUSE_UP, function(e)
        {
            if (_selectedObject != null)
                trace(_selectedObject.x, _selectedObject.y);
            
            _mouseDown = false;
        });
        
        addEventListener(MouseEvent.MOUSE_OUT, function(e)
        {
            _mouseDown = false;
        });
    }
    
    private function getRootObject(obj:DisplayObject)
    {   
        if (obj.parent != this)
            return getRootObject(obj.parent);
        else
            return obj;
    }
    
    private function getObjectAtLocation(locX:Float, locY:Float)
    {
        for (i in 0...__items.length)
        {
            var item = __items[i];
            if (locX > item.x && locY > item.y &&
                locX <= item.x + item.width && locY <= item.y + item.height)
            {
                _selectedObject = item;
                _mouseX = _selectedObject.x - locX;
                _mouseY = _selectedObject.y - locY;
                return;
            }
        }
        
    }
    
    public function addObject(obj:DisplayObject)
    {
        __items.push(obj);
        addChild(obj);
    }
    
    public function removeObject(obj:DisplayObject)
    {
        __items.slice(__items.indexOf(obj), 1);
        removeChild(obj);
    }
    
}