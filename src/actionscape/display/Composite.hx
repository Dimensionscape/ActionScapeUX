package actionscape.display;
import openfl.display.Sprite;

/**
 * ...
 * @author Christopher Speciale, Dimensionscape LLC
 */
class Composite extends DisplayModelContainer 
{
	private var __sprite:Sprite;
	private var __hasDisplayObject:Bool = false;

	public function new() 
	{
		super();
		__sprite = new Sprite();
		
	}
	
	override public function addChild(displayModel:DisplayModel):DisplayModel{		
		__sprite.addChild(displayModel.getDisplayObject());
		__children.push(displayModel);
		return displayModel;
	}
	
}