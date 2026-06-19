package entities;

import signals.Signal;
import grid.Grid;
import h2d.col.Point;
import signals.IOnUpdate;
import signals.IOnDestroy;
import h2d.Object;
import signals.IOnEntityReady;
import shared.Types.GridCoord;
import components.Component.EntityComponent;

class GridEntity extends Object{
    var coord: GridCoord;
    var components: Map<String, EntityComponent> = new Map();

    var is_ready: Bool = false;
    var on_ready: SignalWithArg<GridEntity> = new SignalWithArg<GridEntity>();
    var on_destroy: Signal = new Signal();

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

    public function get_coord(): GridCoord {
        return coord;
    }

    public function apply_coord() {
        var new_pos: Point = Grid.current_grid.grid_coord_to_position(coord);
        x = new_pos.x;
        y = new_pos.y;
    }

    public function ready(): GridEntity {
        if (is_ready) return this;

        porocess_entity_events();

        on_ready.emit(this);
        
        is_ready = true;

        return this;
    }

    public function destroy(): Void {
        on_destroy.emit();
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

    function porocess_entity_events() {
        var on_ready_components: Array<IOnEntityReady> = get_components_with_event(IOnEntityReady);
        for (component in on_ready_components) {
            on_ready.subscribe(component.on_entity_ready);
        }

        var on_destroy_components: Array<IOnDestroy> = get_components_with_event(IOnDestroy);
        for (component in on_destroy_components) {
            on_destroy.subscribe(component.on_destroy);
        } 
    }    
}