package actionscape.render;
import actionscape.core.Actionscape;
import actionscape.display.Motion;
import actionscape.events.FrameEvent;
import openfl.Lib;
import openfl.events.EventDispatcher;

/**
 * ...
 * @author Christopher Speciale, Dimensionscape LLC
 */
class Animator extends EventDispatcher
{
	

	private var __motions:Array<Motion> = [];
	public static var current:Animator;
	public function new() 
	{
		
		super();
	
		current = this;
		Actionscape.current.root.addEventListener(FrameEvent.FRAME_UPDATE, __onFrameUpdate);
		
	}
	
	public function add(motion:Motion):Void{
		__motions.push(motion);
	}
	private function __onFrameUpdate(e:FrameEvent):Void{
		for (motion in __motions){
			motion.advanceTime(e.passedTime);		
		}
	}
	
}