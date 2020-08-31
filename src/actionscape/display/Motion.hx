package actionscape.display;
import actionscape.display.DisplayModel;
import openfl.display.Tile;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Christopher Speciale, Dimensionscape LLC
 */
class Motion extends DisplayModel
{
	var frames:Array<Tile>;
	var tile:Tile;
	var frameRate:Int;
	var frameTime:Float;
	var currentTime:Float = 0;
	var maxTime:Float = 0;
	var isPlaying:Bool = false;
	@:isVar public var currentFrame(get, set):Int = 0;

	private function set_currentFrame(value:Int):Int
	{
		if (value > frames.length-1) value = 0;
		__setFrame(value);
		return currentFrame = value;
	}

	private function get_currentFrame():Int
	{
		return currentFrame;
	}
	public function new(tiles:Array<Tile> = null, frameRate:Int = 10)
	{
		super();

		frames = tiles;
		this.frameRate = frameRate;
		frameTime = 1 / frameRate;
		maxTime = frames.length * frameTime;

		tile = new Tile();
		if (frames!=null)
		{
			tile.id = frames[0].id;
			tile.tileset = frames[0].tileset;
		}
		else frames = [];

		__tileContainer.addTile(tile);
		width = tile.width;
		height = tile.height;

	}

	public function advanceTime(time:Float):Void
	{
		if (isPlaying)
		{
			currentTime+= time;

			while (currentTime > frameTime)
			{
				nextFrame();
				currentTime-= frameTime;
			}
		}
	}

	private function nextFrame():Void
	{
		currentFrame++;
	}

	public function addFrame(tile:Tile):Void
	{
		frames.push(tile);
	}

	public function addFrameAt(tile:Tile, index:Int):Void
	{
		frames.insert(index, tile);
	}

	public function stop(frame:Int = -1):Void
	{
		isPlaying = false;
		if (frame >-1) __setFrame(frame);
	}
	public function play(frame:Int = -1):Void
	{
		isPlaying = true;
		if (frame >-1) __setFrame(frame);
	}

	private function __setFrame(frame:Int):Void
	{
		tile.id = frames[frame].id;
	}

}