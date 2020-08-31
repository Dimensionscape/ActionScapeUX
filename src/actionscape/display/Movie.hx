package actionscape.display;
import haxe.ds.StringMap;
import openfl.display.Sprite;
import openfl.display.Window;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Christopher Speciale, Dimensionscape LLC
 */
class Movie extends Composite 
{
	
	public var currentScene:Int;
	public var scenes:Array<Scene>;
	public var isPlaying:Bool;
	public var window:Window;
	public var viewport:Rectangle;
	
	private var __sceneMap:StringMap<Int>;
	public function new() 
	{
		super();
		scenes = [];
		currentScene = -1;
		__sceneMap = new StringMap();
		isPlaying = false;		
	}
	
	public function pause():Void{
		isPlaying = false;
	}
	
	public function play():Void{
		isPlaying = true;
	}
	
	public function nextScene():Void{
		
	}
	
	public function previousScene():Void{
		
	}
	
	public function playScene(label:String):Void{
		
	}
	
	public function playSceneAt(id:Int):Void{
		
	}
	
	public function addScene(scene:Scene):Void{
		
	}
	
	public function addSceneAt(id:Int):Void{
		
	}
	
	public function removeScene(scene:Scene):Void{
		
	}
	
	public function removeSceneAt(id:Int):Void{
		
	}
	
	public function getScene(id:Int):Scene{
		return new Scene();
	}
	
	public function getSceneID(scene:Scene):Int{
		return 0;
	}
	
	public function getSceneByName(name:Scene):Void{
		
	}
	
	
	
}