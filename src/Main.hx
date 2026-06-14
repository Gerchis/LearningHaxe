import signals.Signal.SignalWithArg;
import signals.IOnUpdate;
import scenes.DevScene;
import hxd.Res;

class Main extends hxd.App {
    public static var app: Main;
    public var on_update: SignalWithArg<Float> = new SignalWithArg<Float>();

    override function init() {
        super.init();
        Res.initEmbed();

        s2d = new DevScene();
    }

    override function update(dt:Float) {
        super.update(dt);

        on_update.emit(dt);
    }

    static function main() {
        app = new Main();
    }
}