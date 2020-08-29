package actionscape.display._internal;
import openfl.display.Tile;
import openfl.display.TileContainer;
import openfl.display.Tileset;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Christopher Speciale, Dimensionscape LLC
 */
@:noCompletion class Scale9Grid 
{
//(id:Int = 0, x:Float = 0, y:Float = 0, scaleX:Float = 1, scaleY:Float = 1, rotation:Float = 0, originX:Float = 0, originY:Float = 0)
	private var __partition:Array<Array<Tile>> = [[], [], []];
	private var __tileContainer:TileContainer;
	private var __originBounds:Rectangle;
	@:noCompletion public function new(tileset:Tileset, tileRect:Rectangle, scale9Rect:Rectangle) 
	{			
		/*
		///////I1/////I2/////I3
		//XY   //XY   //XY   //
		//  00 //  01 //  02 //
		//   WH//   WH//   WH//
		I4/////////////////////
		//XY   //XY   //XY   //
		//  10  // 11 //  12 //
		//   WH//   WH//   WH//
		i5/////////////////////
		//XY   //XY   //XY   //
		//  20 //  21 //  22 //
		//   WH//   WH//   WH//
		i6/////////////////////
		*/
		__tileContainer = new TileContainer( 0, 0);
		__tileContainer.tileset = tileset;
		__originBounds = tileRect;
		var swx:Int = cast scale9Rect.width + scale9Rect.x;
		var shy:Int = cast scale9Rect.height + scale9Rect.y;
		var i1:Int = cast tileRect.x + scale9Rect.x;
		var i2:Int = cast i1 + scale9Rect.width;
		var i3:Int = cast Math.abs(tileRect.width - swx);
		var i4:Int = cast tileRect.y + scale9Rect.y;
		var i5:Int = cast i4 + scale9Rect.height;
		var i6:Int = cast Math.abs(tileRect.height - shy);
		
		//top left
		var sRect:Rectangle = new Rectangle(tileRect.x, tileRect.y, scale9Rect.x, scale9Rect.y);
		var tile:Tile = null;
		__partition[0].push(tile = new Tile(tileset.addRect(sRect), 0, 0));		
		__tileContainer.addTile(tile);	
		tile.data = tile.getBounds(tile);
		//top center
		sRect.setTo(i1, tileRect.y, scale9Rect.width, scale9Rect.y);
		__partition[0].push(tile = new Tile(tileset.addRect(sRect), scale9Rect.x, 0));
		__tileContainer.addTile(tile);		
		tile.data = tile.getBounds(tile);
		//top right
		sRect.setTo(i2, tileRect.y, i3, scale9Rect.y);
		__partition[0].push(tile = new Tile(tileset.addRect(sRect), swx, 0));
		__tileContainer.addTile(tile);		
		tile.data = tile.getBounds(tile);
		//left center
		sRect.setTo(tileRect.x, i4, scale9Rect.x, scale9Rect.height);
		__partition[1].push(tile = new Tile(tileset.addRect(sRect), 0, scale9Rect.y));
		__tileContainer.addTile(tile);
		tile.data = tile.getBounds(tile);
		//center
		sRect.setTo(i1, i4, scale9Rect.width, scale9Rect.height);
		__partition[1].push(tile = new Tile(tileset.addRect(sRect), scale9Rect.x, scale9Rect.y));
		__tileContainer.addTile(tile);
		tile.data = tile.getBounds(tile);
		//right center
		sRect.setTo(i2, i4, i3, scale9Rect.height);
		__partition[1].push(tile = new Tile(tileset.addRect(sRect), swx, scale9Rect.y));			
		__tileContainer.addTile(tile);
		tile.data = tile.getBounds(tile);
		
		//bottom left
		sRect.setTo(tileRect.x, i5, scale9Rect.x, i6);
		__partition[2].push(tile = new Tile(tileset.addRect(sRect), 0, shy));
		__tileContainer.addTile(tile);
		tile.data = tile.getBounds(tile);
		//bottom center
		sRect.setTo(i1, i5, scale9Rect.width, i6);
		__partition[2].push(tile = new Tile(tileset.addRect(sRect), scale9Rect.x, shy));
		__tileContainer.addTile(tile);
		tile.data = tile.getBounds(tile);
		//bottom right
		sRect.setTo(i2, i5, i3, i6);
		__partition[2].push(tile = new Tile(tileset.addRect(sRect), swx, shy));
		__tileContainer.addTile(tile);
		tile.data = tile.getBounds(tile);
	}
	
	private function __setWidth(value:Float):Void{
		__tileContainer.scaleX = 1;
		var tile:Tile = __partition[0][1];
		var tileWidth:Float = tile.data.width;
		var originWidth:Float = __originBounds.width;
		var percent:Float = tileWidth / originWidth;
		
		var scale:Float = value / __originBounds.width;
		
		var scaleX:Float = scale / percent;
		tile.scaleX = scaleX;		
		
		var prevX:Float = tile.getBounds(tile.parent).width;		
		tile = __partition[0][2];
		tile.x = prevX;
		
		
		tile = __partition[1][1];
		tileWidth = tile.data.width;
		percent = tileWidth / originWidth;
		scaleX = scale / percent;
		tile.scaleX = scaleX;
		
		prevX = tile.getBounds(tile.parent).width;		
		tile = __partition[1][2];
		tile.x = prevX;
		
		tile = __partition[2][1];
		tileWidth = tile.data.width;
		percent = tileWidth / originWidth;
		scaleX = scale / percent;
		tile.scaleX = scaleX;
		
		prevX = tile.getBounds(tile.parent).width;		
		tile = __partition[2][2];
		tile.x = prevX;
	
	}
	
	private function __setHeight(value:Float):Void{
		__tileContainer.scaleY = 1;
		var tile:Tile = __partition[1][0];
		var tileHeight:Float = tile.data.height;
		var originHeight:Float = __originBounds.height;
		var percent:Float = tileHeight / originHeight;
		
		var scale:Float = value / __originBounds.height;
		
		var scaleY:Float = scale / percent;
		tile.scaleY = scaleY;		
		
		var prevY:Float = tile.getBounds(tile.parent).height;		
		tile = __partition[2][0];
		tile.y = prevY;
		
		
		tile = __partition[1][1];
		tileHeight = tile.data.height;
		percent = tileHeight / originHeight;
		scaleY = scale / percent;
		tile.scaleY = scaleY;
		
		prevY = tile.getBounds(tile.parent).height;		
		tile = __partition[2][1];
		tile.y = prevY;
		
		tile = __partition[1][2];
		tileHeight = tile.data.height;
		percent = tileHeight / originHeight;
		scaleY = scale / percent;
		tile.scaleY = scaleY;
		
		prevY = tile.getBounds(tile.parent).height;		
		tile = __partition[2][2];
		tile.y = prevY;
	
	}
	
	
}