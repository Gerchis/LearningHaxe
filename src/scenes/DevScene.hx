package scenes;

import entities.Player;
import shared.Types.GridCoord;
import grid.Grid;
import h2d.Scene;
import entities.GridEntity;

class DevScene extends Scene{
    var entities: Array<GridEntity> = [];

    override public function new() {
        super();
        
        var grid = new Grid(50, 50, 32.0, 16.0);
        add(grid, 0);

        var player: Player = PlayerFactory.create_dev();

        grid.add_entity_at(player, new GridCoord(10, 10));

        printTree(this);
    }

    function printTree(obj: h2d.Object, indent: String = ""): Void {
        trace(indent + obj.name + " (" + Type.getClassName(Type.getClass(obj)) + ")");
        for (i in 0...obj.numChildren) {
            printTree(obj.getChildAt(i), indent + "  ");
        }
    }
}