package components;

class EntityComponent {
    public function get_name(): String {
        return Type.getClassName(Type.getClass(this));
    }
}

