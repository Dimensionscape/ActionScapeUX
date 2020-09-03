package actionscape.touch;
import actionscape.display.DisplayModel;
import actionscape.events.TouchEvent;
import haxe.ds.WeakMap;
import openfl.events.Event;
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
	public var touchTarget:DisplayModel = null;

	private var __touchRect:Rectangle;
	private var __touchPoint:Point;
	private var __lastTarget:Array<DisplayModel> = [];
	private var __lastState:Array<String> = [];
	private var __lastY:Array<Float> = [];
	private var __lastX:Array<Float> = [];
	private var __x:Float = 0;
	private var __y:Float = 0;
	private var __event:TouchEvent;
	public function new(mouseX:Float, mouseY:Float, touchState:String)
	{

		globalX = mouseX;
		globalY = mouseY;
		this.touchState = touchState;
		__touchRect = new Rectangle();
		__touchPoint = new Point();

	}

	private function __processTouches():Void
	{
		var i:Int = __lastX.length;
		while (i-->0)
		{
			var lastTarget:DisplayModel = __lastTarget[i];
			var lastState:String = __lastState[i];
			switch (__lastState[i])
			{
				case TouchState.TOUCH_OVER:
					__touchRect.setTo(lastTarget.x, lastTarget.y, lastTarget.width, lastTarget.height);
					if (!__touchRect.containsPoint(__touchPoint))
					{
						touchState = TouchState.TOUCH_OUT;
						lastTarget.dispatchEvent(__event);
						__lastState.splice(i, 1);
						__lastTarget.splice(i, 1);
						__lastX.splice(i, 1);
						__lastY.splice(i, 1);
						continue;
					}
				case TouchState.TOUCH_DOWN:
			}
		}

	}

}