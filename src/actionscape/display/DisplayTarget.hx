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
	
	override public function getDisplayObject():DisplayObject{
		return __displayObject;
	}
	
}