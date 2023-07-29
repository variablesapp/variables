public class Variables.TemplateView : Gtk.Widget {    
    public Variables.TemplateViewModel view_model { get; construct; }

    private Gtk.StackSwitcher stack_switcher;
    private Gtk.Stack text_entry_stack;
    static construct {
        set_layout_manager_type (typeof (Gtk.BoxLayout));
    }

    construct {
        var box_layout = (Gtk.BoxLayout)this.layout_manager;
        box_layout.orientation = Gtk.Orientation.VERTICAL;

        this._view_model = (Variables.TemplateViewModel) Variables.Application.container.get (typeof(Variables.TemplateViewModel));

        text_entry_stack = new Gtk.Stack () {
            vexpand = true,
            hexpand = true,
            transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT,
        };

        var input_text_view = create_text_view ();
        input_text_view.buffer.text = this.view_model.input_content ?? input_text_view.buffer.text;
        
        var output_text_view = create_text_view ();
        
        this.view_model.bind_property ("current-view-name", text_entry_stack, "visible-child-name", GLib.BindingFlags.BIDIRECTIONAL);
        this.view_model.bind_property ("input-content", input_text_view.buffer, "text", GLib.BindingFlags.BIDIRECTIONAL);
        this.view_model.bind_property ("output-content", output_text_view.buffer, "text", GLib.BindingFlags.DEFAULT);
        
        text_entry_stack.add_titled (scroll_wrap_widget(input_text_view), Config.TEMPLATE_INPUT_PAGE_NAME, "Input");
        text_entry_stack.add_titled (scroll_wrap_widget(output_text_view), Config.TEMPLATE_OUTPUT_PAGE_NAME, "Output");

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

    private Gtk.TextView create_text_view () {
        var text_view = new Gtk.TextView () {
            wrap_mode = Gtk.WrapMode.WORD_CHAR
        };

        return text_view;
    }

    private Gtk.ScrolledWindow scroll_wrap_widget (Gtk.Widget widget) {
        var scroll_wrapper = new Gtk.ScrolledWindow () {
            hscrollbar_policy = Gtk.PolicyType.NEVER,
            child = widget,
            vexpand = true,
            hexpand = true
        };

        return scroll_wrapper;
    }
}