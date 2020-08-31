package actionscape.display;
import openfl.display.DisplayObject;
import openfl.display.Tilemap;

/**
 * ...
 * @author Christopher Speciale, Dimensionscape LLC
 */
class Composition extends DisplayModelContainer
{
	@:isVar public var smoothing(get, set):Bool = true;
	
	@:isVar public var pivotX(get, set):Float = 0;
	@:isVar public var pivotY(get, set):Float = 0;
	private var __hasDisplayObjects:Bool = false;

	
	private function get_pivotX():Float{
		return pivotX;
	}
	
	private function set_pivotX(value:Float):Float{
		return pivotX = value;
	}
	
	private function get_pivotY():Float{
		return pivotY;
	}
	
	private function set_pivotY(value:Float):Float{
		return pivotY = value;
	}

	private function get_smoothing():Bool{
		return __tilemap.smoothing;
	}
	
	private function set_smoothing(value:Bool):Bool{
		return __tilemap.smoothing = value;
	}
	
	public function new() 
	{
		super();		
	}	
	
}