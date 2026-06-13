package grid;

import h2d.Tile;
import h2d.col.IPoint;
import h2d.SpriteBatch;

class CellRender extends SpriteBatch.BasicElement {
    public var coord: IPoint;

    public function new(x_coord: Int, y_coord: Int, sprite: Tile) {
        super(sprite);

        this.coord = new IPoint(x_coord, y_coord);
        x = x_coord * 32;
        y = y_coord * 16;
    }
}