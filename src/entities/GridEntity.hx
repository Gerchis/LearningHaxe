package entities;

import grid.Grid;
import h2d.col.Point;
import components.interfaces.IOnUpdate;
import components.interfaces.IOnDestroy;
import h2d.Object;
import components.interfaces.IOnEntityReady;
import shared.Types.GridCoord;
import components.Component.EntityComponent;

class GridEntity extends Object{
    var coord: GridCoord;
    var components: Map<String, EntityComponent> = new Map();

    var is_ready: Bool = false;
    var on_ready: Array<IOnEntityReady> = [];
    var on_update: Array<IOnUpdate> = [];
    var on_destroy: Array<IOnDestroy> = [];

    public function add_component(new_component: EntityComponent): GridEntity{
        if (components.exists(new_component.get_name())) return this;

        components.set(new_component.get_name(), new_component);

        return this;
    }

    public function has_component<T:EntityComponent>(component_class: Class<T>): Bool {
        var k: String = Type.getClassName(component_class);
        return components.exists(k);
    }

    public function get_component<T:EntityComponent>(component_class: Class<T>): Null<T> {
        var k: String = Type.getClassName(component_class);
        return cast components.get(k);
    }

    public function set_coord(new_coord: GridCoord) {
        coord = new_coord;
    }

    public function apply_coord() {
        var new_pos: Point = Grid.current_grid.grid_ccord_to_position(coord);
        x = new_pos.x;
        y = new_pos.y;
    }

    public function ready(): GridEntity {
        if (is_ready) return this;

        subscribe_events();

        emit_event(on_ready, (f: IOnEntityReady)-> f.on_entity_ready(this));
        
        is_ready = true;

        return this;
    }

    public function update(delta: Float) {
        emit_event(on_update, (f: IOnUpdate)-> f.on_update(delta));
    }

    public function destroy(): Void {
        emit_event(on_destroy, (f: IOnDestroy) -> f.on_destroy());
    }

    function get_components_with_event<T>(event: Class<T>): Array<T> {
        var result: Array<T> = [];

        for (component in components){
            if (Std.isOfType(component, event)){
                result.push(cast component);
            }
        }

        return result;
    }

    function subscribe_events() {
        on_ready = get_components_with_event(IOnEntityReady);
        on_update = get_components_with_event(IOnUpdate);
        on_destroy = get_components_with_event(IOnDestroy);
    }

    function emit_event<T>(events: Array<T>, caller: T -> Void): Void {
        for (event in events){
            caller(event);
        }
    }
}