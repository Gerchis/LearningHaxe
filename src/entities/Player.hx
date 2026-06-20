package entities;

import components.MoverComponent;
import components.InputComponent;
import hxd.Res;
import components.RenderSpriteComponent;
import components.DebugComponent;

class Player extends GridEntity {
    public function new() {
        super();
    }
}

class PlayerFactory {

    public static function create_dev(): Player {
        var player: Player = new Player();

        player.add_component(new DebugComponent())
        .add_component(new RenderSpriteComponent(Res.char))
        .add_component(new InputComponent())
        .add_component(new MoverComponent())
        .ready();
        trace(player);
        return player;
    }
}