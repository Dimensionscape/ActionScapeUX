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
	
	private var gravity:Float;
	private var minX:Int;
	private var minY:Int;
	private var maxX:Int;
	private var maxY:Int;
	private var __motions:Array<TileAnim> = [];
	public static var current:Animator;
	public function new() 
	{
		
		super();
		minX = 0;
		maxX = Lib.current.stage.stageWidth-32;
		minY = 0;
		maxY = Lib.current.stage.stageHeight-32;
		gravity = 0.5;
		current = this;
		Actionscape.current.root.addEventListener(FrameEvent.FRAME_UPDATE, __onFrameUpdate);
		
	}
	
	public function add(motion:TileAnim):Void{
		__motions.push(motion);
	}
	private function __onFrameUpdate(e:FrameEvent):Void{
		for (motion in __motions){
			motion.advanceTime(e.passedTime);
			
			
			
			motion.x += motion.speedX;
			motion.y += motion.speedY;
			motion.speedY += gravity;
			
			if (motion.x > maxX) {
				
				motion.speedX *= -1;
				motion.x = maxX;
				
			} else if (motion.x < minX) {
				
				motion.speedX *= -1;
				motion.x = minX;
				
			}
			
			if (motion.y > maxY) {
				
				motion.speedY *= -0.8;
				motion.y = maxY;
				
				if (Math.random () > 0.5) {
					
					motion.speedY -= 3 + Math.random () * 4;
					
				}
				
			} else if (motion.y < minY) {
				
				motion.speedY = 0;
				motion.y = minY;
				
			}
			
			
			
		
		}
	}
	
}