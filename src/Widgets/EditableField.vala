public class Variables.EditableField : Gtk.Widget {
    public string entry_text { get; construct set; }
    public string label_name { get; construct set; }
    public bool is_label_editable { get; construct set; }
    public Gee.ArrayList<Gtk.Button> additional_buttons { get; construct; }

    public signal void changed (Variables.EditableFieldChangeType change_type, string new_content);

    private Gtk.EditableLabel editable_label;
    private Gtk.Entry entry_field;
    private Gtk.Button edit_button;
    private Gtk.Box label_box;

    static construct {
        set_layout_manager_type (typeof (Gtk.BoxLayout));
    }

    construct {
        var box_layout = (Gtk.BoxLayout)this.layout_manager;
        box_layout.orientation = Gtk.Orientation.VERTICAL;

        this.halign = Gtk.Align.START;

        this.editable_label = new Gtk.EditableLabel ("New Label") {
            halign = Gtk.Align.START,
            editable = false,
        };

        this.entry_field = new Gtk.Entry () {
            hexpand = true
        };

        this.editable_label.bind_property ("text", this, "label-name", GLib.BindingFlags.BIDIRECTIONAL);
        this.entry_field.bind_property ("text", this, "entry-text", GLib.BindingFlags.BIDIRECTIONAL);

        this.editable_label.changed.connect ( () => this.changed (Variables.EditableFieldChangeType.Name, this.editable_label.text));
        this.entry_field.changed.connect (() => this.changed (Variables.EditableFieldChangeType.Value, this.entry_field.text));

        this.edit_button = new Gtk.Button.from_icon_name ("edit-symbolic") {
            halign = Gtk.Align.START
        };

        this._additional_buttons = new Gee.ArrayList<Gtk.Button> ();

        this.label_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 4);
        this.label_box.append (this.editable_label);
        this.label_box.append (this.edit_button);

        this.label_box.set_parent (this);
        this.entry_field.set_parent (this);
    }

    public void add_extra_button (Gtk.Button button) {
        this.additional_buttons.add (button);
        this.label_box.append (button);
    }

    protected override void dispose () {
        this.label_box.unparent ();
        this.entry_field.unparent ();

        base.dispose ();
    }
}