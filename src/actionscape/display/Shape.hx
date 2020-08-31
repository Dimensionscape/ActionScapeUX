package actionscape.display;
import openfl.display.Graphics;
import openfl.display.Shape;
import openfl.display.TileContainer;

/**
 * ...
 * @author Christopher Speciale, Dimensionscape LLC
 */
typedef OpenFLShape = openfl.display.Shape;

class Shape extends DisplayTarget
{
	
	public var graphics(get, null):Graphics;
	
	private function get_graphics():Graphics{		
		return cast (__displayObject,OpenFLShape).graphics;
	}
	public function new() 
	{
		super();
		__displayObject = cast new OpenFLShape();
		
	}
	
	override public function set_x(value:Float):Float{
		return __displayObject.x = value;
	}
	
	override public function get_x():Float{
		return __displayObject.x;
	}
	
	override public function set_y(value:Float):Float{
		return __displayObject.y = value;
	}
	
	override public function get_y():Float{
		return __displayObject.y;
	}
	
}