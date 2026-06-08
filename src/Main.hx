import components.DebugComponent;
import entities.GridEntity;

class Main extends hxd.App {
    override function init() {
        var tf = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
        tf.text = "Hello Hashlink!";

        var e = new GridEntity();
        e.add_component(new DebugComponent());
    }
    static function main() {
        new Main();
    }
}