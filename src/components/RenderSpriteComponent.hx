package components;

import h2d.Object;
import entities.GridEntity;
import components.interfaces.IOnEntityReady;
import hxd.res.Image;
import h2d.Bitmap;
import h2d.Tile;
import components.Component.EntityComponent;

class RenderSpriteComponent extends EntityComponent implements IOnEntityReady {
    public var texture: Tile;
    var sprite: Bitmap;
    var component_object: Object;

    public function new(image: Image) {
        set_texture(image);
    }

    public function set_texture(image: Image) {
        texture = image.toTile();
    }

    public function on_entity_ready(entity: GridEntity) {
        sprite = new Bitmap(texture);

        texture.dx = -Std.int(texture.width / 2.0);
        texture.dy = -Std.int(texture.height / 2.0);

        entity.addChild(sprite);
    }
}