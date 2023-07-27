public class Variables.TemplateEditor : Gtk.Widget {    
    private Gtk.StackSwitcher stack_switcher;
    private Gtk.Stack text_entry_stack;
    static construct {
        set_layout_manager_type (typeof (Gtk.BoxLayout));
    }

    construct {
        var box_layout = (Gtk.BoxLayout)this.layout_manager;
        box_layout.orientation = Gtk.Orientation.VERTICAL;

        text_entry_stack = new Gtk.Stack () {
            vexpand = true,
            hexpand = true
        };

        text_entry_stack.add_titled (create_text_area ("Hi, I'm an input"), "Input", "Input");
        text_entry_stack.add_titled (create_text_area ("Hi, I'm an output!"), "Output", "Output");

        stack_switcher = new Gtk.StackSwitcher () {
            stack = text_entry_stack,
            halign = Gtk.Align.CENTER
        };
 
        this.stack_switcher.set_parent (this);
        this.text_entry_stack.set_parent (this);
    }

    protected override void dispose () {
        this.stack_switcher.unparent ();
        this.text_entry_stack.unparent ();
    }

    private Gtk.ScrolledWindow create_text_area (string default_text) {
        var text_view = new Gtk.TextView () {
            wrap_mode = Gtk.WrapMode.WORD_CHAR
        };

        text_view.buffer.text = default_text;

        var scroll_wrapper = new Gtk.ScrolledWindow () {
            hscrollbar_policy = Gtk.PolicyType.NEVER,
            child = text_view,
            vexpand = true,
            hexpand = true
        };

        return scroll_wrapper;
    }
}