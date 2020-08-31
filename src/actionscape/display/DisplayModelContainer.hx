package actionscape.display;
import actionscape.core.Projector;
import actionscape.events.TouchEvent;
import actionscape.touch.TouchState;
import openfl.Lib;
import openfl.display.Tile;
import openfl.display.TileContainer;
import openfl.display.Tilemap;
import openfl.events.Event;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Christopher Speciale, Dimensionscape LLC
 */
//@:access(
class DisplayModelContainer extends DisplayModel
{
	private var __tilemap:Tilemap;
	private var __children:Array<DisplayModel> = [];	
	
	override private function get_height():Float{
		var tempHeight:Float = 0;
		for (child in __children){
			tempHeight = Math.max(child.height + child.y, tempHeight);
		}
		return tempHeight;
	}
	
	override private function set_height(value:Float):Float{
		return __tilemap.height = value;
	}
	
	override private function get_width():Float{
		var tempWidth:Float = 0;
		for (child in __children){
			tempWidth = Math.max(child.width + child.x, tempWidth);
		}
		return tempWidth;
	}
	
	override private function set_width(value:Float):Float{
		return __tilemap.width = value;
	}
	
	public function new()
	{
		super();
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
		var bool:Bool = false;
		if (event.type == TouchEvent.TOUCH)
		{
			if (hasEventListener(TouchEvent.TOUCH))
			{
				var touchEvent:TouchEvent = cast event;
				if (new Rectangle(x, y, width, height).containsPoint(new Point(touchEvent.touch.globalX, touchEvent.touch.globalY)))
				{
					touchEvent.touch.touchState = (touchEvent.touch.touchState == TouchState.TOUCH_OUT)?TouchState.TOUCH_OVER:touchEvent.touch.touchState;
					bool = super.dispatchEvent(event);
				}
				else
				{
					touchEvent.touch.touchState = TouchState.TOUCH_OUT;
					bool = super.dispatchEvent(event);
				}
			}
		} else {
			super.dispatchEvent(event);
		}

		if (event.bubbles)
		{
			for (child in __children)
			{
				if (event.type == TouchEvent.TOUCH)
				{
					if (child.hasEventListener(TouchEvent.TOUCH))
					{
						var touchEvent:TouchEvent = cast event;
						if (new Rectangle(child.x, child.y, child.width, child.height).containsPoint(new Point(touchEvent.touch.globalX, touchEvent.touch.globalY)))
						{
							touchEvent.touch.touchState = (touchEvent.touch.touchState == TouchState.TOUCH_OUT)?TouchState.TOUCH_OVER:touchEvent.touch.touchState;
							child.__targetDispatcher = event.target;
							child.dispatchEvent(event);
						}
						else
						{
							touchEvent.touch.touchState = TouchState.TOUCH_OUT;
							child.dispatchEvent(event);
						}
					}
				}
				else
				{
					child.__targetDispatcher = event.target;
					child.dispatchEvent(event);
				}
			}
		}
		return bool;
	}

	public function addChild(displayTarget:DisplayModel):DisplayModel
	{
		var tileContainer:TileContainer = displayTarget.__tileContainer;
		__children.push(displayTarget);
		__tileContainer.addTile(tileContainer);
		__update();
		displayTarget.set_parent(this);
		return displayTarget;
	}
	
	public function removeChild(displayTarget:DisplayModel):DisplayModel
	{
		__children.remove(displayTarget);
		__tileContainer.removeTile(displayTarget.__tileContainer);
		__update();
		return displayTarget;
	}	
	
	override private function __update():Void{
		super.__update();
	
	}

}