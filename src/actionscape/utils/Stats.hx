package actionscape.utils;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;

/**
 * ...
 * @author Christopher Speciale, Dimensionscape LLC
 */
class Stats extends Sprite
{

	
	private var __times:Array<Int> = [];
	private var __memoryField:TextField;
	private var __fpsField:TextField;
	private var __drawCallField:TextField;
	private var __BtoMB:Float = 1.0 / (1024 * 1024);
	private var __frameCount:Int = 0;
	private var __calls:Int = 0;
	public function new() 
	{
		super();
		#if !gl_stats
		throw("Cannot display stats: build missing -Dgl_stats");
		#end
		var textFormat:TextFormat = new TextFormat(null, 10, 0xFFFFFF);
		__fpsField = new TextField();
		__fpsField.text = "FPS: ";
		__fpsField.setTextFormat(textFormat);
		__fpsField.background = true;
		__fpsField.backgroundColor = 0x0;
		__fpsField.width = 76;
		__fpsField.height = 12;
		__fpsField.x = 0;
		__fpsField.y = 0;		
		addChild(__fpsField);
		
		__memoryField = new TextField();
		__memoryField.text = "RAM: ";
		__memoryField.setTextFormat(textFormat);	
		__memoryField.background = true;
		__memoryField.backgroundColor = 0x0;
		__memoryField.width = 76;
		__memoryField.height = 12;
		__memoryField.x = 0;
		__memoryField.y = 12;	
		addChild(__memoryField);
		
		__drawCallField = new TextField();
		__drawCallField.text = "Draw Calls: ";
		__drawCallField.setTextFormat(textFormat);
		__drawCallField.background = true;
		__drawCallField.backgroundColor = 0x0;
		__drawCallField.width = 76;
		__drawCallField.height = 12;
		__drawCallField.x = 0;
		__drawCallField.y = 24;
		addChild(__drawCallField);
		var calls:Int = 0;
		__drawCallField.text = "Draw Calls: " + openfl.display._internal.stats.Context3DStats.totalDrawCalls();
		addEventListener(Event.ENTER_FRAME, __onFrameUpdate);
	}
	
	private function __onFrameUpdate(e:Event):Void{
		var now = Lib.getTimer();
		__times.push(now);		
		while(__times[0] < now-1000) __times.shift();
		
		if (__frameCount++> __times.length * .5) __updateStats();	
		var calls:Int = openfl.display._internal.stats.Context3DStats.totalDrawCalls();	
		if(calls>0&&calls!=__calls)	__drawCallField.text = "Draw Calls: " + (__calls = calls);	
	}
	
	private function __updateStats():Void{
		__frameCount = 0;
		__fpsField.text = "FPS: " + __times.length;
		__memoryField.text = "RAM: " + Std.int(System.totalMemory * __BtoMB * 100) / 100 + "mb";
		
		
	}
}