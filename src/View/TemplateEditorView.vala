public class Variables.TemplateEditorView : Gtk.Widget {    
    public Variables.TemplateEditorViewModel view_model { get; construct; }

    private Gtk.StackSwitcher stack_switcher;
    private Gtk.Stack text_entry_stack;
    static construct {
        set_layout_manager_type (typeof (Gtk.BoxLayout));
    }

    construct {
        var box_layout = (Gtk.BoxLayout)this.layout_manager;
        box_layout.orientation = Gtk.Orientation.VERTICAL;

        this._view_model = (Variables.TemplateEditorViewModel) Variables.Application.container.get (typeof(Variables.TemplateEditorViewModel));

        text_entry_stack = new Gtk.Stack () {
            vexpand = true,
            hexpand = true
        };

        var input_text_view_scrolled_window = create_text_area ("Hi, I'm an input");
        var output_text_view_scrolled_window = create_text_area ("Hi, I'm an output!");

        var input_text_view = (Gtk.TextView) input_text_view_scrolled_window.child;
        input_text_view.buffer.text = this.view_model.content ?? input_text_view.buffer.text;
        
        
        input_text_view.buffer.bind_property ("text", this.view_model, "content", GLib.BindingFlags.BIDIRECTIONAL);
        
        text_entry_stack.add_titled (input_text_view_scrolled_window, "Input", "Input");
        text_entry_stack.add_titled (output_text_view_scrolled_window, "Output", "Output");

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