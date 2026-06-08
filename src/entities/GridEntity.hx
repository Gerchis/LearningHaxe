package entities;

import components.interfaces.IOnEntityReady;
import shared.Types.GridCoord;
import components.Component.EntityComponent;

class GridEntity {
    var cood: GridCoord;
    var components: Map<String, EntityComponent> = new Map();

    var is_ready: Bool = false;
    var on_ready: Array<IOnEntityRedy> = [];

    public function new() {}

    public function add_component(new_component: EntityComponent): GridEntity{
        if (components.exists(new_component.get_name())) return this;

        components.set(new_component.get_name(), new_component);

        return this;
    }

    public function has_component<T:EntityComponent>(component_class: Class<T>): Bool {
        var k: String = Type.getClassName(component_class);
        return components.exists(k);
    }

    public function ready(): Void {
        if (is_ready) return;

        subscribe_events();

        emit_event(on_ready, (f: IOnEntityRedy)-> f.on_entity_redy(this));

        is_ready = true;
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
        on_ready = get_components_with_event(IOnEntityRedy);
    }

    function emit_event<T>(events: Array<T>, caller: T -> Void): Void {
        for (event in events){
            caller(event);
        }
    }
}