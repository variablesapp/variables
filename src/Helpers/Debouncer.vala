public class Variables.Debouncer : GLib.Object {
    public static Variables.Debouncer instance {
        get {
            return _instance.once (() => new Variables.Debouncer ());
        }
    }

    public delegate void DebounceHandler ();

    private static GLib.Once<Variables.Debouncer> _instance;
    private Gee.HashMap<string, TimeoutSource> timeout_source_map;

    construct {
        timeout_source_map = new Gee.HashMap<string, TimeoutSource> ();
    }

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
        timeout_source_map[key] = timeout_source;

        timeout_source.set_callback (() => {
            function ();
            if (timeout_source_map[key] != null) {
                timeout_source_map.unset (key);
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
        print ("Hashtable length: %d\n", timeout_source_map.keys.size);
        print ("Hashtable:\n");
        this.timeout_source_map.foreach ((entry) => {
            print ("Key: %s\n", entry.key);
            return true;
        });

        if (timeout_source_map[key] != null) {
            print ("Timeout exists!\n");
            var doomed_timeout_source = timeout_source_map[key];
            timeout_source_map.unset (key);
            doomed_timeout_source.destroy ();
            
            return true;
        }
        
        print ("Timeout doesn't exist!\n");
        return false;
    }

    private Debouncer () {}
}