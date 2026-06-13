import components.interfaces.IOnUpdate;
import scenes.DevScene;
import hxd.Res;

class Main extends hxd.App {
    public static var app: Main;

    override function init() {
        super.init();
        Res.initEmbed();

        s2d = new DevScene();
    }

    override function update(dt:Float) {
        super.update(dt);

        if (Std.isOfType(s2d, IOnUpdate)) {
            var scene_to_update: IOnUpdate = cast s2d;
            scene_to_update.on_update(dt);
        }
    }

    static function main() {
        app = new Main();
    }
}