public class Variables.Debouncer : GLib.Object {
    public static Variables.Debouncer instance {
        get {
            return _instance.once (() => new Variables.Debouncer ());
        }
    }

    public delegate void DebounceHandler ();

    private static GLib.Once<Variables.Debouncer> _instance;
    private Gee.HashMap<string, TimeoutSource> _timeout_source_map;

    construct {
        this._timeout_source_map = new Gee.HashMap<string, TimeoutSource> ();
    }

    private Debouncer () {}

    /**
    * Delays a function from being called
    *
    * @param function function to run
    * @param delay In milliseconds.
    * @param key Used to identify the function
    */
    public void debounce (DebounceHandler function, int delay, string key) {
        this.cancel (key);

        var timeout_source = new TimeoutSource (delay);
        this._timeout_source_map[key] = timeout_source;

        timeout_source.set_callback (() => {
            function ();
            if (this._timeout_source_map[key] != null) {
                this._timeout_source_map.unset (key);
            }
            return Source.REMOVE;
        });

        timeout_source.attach (MainContext.ref_thread_default ());
    }

    /**
    * Check if a function is being debounced already using
    * the key used to queue it.
    * 
    * Cancel the debounced function call if true.
    *
    * @param key Used to identify the function. 
    */
    public bool cancel (string key) {
        this._timeout_source_map.foreach ((entry) => {
            return true;
        });

        if (_timeout_source_map[key] != null) {
            var doomed_timeout_source = this._timeout_source_map[key];
            this._timeout_source_map.unset (key);
            doomed_timeout_source.destroy ();

            return true;
        }

        return false;
    }
}