package actionscape.events;
import actionscape.touch.Touch;
import openfl.events.Event;
/**
 * ...
 * @author Christopher Speciale, Dimensionscape LLC
 */
class TouchEvent extends Event
{
	public static inline var TOUCH:String = "touch";
	public var touch:Touch;	

	public function new(type: String, touch:Touch, bubbles: Bool = false, cancelable: Bool = false)
	{
		super(type, bubbles, cancelable);
		this.touch = touch;		
	}	

	public override function clone(): Event
	{
		return new TouchEvent(type, touch, bubbles, cancelable);
	}

}