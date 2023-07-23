public class Variables.TemplateEditor : Gtk.Box {    
    construct {
        this.orientation = Gtk.Orientation.VERTICAL;

        var text_entry_stack = new Gtk.Stack () {
            vexpand = true,
            hexpand = true
        };

        text_entry_stack.add_titled (create_text_area ("Hi, I'm an input"), "Input", "Input");
        text_entry_stack.add_titled (create_text_area ("Hi, I'm an output!"), "Output", "Output");

        var stack_switcher = new Gtk.StackSwitcher () {
            stack = text_entry_stack,
            halign = Gtk.Align.CENTER
        };
 
        this.append (stack_switcher);
        this.append (text_entry_stack);
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