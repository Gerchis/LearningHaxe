package components;

import components.Component.EntityComponent;

class DebugComponent extends EntityComponent {
    public function new() {
        trace("New " + get_name());
    }
}