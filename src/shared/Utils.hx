package shared;

import signals.Signal;

class Timer {
    var time: Float;
    
    public var time_remaining(default, null): Float;
    public var is_paused(default, null): Bool = true;
    public var timeout: Signal = new Signal();

    public function new(time: Float = 0.0, autostart: Bool = false) {
        this.time = time;
        this.time_remaining = time;
        is_paused = !autostart;

        Main.app.on_update.subscribe(update_timer);
    }

    public function start(new_time: Null<Float> = null) {
        if (new_time != null) {
            time = new_time;
        }

        time_remaining = time;
        is_paused = false;
    }

    public function pause() {
        is_paused = true;
    }

    public function resume() {
        is_paused = false;
    }

    function update_timer(delta: Float) {
        if (time_remaining <= 0.0) {
            is_paused = true;
            return;
        }

        time_remaining -= delta;

        if (time_remaining > 0.0) return;

        is_paused = true;
        time_remaining = 0.0;
        timeout.emit();
    }
}