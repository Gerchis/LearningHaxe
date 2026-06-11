import components.InputComponent;
import components.DebugComponent;
import components.RenderSpriteComponent;
import components.MoverComponent;
import entities.GridEntity;
import hxd.Res;

class Main extends hxd.App {
    public static var app: Main;

    var test_entity: GridEntity; //TODO: Array de entidades o arbol de escena

    override function init() {
        super.init();
        Res.initEmbed();

        var tf = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
        tf.text = "Hello Hashlink!";

        test_entity = new GridEntity()
        .add_component(new DebugComponent())
        .add_component(new RenderSpriteComponent(Res.haxe_logo))
        .add_component(new InputComponent())
        .add_component(new MoverComponent())
        .ready();
    }

    override function update(dt:Float) {
        super.update(dt);

        test_entity.update(dt);
    }

    static function main() {
        app = new Main();
    }
}