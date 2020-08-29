package actionscape.touch;
import actionscape.events.TouchEvent;
import openfl.events.EventDispatcher;

/**
 * ...
 * @author Christopher Speciale, Dimensionscape LLC
 */
class Touch 
{
	public var globalX:Float;
	public var globalY:Float;
	public var target:EventDispatcher;
	public var touchState:String;
	public function new(mouseX:Float, mouseY:Float, touchState:String) 	{
		
		globalX = mouseX;
		globalY = mouseY;
		this.touchState = touchState;
		
	}
	
}