package components;

import entities.GridEntity;
import components.interfaces.IOnEntityReady;
import h2d.col.Point;
import globals.InputMap;
import components.interfaces.IOnDestroy;
import hxd.Event;
import hxd.Window;
import components.Component.EntityComponent;

class InputComponent extends EntityComponent implements IOnEntityReady implements IOnDestroy{

    public var is_move_up_pressed:Bool = false;
    public var is_move_down_pressed:Bool = false;
    public var is_move_right_pressed:Bool = false;
    public var is_move_left_pressed:Bool = false;

    var movement_vector: Point = new Point();

    public function new() {
        Window.getInstance().addEventTarget(on_event);
    }

    public function on_entity_ready(entity: GridEntity) {
        var mover: MoverComponent = entity.get_component(MoverComponent);
        if (mover != null){
            mover.vector_reciver = get_movement_vector;
        }
    }

    public function on_destroy() {
        Window.getInstance().removeEventTarget(on_event);
    }

    public function get_movement_vector(): Point{
        return movement_vector;
    }

    function on_event(event: Event) {
        process_event(event);

        process_movement_vector();
    }

    function process_event(event: Event) {
        if (event.keyCode == InputMap["move_up"]) {
            is_move_up_pressed = (event.kind == EKeyDown);
        }

        if (event.keyCode == InputMap["move_down"]) {
            is_move_down_pressed = (event.kind == EKeyDown);
        }

        if (event.keyCode == InputMap["move_right"]) {
            is_move_right_pressed = (event.kind == EKeyDown);
        }

        if (event.keyCode == InputMap["move_left"]) {
            is_move_left_pressed = (event.kind == EKeyDown);
        }
    }

    function process_movement_vector() {
        var new_vector: Point = new Point(0.0, 0.0);

        if (is_move_up_pressed) new_vector.y -= 1.0;
        if (is_move_down_pressed) new_vector.y += 1.0;
        if (is_move_right_pressed) new_vector.x += 1.0;
        if (is_move_left_pressed) new_vector.x -= 1.0;

        movement_vector = new_vector.normalized();
    }
}