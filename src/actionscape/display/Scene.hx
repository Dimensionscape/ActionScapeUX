package actionscape.display;
import openfl.utils.Function;
import openfl.display.Sprite;

/**
 * ...
 * @author Christopher Speciale, Dimensionscape LLC
 */
class Scene extends Composition 
{
	private var __sprite:Sprite;
	private var __allowDisplayObjects:Bool;
	public var id:Int;
	public var label:String;
	public var onInit:Function;
	public var onDispose:Function;
	public var onSuspend:Function;
	public var onResume:Function;
	public function new(allowDisplayObjects:Bool = false) 
	{
		super();
		__allowDisplayObjects = allowDisplayObjects;
		__sprite = new Sprite();
	}
	
	public function suspend():Void{
		
	}
	
	public function resume():Void{
		
	}
	
	private function __onInit():Void{
		if (onDispose != null) onDispose();
	}
	
	private function __onDispose():Void{
		if (onDispose != null) onDispose();
	}
	
}