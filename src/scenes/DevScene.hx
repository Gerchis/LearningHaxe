package scenes;

import shared.Types.GridCoord;
import grid.Grid;
import components.interfaces.IOnUpdate;
import h2d.Scene;
import hxd.Res;
import components.MoverComponent;
import components.InputComponent;
import components.RenderSpriteComponent;
import components.DebugComponent;
import entities.GridEntity;

class DevScene extends Scene implements IOnUpdate{
    var test_entity: GridEntity;
    var entities: Array<GridEntity> = [];

    override public function new() {
        super();

        var grid: Grid = new Grid(50, 50, 32.0, 16.0, this);

        var new_entity: GridEntity = new GridEntity()
        .add_component(new DebugComponent())
        .add_component(new RenderSpriteComponent(Res.haxe_logo))
        .add_component(new InputComponent())
        .add_component(new MoverComponent())
        .ready();

        grid.add_entity_at(new_entity, new GridCoord(1,1));
        addChild(new_entity);
        entities.push(new_entity);
    }

    public function on_update(delta:Float) {
    }
}