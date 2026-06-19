package components;

import shared.Utils.Timer;
import grid.Grid;
import shared.Types.GridCoord;
import entities.GridEntity;
import signals.IOnEntityReady;
import signals.IOnUpdate;
import h2d.col.Point;
import components.Component.EntityComponent;

enum MovementDirection {
        UP;
        DOWN;
        RIGHT;
        LEFT;
}

class MoverComponent extends EntityComponent implements IOnEntityReady implements IOnUpdate{
    public var vector_reciver: ()->Point;

    var root_entity: GridEntity;
    var cooldown_timer: Timer = new Timer();

    var last_direction: MovementDirection = MovementDirection.RIGHT;

    public function new(){
        Main.app.on_update.subscribe(on_update);
    }

    public function on_entity_ready(entity: GridEntity) {
        root_entity = entity;
    }

    public function on_update(delta: Float) {
        if (!cooldown_timer.is_paused) return;

        if (vector_reciver == null || root_entity == null) return;

        var movement: Point = vector_reciver();
        
        if (movement.equals(new Point(0.0, 0.0))) return;

        last_direction = get_direction(movement);
        var pos: GridCoord = root_entity.get_coord();

        switch (last_direction) {
            case RIGHT:
                pos.x += 1;
            case LEFT:
                pos.x -= 1;
            case UP:
                pos.y += 1;
            case DOWN:
                pos.y -= 1;
        }

        var final_pos: Point = Grid.current_grid.grid_coord_to_position(pos);
        root_entity.setPosition(final_pos.x, final_pos.y);
        cooldown_timer.start(1.0);
    }

    function get_direction(movement: Point): MovementDirection {
        var horizontal_dot: Float = new Point(1.0, 0.0).dot(movement);
        var vertical_dot: Float = new Point(0.0, 1.0).dot(movement);

        if (horizontal_dot < -0.75) {
            return MovementDirection.LEFT;
        }
        else if (horizontal_dot < -0.25) {
            if (vertical_dot > 0.0) {
                if (last_direction == MovementDirection.UP) return MovementDirection.LEFT;
                return MovementDirection.UP;
            }
            else {
                if (last_direction == MovementDirection.DOWN) return MovementDirection.LEFT;
                return MovementDirection.DOWN;
            }
        }
        else if (horizontal_dot < 0.25) {
            if (vertical_dot > 0.0) {
                return MovementDirection.UP;
            }
            else {
                return MovementDirection.DOWN;
            }
        }
        else if (horizontal_dot < 0.75) {
            if (vertical_dot > 0.0) {
                if (last_direction == MovementDirection.UP) return MovementDirection.RIGHT;
                return MovementDirection.UP;
            }
            else {
                if (last_direction == MovementDirection.DOWN) return MovementDirection.RIGHT;
                return MovementDirection.DOWN;
            }
        }
        else {
            return MovementDirection.RIGHT;
        }
    }
}