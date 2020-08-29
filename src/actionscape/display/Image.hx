package actionscape.display;
import actionscape.display._internal.Scale9Grid;
import openfl.display.Tile;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Christopher Speciale, Dimensionscape LLC
 */
@:access(actionscape.display._internal.Scale9Grid)
class Image extends DisplayTarget
{
	
	@:isVar public var tile:Tile;
	@:isVar public var scale9Grid(get,set):Rectangle;
	private var __scale9Grid:Scale9Grid;
	private var __originBounds:Rectangle;
	
	public function get_scale9Grid():Rectangle{
		return scale9Grid;
	}
	
	public function set_scale9Grid(value:Rectangle):Rectangle{
			__tileContainer.scaleX = 1;
			__tileContainer.scaleY = 1;
		if(value!=null){
		__scale9Grid = new Scale9Grid(tile.tileset, tile.tileset.getRect(tile.id), value);
		__tileContainer.removeTileAt(0);
		__tileContainer.addTile(__scale9Grid.__tileContainer);
		parent.__update();
		width = width;
		height = height;
		} else {
			__tileContainer.removeTileAt(0);
			__tileContainer.addTile(tile);
		}
		return scale9Grid = value;
	}
	
	override private function get_height():Float{
		return height;
	}
	
	override private function set_height(value:Float):Float{
		if (__scale9Grid != null) __scale9Grid.__setHeight(value);
		else __tileContainer.scaleY = value / __originBounds.height;
		if(parent!=null) parent.__update();
		return height = value;
	}
	
	override private function get_width():Float{
		return width;
	}
	
	override private function set_width(value:Float):Float{
		if (__scale9Grid != null) __scale9Grid.__setWidth(value);
		else __tileContainer.scaleX =  value / __originBounds.width;		
		
		if (parent != null) parent.__update();
		return width = value;
	}	

	public function new(tile:Tile) 
	{
		super();
		this.tile = tile;
		__tileContainer.addTile(tile);
		__originBounds = tile.getBounds(tile);		
		width = __originBounds.width;
		height = __originBounds.height;
		
		
	}
	
}