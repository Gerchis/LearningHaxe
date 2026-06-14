package components;

import entities.GridEntity;
import signals.IOnEntityReady;
import signals.IOnUpdate;
import h2d.col.Point;
import components.Component.EntityComponent;

class MoverComponent extends EntityComponent implements IOnEntityReady implements IOnUpdate{
    public var vector_reciver: ()->Point;

    var root_entity: GridEntity;

    public function new(){
        Main.app.on_update.subscribe(on_update);
    };

    public function on_entity_ready(entity: GridEntity) {
        root_entity = entity;
    }

    public function on_update(delta: Float) {
        if (vector_reciver == null || root_entity == null) return;

        var movement: Point = vector_reciver();
        trace(movement);
        root_entity.move(movement.x * 10.0, movement.y * 10.0);
    }
}