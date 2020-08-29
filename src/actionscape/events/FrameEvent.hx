package actionscape.events;
import openfl.events.Event;
/**
 * ...
 * @author Christopher Speciale, Dimensionscape LLC
 */
class FrameEvent extends Event
{
	public static inline var FRAME_UPDATE:String = "frameUpdate";
	public var passedTime: Float;	

	public function new(type: String, passedTime:Float, bubbles: Bool = false, cancelable: Bool = false)
	{
		super(type, bubbles, cancelable);
		this.passedTime = passedTime;
	}	

	public override function clone(): Event
	{
		return new FrameEvent(type, passedTime, bubbles, cancelable);
	}

}