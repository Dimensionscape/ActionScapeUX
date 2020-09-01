package actionscape.display;
import actionscape.display.DisplayModel;
import openfl.display.DisplayObject;

/**
 * ...
 * @author Christopher Speciale, Dimensionscape LLC
 */
class DisplayTarget extends DisplayModel 
{
	private var __displayObject:DisplayObject;
	public function new() 
	{
		super();
	}
	
	override private function get_displayObject():DisplayObject{		
		return __displayObject;
	}
	
}