package actionscape.touch;
import actionscape.events.TouchEvent;
import openfl.events.IEventDispatcher;
import openfl.geom.Rectangle;
import openfl.events.EventDispatcher;
import openfl.geom.Point;

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
	public var touchTarget:IEventDispatcher = null;
	
	private var __touchRect:Rectangle;
	private var __touchPoint:Point;
	private var __x:Float = 0;
	private var __y:Float = 0;
	public function new(mouseX:Float, mouseY:Float, touchState:String) 	{
		
		globalX = mouseX;
		globalY = mouseY;
		this.touchState = touchState;
		__touchRect = new Rectangle();
		__touchPoint = new Point();
		
	}
	
}