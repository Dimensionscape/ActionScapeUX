package actionscape.display;
import actionscape.core.Projector;
import actionscape.events.TouchEvent;
import actionscape.touch.Touch;
import actionscape.touch.TouchState;
import lime.utils.ObjectPool;
import openfl.Lib;
import openfl.display.Tile;
import openfl.display.TileContainer;
import openfl.display.Tilemap;
import openfl.events.Event;
import openfl.events.EventDispatcher;
import openfl.events.IEventDispatcher;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Christopher Speciale, Dimensionscape LLC
 */
@:access(actionscape.touch.Touch)
@:access(openfl.events.Event)
class DisplayModelContainer extends DisplayModel
{
	public var numChildren(get, null):Int;
	private var __tilemap:Tilemap;
	private var __children:Array<DisplayModel> = [];

	private function get_numChildren():Int
	{
		return __children.length;
	}

	override private function get_height():Float
	{
		var tempHeight:Float = 0;
		for (child in __children)
		{
			tempHeight = Math.max(child.height + child.y, tempHeight);
		}
		return tempHeight;
	}

	override private function set_height(value:Float):Float
	{
		return __tilemap.height = value;
	}

	override private function get_width():Float
	{
		var tempWidth:Float = 0;
		for (child in __children)
		{
			tempWidth = Math.max(child.width + child.x, tempWidth);
		}
		return tempWidth;
	}

	override private function set_width(value:Float):Float
	{
		return __tilemap.width = value;
	}

	public function new()
	{
		super();
		__isLeaf = false;
		#if !html5
		if (Projector.current.renderMode == "software") __tilemap = new Tilemap(8388607, 8388607);
		else __tilemap = new Tilemap(0x3FFFFFFF, 0x3FFFFFFF);
		#else
		__tilemap = new Tilemap(0x3FFFFFFF, 0x3FFFFFFF);
		#end

		__tilemap.addTile(__tileContainer);
		__tilemap.smoothing = false;
	}

	override public function dispatchEvent(event:Event):Bool
	{
		var isTouching:Bool = false;
		if (event.type == TouchEvent.TOUCH)
		{
			var touchEvent:TouchEvent = cast event;
			touchEvent.touch.__x += this.x;
			touchEvent.touch.__y += this.y;
			if (Std.is(this, Movie))
			{
				//trace("test");
				var touch:Touch = touchEvent.touch;
				touch.__touchRect.setTo(x, y, width, height);
				touch.__touchPoint.setTo(touchEvent.touch.globalX, touchEvent.touch.globalY);
				if (touchEvent.touch.__touchRect.containsPoint(touchEvent.touch.__touchPoint))
				{
					touch.touchTarget = this;
					//touch.__lastTarget.push(this);
					//touch.__lastState.push((touch.touchState == TouchState.TOUCH_OUT)?TouchState.TOUCH_OVER:touch.touchState);
					//touch.__lastX.push(touch.__touchRect.x);
					//touch.__lastY.push(touch.__touchRect.y);
					//touch.__event = touchEvent;
					isTouching = true;
				} 
			}
			else
			{
				isTouching = true;
			}
		}

		if (event.bubbles)
		{
			for (child in __children)
			{
				if (event.type == TouchEvent.TOUCH)
				{
					if (child.touchable)
					{
						if (isTouching)
						{
							var touchEvent:TouchEvent = cast event;
							var touch:Touch = touchEvent.touch;
							touch.__touchRect.setTo(touch.__x + child.x, touch.__y +  child.y, child.width, child.height);
							var tempState:String = touchEvent.touch.touchState;
							if (touch.__touchRect.containsPoint(touch.__touchPoint))
							{
								touch.touchTarget = child;
								//touch.__lastTarget.push(child);
								touch.touchState = (touch.touchState == TouchState.TOUCH_OUT)?TouchState.TOUCH_OVER:touch.touchState;
								child.__touchState = touch.touchState;
								//touch.__lastState.push(touch.touchState);
								//touch.__lastX.push(touch.__touchRect.x);
								//touch.__lastY.push(touch.__touchRect.y);
								child.dispatchEvent(event);
							}
							else
							{
								
								if (child.__touchState != TouchState.TOUCH_OUT){
									//trace("out", child);
									child.__touchState = TouchState.TOUCH_OUT;
									touchEvent.touch.touchState = TouchState.TOUCH_OUT;
									if (child.__isLeaf) child.dispatchEvent(event);
									else child.dispatchEvent(event);
									//touchEvent.touch.touchState = TouchState.TOUCH_OVER;
								}
							}
						}
					}

				}
				else child.dispatchEvent(event);

			}
		}
		if (event.type == TouchEvent.TOUCH)
		{
			var touchEvent:TouchEvent = cast event;
			if (isTouching)
			{
				if (touchEvent.touch.touchTarget != null)
					if (touchEvent.touch.touchTarget.__isLeaf)
					{
						var touchTarget:DisplayModel = touchEvent.touch.touchTarget;
						touchEvent.touch.touchState = (touchEvent.touch.touchState == TouchState.TOUCH_OUT)?TouchState.TOUCH_OVER:touchEvent.touch.touchState;						
						__targetDispatcher = touchTarget;
						super.dispatchEvent(touchEvent);
						touchEvent.touch.touchTarget = touchEvent.touch.touchTarget.parent;
						var bool:Bool = super.dispatchEvent(touchEvent);	
						 touchEvent.touch.touchTarget = touchTarget;
						 __targetDispatcher = null;
						return bool;
					}
					else if (touchEvent.touch.touchState == TouchState.TOUCH_OUT) return super.dispatchEvent(touchEvent);
			}
			else
			{
				touchEvent.touch.touchState = TouchState.TOUCH_OUT;
				return super.dispatchEvent(touchEvent);
			}
		}
		else return super.dispatchEvent(event);

		return false;
	}

	public function addChild(displayModel:DisplayModel):DisplayModel
	{
		var tileContainer:TileContainer = displayModel.__tileContainer;
		__children.push(displayModel);
		__tileContainer.addTile(tileContainer);
		__update();
		displayModel.parent = this;
		return displayModel;
	}

	public function removeChild(displayModel:DisplayModel):DisplayModel
	{
		__children.remove(displayModel);
		__tileContainer.removeTile(displayModel.__tileContainer);
		__update();
		return displayModel;
	}
	
	private function __superDispatchEvent(event:TouchEvent):Bool{
		if (__targetDispatcher != null)
		{
			event.target = __targetDispatcher;
		}
		else
		{
			event.target = this;
		}

		return super.dispatchEvent(event);
	}
	override private function __update():Void
	{
		super.__update();

	}

}