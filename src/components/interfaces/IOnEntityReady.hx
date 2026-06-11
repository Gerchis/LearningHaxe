package components.interfaces;

import entities.GridEntity;

interface IOnEntityReady {
    public function on_entity_ready(entity: GridEntity): Void;
}