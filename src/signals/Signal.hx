package signals;

class Signal<T> {
    var listeners: Array<T -> Void> = [];

    public function new() {}

    public function subscrive(event: T->Void) {
        listeners.push(event);
    }
}