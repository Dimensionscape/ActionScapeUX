package actionscape.core;
import actionscape.display.DisplayModel;
import actionscape.display.DisplayModelContainer;
import actionscape.display.Movie;
import actionscape.events.FrameEvent;
import actionscape.events.TouchEvent;
import actionscape.render.Animator;
import actionscape.touch.Touch;
import actionscape.touch.TouchState;
import actionscape.utils.Stats;
import openfl.Lib.getTimer;
import lime.app.Application;
import openfl.display.Sprite;
import openfl.display.Stage;
import openfl.events.Event;
import openfl.events.EventDispatcher;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Christopher Speciale, Dimensionscape LLC
 */
@:access(actionscape.display.Movie)
class Projector extends EventDispatcher
{
	public var root:Movie;
	private var __sprite:Sprite;
	private var __touchState:String = TouchState.TOUCH_OUT;
	private var __passedTime:Float = 0;
	private var __previousTime:Float = 0;
	public static var current:Projector;
	public static var animator:Animator;
	public var renderMode(get, null):String;
	private var __stats:Stats;
	private var __stage:Stage;
	
	private function get_renderMode():String{
		return renderMode;
	}
	public function new(stage:Stage, rootClass:Class<Movie>)
	{
		super();
		current = this;
		renderMode = Application.current.window.context.attributes.hardware ? "hardware" : "software";
		root = Type.createInstance(rootClass, []);
		root.stage = stage;
		__sprite = cast root.displayObject;
		(__stage = stage).addChild(__sprite);		
		
		animator = new Animator();

		stage.addEventListener(Event.ENTER_FRAME, __frameUpdate);
		
		stage.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent)
		{
			__touchState = TouchState.TOUCH_DOWN;
			var touch:Touch = new Touch(__sprite.mouseX, __sprite.mouseY, __touchState);
			var touchEvent:TouchEvent = new TouchEvent(TouchEvent.TOUCH, touch, true, true);
			root.dispatchEvent(touchEvent);
		});
		stage.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent)
		{
			__touchState = TouchState.TOUCH_UP;
			var touch:Touch = new Touch(__sprite.mouseX, __sprite.mouseY, __touchState);
			var touchEvent:TouchEvent = new TouchEvent(TouchEvent.TOUCH, touch, true, true);
			root.dispatchEvent(touchEvent);
		});
		
	}

	public function showStats(enabled:Bool):Void
	{
		if (enabled)
		{
			if (__stats == null) __stage.addChild(__stats = new Stats());
		}
		else {
			if (__stats != null) __stage.removeChild(__stats);
			__stats = null;
		}

	}

	private function __frameUpdate(e:Event):Void
	{
		if (__touchState != TouchState.TOUCH_DOWN && __touchState != TouchState.TOUCH_UP){
			var touch:Touch = new Touch(__sprite.mouseX, __sprite.mouseY, __touchState);
			var touchEvent:TouchEvent = new TouchEvent(TouchEvent.TOUCH, touch, true, true);
			root.dispatchEvent(touchEvent);		
		}
		__touchState = TouchState.TOUCH_OUT;
	
		var currentTime = getTimer();
		__passedTime = currentTime - __previousTime;
		__previousTime = currentTime;
		root.dispatchEvent(new FrameEvent(FrameEvent.FRAME_UPDATE, __passedTime*.001, true, true));
	}
}