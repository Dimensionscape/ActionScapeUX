package actionscape.display;
import openfl.display.Sprite;
import openfl.events.Event;

/**
 * ...
 * @author Christopher Speciale, Dimensionscape LLC
 */

 /**
The Composite class enables the seamless combination of DisplayTarget 
wrapped DisplayObjects and DisplayModels within a single parent container
while minimizing draw calls by batching children branches when possible.

Using the Composite class almost always requires the most draw calls and
should be avoided if traditional DisplayObjects are unnecessary or can be
drawn in the nativeForeground or nativeBackground containers.

Traditional DisplayObjects cannot be added or removed directly to and from
a Composite with the `addChild()` and `removeChild()` methods. There are 2
ways to handle adding and removing DisplayObjects from a Composite: 1.) Using
the DisplayTarget wrapped DisplayObjects located in the actionscape.display
package with the `addChild()` and `removeChild()` methods, or 2.) Adding
traditional DisplayObjects without a wrapper into the nativeForeground or 
nativeBackground containers.
 **/
class Composite extends DisplayModelContainer 
{
	public var nativeBackground(get,null):Sprite;
	public var nativeForeground(get,null):Sprite;
	private var __compositeContainer:Sprite;
	
	private function get_nativeBackground():Sprite{
		return nativeBackground;
	}
	
	private function get_nativeForeground():Sprite{
		return nativeForeground;
	}
	
	public function new() 
	{
		super();
		nativeBackground = new Sprite();
		nativeForeground = new Sprite();
		__compositeContainer = new Sprite();
		var sprite:Sprite = new Sprite();		
		sprite.addChild(nativeBackground);
		sprite.addChild(__compositeContainer);
		sprite.addEventListener(Event.ADDED_TO_STAGE, __onAddedToStage);
		sprite.addChild(nativeBackground);
		displayObject = sprite;
		
	}
	
	override public function addChild(displayModel:DisplayModel):DisplayModel{		
		__compositeContainer.addChild(displayModel.displayObject);
		__children.push(displayModel);
		displayModel.parent = this;
		return displayModel;
	}
	
	
	override public function removeChild(displayTarget:DisplayModel):DisplayModel
	{
		__children.remove(displayTarget);
		__compositeContainer.removeChild(displayTarget.displayObject);	
		//displayTarget.__disposeDisplayObject();
		return displayTarget;
	}	
	
	private function __onAddedToStage(e:Event):Void{
		displayObject.addEventListener(Event.ADDED_TO_STAGE, __onAddedToStage);
		displayObject.removeEventListener(Event.ADDED_TO_STAGE, __onAddedToStage);
		dispatchEvent(e);
	}
	
	private function __onRemovedFromStage(e:Event):Void{
		displayObject.addEventListener(Event.ADDED_TO_STAGE, __onAddedToStage);
		displayObject.removeEventListener(Event.REMOVED_FROM_STAGE, __onRemovedFromStage);
		dispatchEvent(e);
	}
}