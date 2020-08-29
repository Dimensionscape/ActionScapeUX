package actionscape.core;
import actionscape.display.DisplayTarget;
import actionscape.display.DisplayTargetContainer;
import actionscape.events.FrameEvent;
import actionscape.events.TouchEvent;
import actionscape.render.Animator;
import actionscape.touch.Touch;
import actionscape.touch.TouchState;
import openfl.Lib.getTimer;
import openfl.display.Sprite;
import openfl.display.Stage;
import openfl.events.Event;
import openfl.events.EventDispatcher;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Christopher Speciale, Dimensionscape LLC
 */
@:access(actionscape.display.DisplayTargetContainer)
class Projector extends EventDispatcher
{
	public var root:DisplayTargetContainer;
	private var __sprite:Sprite;
	private var __touchState:String = TouchState.TOUCH_OUT;
	private var __passedTime:Float = 0;
	private var __previousTime:Float = 0;
	public static var current:Projector;
	public static var animator:Animator;
	public var drawCalls:Int =0;
	public function new(stage:Stage, rootClass:Class<DisplayTargetContainer>) 
	{
		super();
		current = this;		
		__sprite = new Sprite();
		stage.addChild(__sprite);
		
		root = Type.createInstance(rootClass, []);		
		__sprite.addChild(root.__tilemap);
		
		animator = new Animator();
		
		stage.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent){
			__touchState = TouchState.TOUCH_DOWN;
		});
		stage.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent){
			__touchState = TouchState.TOUCH_UP;
		});
		stage.addEventListener(Event.ENTER_FRAME, __frameUpdate);
	}
	
	private function __frameUpdate(e:Event):Void{
	
		var touch:Touch = new Touch(__sprite.mouseX, __sprite.mouseY, __touchState);
		var touchEvent:TouchEvent = new TouchEvent(TouchEvent.TOUCH, touch, true, true);		
		root.dispatchEvent(touchEvent);
		__touchState = TouchState.TOUCH_OUT;
		
		var currentTime = getTimer();
		__passedTime = currentTime - __previousTime;
		__previousTime = currentTime;		
		root.dispatchEvent(new FrameEvent(FrameEvent.FRAME_UPDATE, __passedTime*.001, true, true));
	}
}