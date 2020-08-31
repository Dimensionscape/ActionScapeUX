package actionscape.display;
import actionscape.events.TouchEvent;
import haxe.ds.Map;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.display.TileContainer;
import openfl.display.Tilemap;
import openfl.events.EventDispatcher;

/**
 * ...
 * @author Christopher Speciale, Dimensionscape LLC
 */
class DisplayModel extends EventDispatcher
{
	private var __tileContainer:TileContainer;
	@:isVar public var width(get, set):Float = 0;
	@:isVar public var height(get, set):Float = 0;
	@:isVar public var x(get, set):Float = 0;
	@:isVar public var y(get, set):Float = 0;
	@:isVar public var parent(get, null):DisplayModel;
	@:isVar public var name(get, set):String = "";
	public function new() 
	{
		super();		
		__tileContainer = new TileContainer();		
	}
	
	public function getDisplayObject():DisplayObject{
		var tilemap:Tilemap = new Tilemap(8000000, 8000000);
		tilemap.addTile(__tileContainer);
		return tilemap;
	}
	
	private function get_name():String{
		return name;
	}
	
	private function set_name(value:String):String{
		return name = value;
	}
	private function get_height():Float{
		return height;
	}
	
	private function set_height(value:Float):Float{
		return height = value;
	}
	
	private function get_width():Float{
		return width;
	}
	
	private function set_width(value:Float):Float{
		return width = value;
	}
	
	private function get_y():Float{
		return __tileContainer.y;
	}
	
	private function set_y(value:Float):Float{
		__tileContainer.y = value;
		return value;
	}
	
	private function get_x():Float{
		return __tileContainer.x;
	}
	
	private function set_x(value:Float):Float{
		__tileContainer.x = value;
		return value;
	}
	
	private function get_parent():DisplayModel{
		return parent;
	}
	private function set_parent(parent:DisplayModel):DisplayModel{
		return this.parent = parent;
	}
	
	private function __update():Void{
		
	}
	
	
	
}