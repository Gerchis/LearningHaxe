package signals;

class Signal {
    var listeners: Array<() -> Void> = [];

    public function new() {}

    public function subscribe(event: ()->Void) {
        listeners.push(event);
    }

    public function unsubscribe(event: ()->Void) {
        listeners.remove(event);
    }

    public function emit() {
        for (event in listeners.copy()){
            event();
        }
    }
}


class SignalWithArg<T> {
    var listeners: Array<T -> Void> = [];

    public function new() {}

    public function subscribe(event: T->Void) {
        listeners.push(event);
    }

    public function unsubscribe(event: T->Void) {
        listeners.remove(event);
    }

    public function emit(value:T) {
        for (event in listeners.copy()){
            event(value);
        }
    }
}