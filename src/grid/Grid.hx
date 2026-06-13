package grid;

import h2d.col.Point;
import shared.Types.GridCoord;
import hxd.Res;
import h2d.Object;
import hxd.Math;
import h2d.Tile;
import hxd.res.Image;
import h2d.SpriteBatch;
import entities.GridEntity;

class Grid extends Object{
    static public var current_grid: Grid;
    public var entities: Array<GridEntity> = [];

    var rows: Int = 0;
    var columns: Int = 0;

    var cell_width: Float = 1.0;
    var cell_heigth: Float = 1.0;

    var renderer: SpriteBatch;

    public function new(columns:Int, rows:Int, cell_width: Float, cell_heigth: Float, parent: Object) {
        super(parent);
        this.columns = columns;
        this.rows = rows;
        this.cell_width = cell_width;
        this.cell_heigth = cell_heigth;

        set_as_current();

        draw_grid(Res.cell);
    }

    public function add_entity_at(new_entity: GridEntity, coord: GridCoord) {
        addChild(new_entity);
        new_entity.set_coord(coord);
        new_entity.apply_coord();
        entities.push(new_entity);
    }

    public function grid_ccord_to_position(coord: GridCoord): Point {
        var x_pos: Float = (coord.x * cell_width) + (cell_width/2.0);
        var y_pos: Float = (coord.y * cell_width) + (cell_heigth/2.0);

        return new Point(x_pos, y_pos);
    }

    public function set_as_current() {
        Grid.current_grid = this;
    }

    function draw_grid(cell_image: Image) {
        var cell_tile: Tile = cell_image.toTile();
        cell_tile.dx = -(cell_tile.width/2.0);
        cell_tile.dy = -(cell_tile.height/2.0);
        renderer = new SpriteBatch(cell_tile, parent);
        

        for (i in 0...(columns*rows)){
            var cell: CellRender = new CellRender(
                Std.int(i%columns),
                Math.floor(i/columns),
                cell_tile
            );

            renderer.add(cell);
        }
    }
}