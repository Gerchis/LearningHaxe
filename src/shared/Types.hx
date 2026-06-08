package shared;

import h2d.col.IPoint;

class GridCoord {
    public var x(get, set): Int ;
    public var y(get, set): Int;
    var raw_point: IPoint = new IPoint(0, 0);

    public function new(_x:Int, _y:Int) {
        this.raw_point = new IPoint(_x, _y);
    }

    function set_x(new_x: Int): Int {
        raw_point.x = new_x;
        return raw_point.x;
    }

    function get_x(): Int {
        return raw_point.x;
    }

    function set_y(new_y: Int): Int {
        raw_point.y = new_y;
        return raw_point.y;
    }

    function get_y(): Int {
        return raw_point.y;
    }

    // function dot(other_coord: GridCoord): Int {
    //     var other_point: IPoint = new IPoint(other_coord.x, other_coord.y);

    //     return this.raw_point.dot(other_point);
    // }
}