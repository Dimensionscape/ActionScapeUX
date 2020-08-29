package actionscape.display;

/**
 * ...
 * @author Christopher Speciale, Dimensionscape LLC
 */
class Composition extends DisplayTargetContainer
{
	@:isVar public var smoothing(get,set):Bool = true;

	private function get_smoothing():Bool{
		return __tilemap.smoothing;
	}
	
	private function set_smoothing(value:Bool):Bool{
		return __tilemap.smoothing = value;
	}
	
	public function new() 
	{
		super();
	}
	
}